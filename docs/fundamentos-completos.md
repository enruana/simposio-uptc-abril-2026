# Fundamentos Completos — Ponencia Simposio UPTC 2026

**Objetivo:** Documento de estudio profundo para que Felipe domine cada tema de la ponencia a nivel experto.  
**Estructura:** 3 secciones (una por acto) + anexo MCP como material complementario.  
**Fecha:** Abril 2026

> **Nota:** MCP fue removido como acto principal. Su contenido se conserva al final como Anexo A para preguntas del publico o referencia complementaria.

---

# PARTE 1: Arquitectura de Agentes de IA (Claude Code como referencia)

## 2.1 Que es un Agent Loop

Un agente de IA no es un modelo que responde una vez. Es un **loop** que ejecuta repetidamente:

```
1. Recibe input del usuario → agrega al array de mensajes
2. Envia mensajes al modelo con system prompt
3. El modelo responde (puede pedir usar herramientas)
4. Si pide herramientas:
   → Verifica permisos
   → Ejecuta la herramienta
   → Agrega resultado al array
   → Vuelve al paso 2
5. Si NO pide herramientas → termina
```

**El unico estado es un array de mensajes.** No hay state machine, no hay workflow graph. Esto fue revelado en la filtracion: el loop central de Claude Code son ~88 lineas de codigo.

**Por que es poderoso:**
- Simplicidad = robustez (menos cosas que pueden fallar)
- Replay facil (puedes reanudar desde cualquier punto)
- Compresion natural (puedes resumir mensajes viejos)
- El modelo decide cuando parar (terminacion model-driven)

## 2.2 Como funciona Tool Calling (Function Calling)

Cuando usas un modelo directamente (API), le envias texto y recibes texto. Con tool calling, el flujo es:

**Paso 1: Defines herramientas en el request**
```json
{
  "model": "claude-opus-4-6",
  "tools": [{
    "name": "bash",
    "description": "Execute a bash command",
    "input_schema": {
      "type": "object",
      "properties": {
        "command": { "type": "string" }
      },
      "required": ["command"]
    }
  }],
  "messages": [{"role": "user", "content": "Lista los archivos del directorio actual"}]
}
```

**Paso 2: El modelo responde con `tool_use`**
```json
{
  "stop_reason": "tool_use",
  "content": [{
    "type": "tool_use",
    "id": "toolu_01A09q90qw90lq917835lq9",
    "name": "bash",
    "input": { "command": "ls -la" }
  }]
}
```

**Paso 3: Tu codigo ejecuta la herramienta y devuelve el resultado**
```json
{
  "role": "user",
  "content": [{
    "type": "tool_result",
    "tool_use_id": "toolu_01A09q90qw90lq917835lq9",
    "content": "total 48\ndrwxr-xr-x  5 user user 4096 ...\nideas-ponencia.md\n..."
  }]
}
```

**Paso 4: El modelo procesa el resultado y decide que hacer**
- Puede pedir otra herramienta (vuelve al loop)
- Puede responder al usuario (termina el turno)

## 2.3 POR QUE Claude Code ≠ Opus 4.6 en Cursor

### La diferencia fundamental

```
Usar Opus 4.6 directamente (API/Cursor):
  = Un cerebro brillante sentado en una silla
  → Piensa, pero no puede moverse, ni abrir archivos, ni ejecutar comandos
  → Le pasas texto, te devuelve texto. Fin.

Usar Claude Code:
  = Ese mismo cerebro + un cuerpo completo
  → Lee tu codigo, lo edita, ejecuta tests, navega tu repo,
    crea sub-agentes, recuerda entre sesiones, decide cuando parar
  → Tiene ~40 herramientas, permisos, sandbox, memoria persistente
```

### Las 7 capas que hacen la diferencia

**Capa 1: ~40 herramientas especializadas**

| Categoria | Herramientas | Que permiten |
|-----------|-------------|-------------|
| Archivos | Read, Edit, Write, Glob | Leer, editar, crear, buscar archivos |
| Ejecucion | Bash | Ejecutar cualquier comando en terminal |
| Busqueda | Grep, Glob, LSP | Buscar en codigo, navegar definiciones, encontrar referencias |
| Subagentes | Agent, SendMessage | Crear agentes que trabajan en paralelo |
| Web | WebSearch, WebFetch | Buscar y leer contenido de internet |
| MCP | mcp__*__* | Conectarse a CUALQUIER herramienta externa via MCP |
| Memoria | Auto Memory, CLAUDE.md | Recordar entre sesiones |
| Notebooks | NotebookEdit | Editar Jupyter notebooks |

Cuando usas Opus en Cursor, el IDE le da unas pocas herramientas basicas. Claude Code le da 40+ herramientas con schemas JSON detallados.

**Capa 2: Sistema de permisos de 3 niveles**

| Nivel | Ejemplo | Accion |
|-------|---------|--------|
| Tier 1: Auto-aprobado | Leer archivos, buscar texto | Se ejecuta sin preguntar |
| Tier 2: Confirmacion | Editar archivos, comandos shell | Pregunta al usuario |
| Tier 3: Bloqueo | Acceso fuera del directorio, exfiltracion | Denegado siempre |

**Detalle critico:** En modo `auto`, un **clasificador de seguridad independiente** (otra instancia de Sonnet 4.6) evalua si la accion es segura. Este clasificador **deliberadamente no ve la prosa del agente** para evitar prompt injection. Si el agente dice "necesito borrar este archivo para ayudarte", el clasificador no ve esa justificacion — solo ve "bash: rm -rf /path". Razonamiento y autorizacion son independientes.

**Capa 3: Memoria de 3 capas**

| Capa | Almacena | Carga |
|------|----------|-------|
| Index | Punteros ligeros (~150 chars) | Siempre (cada turno) |
| Topic Files | Conocimiento real por tema | Bajo demanda |
| Transcripts | Historial completo | Solo via grep |

Cursor empieza de cero cada sesion. Claude Code recuerda patrones de tu codebase, decisiones de debugging, y preferencias entre sesiones.

**Capa 4: Compactacion de contexto (5 estrategias)**

Al ~98% de la ventana de contexto:
1. Microcompact: elimina outputs de herramientas grandes primero
2. Full compact: resume toda la conversacion
3. Session memory compact: preserva metadata critica
4. Auto-compaction con limite de fallos (max 3 reintentos)
5. Customizable via CLAUDE.md (reinyectado post-compactacion)

**Capa 5: Subagentes con aislamiento**

Claude Code puede crear agentes hijos con:
- Contexto aislado (no contaminan la sesion principal)
- Herramientas restringidas (ej: agente de auditoria = solo lectura)
- Ejecucion en paralelo
- Worktrees de Git (ramas temporales)
- Tres modelos: fork (copia exacta), teammate (con tmux), worktree (git aislado)

**Capa 6: Optimizacion de prompt cache**

`SYSTEM_PROMPT_DYNAMIC_BOUNDARY` separa el prompt en:
- **Seccion estatica**: instrucciones que no cambian → se cachean
- **Seccion dinamica**: contexto que cambia cada turno

Secciones marcadas `DANGEROUS_uncachedSystemPromptSection` advierten a ingenieros del costo de romper la cache. Esto ahorra dinero masivamente.

**Capa 7: Sandbox a nivel de OS**

- macOS: Seatbelt isolation
- Linux: bubblewrap (bwrap)
- Los procesos hijos heredan las restricciones
- Incluso si el modelo quisiera escapar, el **kernel** lo impide
- Esto no existe en Cursor ni en ningun IDE convencional

### El dato que lo prueba todo

Un benchmark mostro que una misma tarea consumio **188K tokens en Cursor** y solo **33K tokens en Claude Code** — **5.7x mas eficiente** usando el mismo modelo Opus 4.6. La diferencia es 100% la orquestacion.

### Diagrama para la ponencia (1 slide)

```
┌─────────────────────────────────────────────────────────┐
│              MODELO (Opus 4.6, GPT-5.4, etc.)           │
│         "El cerebro" — razona, genera, decide           │
├─────────────────────────────────────────────────────────┤
│          HARNESS / ORQUESTADOR (Claude Code)            │
│  "El cuerpo" — 512,000 lineas reveladas:                │
│                                                         │
│  ┌──────────┐ ┌──────────┐ ┌──────────────┐            │
│  │ 40 Tools │ │ Permisos │ │ Memoria 3cap │            │
│  │ Read     │ │ Tier 1-3 │ │ Index        │            │
│  │ Edit     │ │ Sandbox  │ │ Topics       │            │
│  │ Bash     │ │ Auto-    │ │ Transcripts  │            │
│  │ Agent    │ │ classify │ │              │            │
│  │ MCP...   │ │          │ │              │            │
│  └──────────┘ └──────────┘ └──────────────┘            │
│  ┌──────────┐ ┌──────────┐ ┌──────────────┐            │
│  │ Context  │ │ Sub-     │ │ Prompt Cache │            │
│  │ Compact  │ │ Agents   │ │ Optimization │            │
│  │ 5 strats │ │ Parallel │ │ Static/Dyn   │            │
│  └──────────┘ └──────────┘ └──────────────┘            │
├─────────────────────────────────────────────────────────┤
│              TU CODIGO / TU PROYECTO                    │
│         Archivos, Git, Terminal, MCP servers             │
└─────────────────────────────────────────────────────────┘
```

**Mensaje clave:** *El modelo es intercambiable. La orquestacion es lo que crea la experiencia.*

### Lo que revelo la filtracion: funciones secretas

| Funcion | Que hace |
|---------|---------|
| **KAIROS** | Agente autonomo 24/7. Heartbeats: "anything worth doing right now?". Webhooks GitHub, cron 5 min, daemon workers. Sigue trabajando con el laptop cerrado. |
| **ULTRAPLAN** | Delega planificacion a sesion remota de Opus 4.6 por hasta 30 min |
| **/dream** | Destilacion nocturna de memoria. `autoDream` consolida aprendizaje nightly |
| **Anti-distillation** | Inyecta herramientas senuelo (fake tools) para envenenar datos de entrenamiento de competidores |
| **Undercover Mode** | Oculta toda traza de Anthropic en commits publicos. NO tiene opcion de desactivar |
| **DRM HTTP** | Attestation criptografica en Zig para verificar binarios autenticos |
| **44 feature flags** | Funciones construidas pero no activadas |

### Referencias arquitectura
- WaveSpeedAI (Harness): https://wavespeed.ai/blog/posts/claude-code-agent-harness-architecture/
- Penligent (Inside Claude Code): https://www.penligent.ai/hackinglabs/inside-claude-code-the-architecture-behind-tools-memory-hooks-and-mcp/
- DEV Community (Agent Loop): https://dev.to/brooks_wilson_36fbefbbae4/claude-code-architecture-explained-agent-loop-tool-system-and-permission-model-rust-rewrite-41b2
- Claude Code vs Cursor 2026: https://wavespeed.ai/blog/posts/claude-code-vs-cursor-2026/

---

# PARTE 2: Modelos Abiertos en Hardware Local

## 3.1 Tu hardware (lo que tienes para la demo)

| Componente | Especificacion |
|------------|---------------|
| CPU | AMD Ryzen 7 5700X (8 cores, 16 threads) |
| RAM | 16 GB DDR4 |
| GPU | NVIDIA RTX 3060 12GB VRAM |
| Disco | NVMe 446GB (367GB libres) |
| OS | Ubuntu 24.04 LTS, kernel 6.17 |

**Tu RTX 3060 con 12GB VRAM es clave** — es significativamente mas que los 8GB de la mayoria de laptops. Puedes correr modelos de hasta ~14B parametros sin cuantizacion, o modelos de ~26-30B con cuantizacion agresiva.

## 3.2 Que modelos puedes correr (tabla concreta)

### Modelos que SI corren bien en tu hardware

| Modelo | Params | Cuantizacion | VRAM | RAM | Tokens/s aprox | Nota |
|--------|--------|-------------|------|-----|----------------|------|
| **Gemma 4 E2B** | ~2B eff | Q4_K_M | ~2GB | ~4GB | 40-60 | Multimodal, muy rapido |
| **Gemma 4 E4B** | ~4B eff | Q4_K_M | ~3-4GB | ~6GB | 12-22 | **Recomendado para demo** |
| **Gemma 3 1B** | 1B | FP16 | ~2GB | ~3GB | 80+ | Ultra rapido |
| **Qwen 3 8B** | 8B | Q4_K_M | ~5GB | ~8GB | 45-55 | Mejor rendimiento general |
| **Qwen 3 14B** | 14B | Q4_K_M | ~9GB | ~12GB | 25-35 | Muy capaz, llena la GPU |
| **DeepSeek R1 8B** (distilled) | 8B | Q4_K_M | ~5GB | ~8GB | 35-50 | Muestra chain-of-thought visible |
| **Phi-4 mini 3.8B** | 3.8B | Q4_K_M | ~3GB | ~5GB | 40-55 | Fuerte en matematicas |
| **Phi-4 14B** | 14B | Q4_K_M | ~9GB | ~12GB | 20-35 | Fuerte en codigo |
| **Llama 3.2 3B** | 3B | Q4_K_M | ~2.5GB | ~5GB | 50-65 | Rapido, multilingue |
| **Mistral 7B** | 7B | Q4_K_M | ~5GB | ~8GB | 40-55 | Solido, general purpose |

### Modelos que NO corren en tu hardware

| Modelo | Por que no |
|--------|-----------|
| Gemma 4 26B MoE | Necesita ~18-24GB VRAM cuantizado |
| Gemma 4 31B Dense | Necesita ~16-24GB VRAM |
| Llama 4 Scout (109B MoE) | Necesita ~64GB+ |
| DeepSeek V3/R1 671B | Necesita cluster de GPUs |
| Qwen 3 32B+ | Necesita >16GB VRAM |

## 3.3 Ollama: Setup completo para tu maquina

### Instalacion
```bash
# Instalar Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Verificar que detecta tu RTX 3060
ollama --version
nvidia-smi  # Confirmar driver funcionando
```

### Descargar y correr modelos
```bash
# Descargar modelos (se guardan en ~/.ollama/models)
ollama pull gemma4:e4b          # Gemma 4 E4B (~3GB)
ollama pull qwen3:8b            # Qwen 3 8B (~5GB)
ollama pull deepseek-r1:8b      # DeepSeek R1 8B distilled (~5GB)
ollama pull phi4-mini            # Phi-4 mini 3.8B (~2.5GB)

# Correr un modelo (chat interactivo)
ollama run gemma4:e4b

# Listar modelos descargados
ollama list

# Ver modelos corriendo
ollama ps

# Eliminar un modelo
ollama rm nombre-del-modelo
```

### Usar la API REST (para integraciones)
```bash
# Chat simple
curl http://localhost:11434/api/chat -d '{
  "model": "gemma4:e4b",
  "messages": [{"role": "user", "content": "Explica que es MCP en 3 oraciones"}],
  "stream": false
}'

# API compatible con OpenAI (para usar con librerias existentes)
curl http://localhost:11434/v1/chat/completions -d '{
  "model": "gemma4:e4b",
  "messages": [{"role": "user", "content": "Hello"}]
}'
```

### Configuracion GPU
```bash
# Verificar que Ollama usa la GPU
OLLAMA_DEBUG=1 ollama run gemma4:e4b

# Si necesitas forzar GPU especifica
CUDA_VISIBLE_DEVICES=0 ollama serve
```

### Troubleshooting comun

| Problema | Solucion |
|----------|----------|
| GPU no detectada | Verificar `nvidia-smi`, reinstalar driver NVIDIA |
| OOM (Out of Memory) | Usar modelo mas pequeno o cuantizacion mas agresiva |
| Modelo lento | Verificar que usa GPU (`ollama ps` debe mostrar GPU%) |
| GPU loss tras suspend | `sudo systemctl restart ollama` |

## 3.4 Cuantizacion explicada (para entenderlo profundamente)

Cuantizacion = reducir la precision de los numeros que representan los pesos del modelo.

| Nivel | Bits | Calidad vs FP16 | Uso de memoria | Cuando usar |
|-------|------|-----------------|----------------|-------------|
| FP16 | 16 bits | 100% (referencia) | 2 bytes/param | Si cabe en tu GPU |
| Q8_0 | 8 bits | ~99.5% | 1 byte/param | Mejor calidad practica |
| Q6_K | 6 bits | ~99% | 0.75 bytes/param | Buen balance |
| **Q5_K_M** | 5 bits | ~98% | 0.625 bytes/param | **Sweet spot calidad/velocidad** |
| **Q4_K_M** | 4 bits | ~96-97% | 0.5 bytes/param | **Mas comun, recomendado** |
| Q3_K_M | 3 bits | ~93% | 0.375 bytes/param | Si necesitas ahorrar VRAM |
| Q2_K | 2 bits | ~85-88% | 0.25 bytes/param | Emergencia, calidad baja |

**Formula rapida:** VRAM necesaria ≈ Parametros x Bytes_por_param + 1-2GB overhead

Ejemplo: Qwen 3 14B en Q4_K_M = 14B x 0.5 = 7GB + 1.5GB overhead ≈ **8.5GB** → cabe en tu RTX 3060 (12GB)

## 3.5 Comparacion de costos

### Costo de correr localmente (tu maquina)

| Concepto | Costo |
|----------|-------|
| Hardware | Ya lo tienes ($0 adicional) |
| RTX 3060 consumo | ~170W bajo carga |
| 4 horas/dia x 30 dias | ~20.4 kWh/mes |
| Precio electricidad Colombia | ~$700 COP/kWh ≈ $0.17 USD/kWh |
| **Costo mensual electricidad** | **~$3.5 USD/mes** |

### Costo de APIs (abril 2026)

| Servicio | Precio Input | Precio Output | Costo 1M tokens |
|----------|-------------|---------------|-----------------|
| Claude Opus 4.6 | $15/MTok | $75/MTok | ~$90 |
| Claude Sonnet 4.6 | $3/MTok | $15/MTok | ~$18 |
| GPT-5.4 | $2.50/MTok | $10/MTok | ~$12.50 |
| DeepSeek API | $0.14/MTok | $2.19/MTok | ~$2.33 |
| Gemini 2.5 Pro | $1.25-2.50/MTok | $10-15/MTok | ~$12.50 |
| **Local (tu maquina)** | **$0** | **$0** | **~$0.003 electricidad** |

### Cuando lo local es mejor

- Privacidad total (datos nunca salen de tu maquina)
- Sin limites de rate ni de uso
- Sin dependencia de internet
- Para desarrollo y experimentacion ilimitada
- Costo efectivo desde el dia 1 si ya tienes el hardware

### Cuando necesitas la nube

- Modelos muy grandes (>14B sin cuantizar)
- Razonamiento complejo de larga duracion
- Produccion con alta concurrencia
- Cuando la calidad del modelo grande justifica el costo

## 3.6 Setup de demo para la ponencia

### Demo rapida (5 minutos de setup)
```bash
# 1. Instalar Ollama si no esta
curl -fsSL https://ollama.com/install.sh | sh

# 2. Descargar Gemma 4 E4B
ollama pull gemma4:e4b

# 3. Ejecutar
ollama run gemma4:e4b

# 4. En el chat, preguntar algo impresionante:
# > "Analiza este codigo Python y encuentra el bug de seguridad:
# > def login(user, password):
# >     query = f'SELECT * FROM users WHERE user={user} AND pass={password}'
# >     return db.execute(query)"
```

### Demo avanzada: Comparar 3 modelos
```python
#!/usr/bin/env python3
"""Compara respuestas de 3 modelos locales."""
import requests, time

MODELS = ["gemma4:e4b", "qwen3:8b", "deepseek-r1:8b"]
PROMPT = "Explica en 3 oraciones que es el Model Context Protocol (MCP)"

for model in MODELS:
    print(f"\n{'='*60}")
    print(f"MODELO: {model}")
    print('='*60)
    start = time.time()
    resp = requests.post("http://localhost:11434/api/chat", json={
        "model": model,
        "messages": [{"role": "user", "content": PROMPT}],
        "stream": False
    })
    elapsed = time.time() - start
    answer = resp.json()["message"]["content"]
    print(f"Tiempo: {elapsed:.1f}s")
    print(f"Respuesta:\n{answer}")
```

### Pre-demo checklist
- [ ] Modelos descargados (`ollama list`)
- [ ] GPU funcionando (`nvidia-smi`)
- [ ] Ollama corriendo (`ollama ps`)
- [ ] Internet NO requerido (todo local)
- [ ] Terminal con fuente grande para proyeccion

### Referencias modelos locales
- Gemma 4: https://deepmind.google/models/gemma/gemma-4/
- Gemma 4 guia local: https://zazencodes.substack.com/p/gemma-4-local-guide-ollama-llamacpp
- Ollama: https://github.com/ollama/ollama
- llama.cpp: https://github.com/ggerganov/llama.cpp
- Mejores modelos locales 2026: https://localaimaster.com/blog/small-language-models-guide-2026
- DeepSeek R1: https://github.com/deepseek-ai/DeepSeek-R1

---

# PARTE 3: AI Slop, Seguridad y Responsabilidad

## 4.1 El estudio METR — Los numeros que desafian la narrativa

### Metodologia

METR (Model Evaluation & Threat Research) condujo el estudio mas riguroso hasta la fecha sobre productividad con herramientas de IA — un **ensayo controlado aleatorizado** (RCT) publicado en julio 2025.

- **Participantes**: 16 desarrolladores open source experimentados
- **Experiencia promedio**: 5 anos, 1,500 commits en sus respectivos repositorios
- **Repos**: Proyectos grandes (promedio 22,000+ stars, 1M+ lineas)
- **Tareas**: 246 issues reales (bugs, features, refactors) que los propios desarrolladores identificaron
- **Diseno**: Cada issue asignado aleatoriamente a "IA permitida" o "IA no permitida"
- **Herramientas**: Cursor Pro con Claude 3.5/3.7 Sonnet (eleccion libre)
- **Compensacion**: $150/hora (eliminando presion financiera)
- **Duracion promedio**: ~2 horas por tarea

### El hallazgo clave

| Metrica | Valor |
|---------|-------|
| Prediccion de los desarrolladores | IA me hara **24% mas rapido** |
| Resultado real medido | IA me hizo **19% mas lento** |
| Brecha percepcion vs realidad | **43 puntos porcentuales** |
| Percepcion post-estudio | Aun creian haber sido 20% mas rapidos |

**Los desarrolladores no solo fueron mas lentos — no se dieron cuenta.**

### Las 5 causas de la desaceleracion

1. **Formular prompts y explicar contexto** — tiempo gastado describiendo el problema al modelo
2. **Esperar generacion** — latencia de inferencia del modelo
3. **Revisar y validar outputs** — 9% del tiempo total dedicado especificamente a esto
4. **Debuggear errores del IA** — corregir errores que el modelo introdujo
5. **Context switching** — disrupcion cognitiva al alternar entre programar y conversar con IA

**Insight core:** Estos desarrolladores ya eran extremadamente rapidos en sus propias codebases. El overhead del loop IA (prompt → espera → review → fix → re-prompt) excedio el tiempo ahorrado.

### Lo que el estudio NO dice

- NO dice que IA es inutil para todos (juniors pueden beneficiarse mas)
- NO dice que IA es inutil para todas las tareas (boilerplate, docs, codebases desconocidas)
- NO dice que futuras herramientas no mejoraran
- Aplica especificamente a **desarrolladores expertos en codebases familiares**

## 4.2 AI Slop — El tsunami de contribuciones basura

### Que es

"AI slop" = contenido de alto volumen, baja calidad, frecuentemente incorrecto, generado por IA y empujado a ecosistemas sin curacion adecuada.

### Los numeros

- Xavier Portilla Edo (Voiceflow): **"Solo 1 de cada 10 PRs creados con IA es legitimo"**
- CodeRabbit (analisis de 470 PRs en GitHub): PRs generados por IA contienen **1.7x mas issues** que PRs humanos (10.83 vs 6.45 por PR)
  - Errores de logica: **75% mas frecuentes**
  - Problemas de legibilidad: **3x mas altos**
  - Gaps en manejo de errores: **~2x mas comunes**
  - Operaciones I/O excesivas: **8x mas comunes**
- GitHub lo comparo con un **ataque de denegacion de servicio contra la atencion humana**

### Casos concretos

- **Curl**: Cerro su programa de bug bounty por el volumen de reportes basura generados por IA
- **GoCD**: Maintainer Chad Wilson reporto "nonsense plausible" que consumia horas de review
- **Containerd/Runwasi/SpinKube**: Presion similar de PRs generados por IA

### Respuesta de GitHub (13 de febrero 2026)

GitHub lanzo una nueva configuracion: **poder deshabilitar pull requests completamente**. Opciones en consideracion:
- Deshabilitar PRs o restringirlos a colaboradores
- Capacidades mejoradas de eliminacion de PRs
- Permisos granulares para creacion de PRs
- Herramientas de triage basadas en IA
- Mecanismos de transparencia sobre uso de IA

## 4.3 Vulnerabilidades de seguridad en codigo generado por IA

### Las cifras son alarmantes

**Veracode 2025 (100+ LLMs, 4 lenguajes):**
- Codigo generado por IA tiene **2.74x mas vulnerabilidades** que codigo humano
- **45% de muestras** fallaron tests de OWASP Top 10
- Cross-Site Scripting (CWE-80): **86% tasa de fallo**
- Java: **72% tasa de fallo** de seguridad (peor lenguaje)
- Python, C#, JavaScript: 38-45% tasas de fallo

**Apiiro (empresas Fortune 50):**
- **322% mas paths de escalacion de privilegios** en codigo IA
- **153% mas defectos de diseno de seguridad**
- **40% mas exposicion de secretos** (credenciales hardcodeadas, API keys)
- Vulnerabilidades CVSS 7.0+ aparecen **2.5x mas frecuentemente**
- Para junio 2025: **10,000+ nuevos hallazgos de seguridad mensuales** (10x incremento desde dic 2024)

### Patrones de fallo especificos

El codigo generado por IA falla consistentemente en:
- **Inyeccion** (SQL injection, XSS) — genera queries funcionales sin parametrizacion
- **Manejo inseguro de passwords** — almacena credenciales de forma insegura
- **IDOR** (Insecure Direct Object References) — falta de checks de autorizacion
- **Null checks y guardrails faltantes** — 2x mas comun
- **Operaciones I/O excesivas** — 8x mas comun (IA optimiza claridad, no eficiencia)

### Slopsquatting: El nuevo ataque de supply chain

Los modelos de IA **alucinan nombres de paquetes que no existen** de forma consistente.

**Investigacion (16 LLMs, 576,000 muestras de codigo):**
- **~20% de paquetes recomendados no existian** (205,000 nombres alucinados unicos)
- **43% de nombres alucinados se repiten** consistentemente en 10 queries identicas
- Los nombres son "semanticamente convincentes" — parecen paquetes reales

**Ejemplo real:** El paquete Python `huggingface-cli` fue alucinado repetidamente por multiples modelos. Al registrarlo como paquete vacio en PyPI, recibio **mas de 30,000 descargas autenticas en 3 meses**.

Los atacantes no necesitan adivinar — simplemente observan que paquetes fabrican los LLMs consistentemente y los registran con payloads maliciosos.

## 4.4 El problema de la validacion

### Sesgo de automatizacion

Investigacion (Goddard et al., 2012): consejos automatizados erroneos se siguen a una tasa **26% mayor** cuando hay recomendaciones automatizadas. Menos experiencia en el dominio = mas confianza en la maquina.

Perry et al. (2023): desarrolladores usando IA escribieron **codigo significativamente menos seguro** pero **creyeron mas firmemente** que habian escrito codigo seguro. IA aumento la confianza mientras disminuyo la calidad.

### Tres problemas cognitivos que se apilan

1. **Decremento de vigilancia**: La performance en tareas de monitoreo sostenido decae despues de 30 minutos. Code review es exactamente este tipo de tarea.
2. **Complacencia de automatizacion**: Los operadores detectan solo **30% de errores** en automatizacion consistentemente confiable (vs 75% cuando los fallos son visibles).
3. **Context switching**: Cada cambio entre hilos de review deja "residuo de atencion" que degrada performance.

### El "gorila en el CT scan"

En un estudio famoso (2013), **83% de radiologos expertos** no vieron una imagen de gorila 48x mas grande que un nodulo embebida en CT scans. Eye tracking mostro que mas de la mitad miraron directamente la imagen pero no la percibieron.

Esto es una analogia precisa para revisar codigo generado por IA: **puedes escanear codigo sin entenderlo**, especialmente cuando es estructuralmente correcto pero logicamente defectuoso.

### Mejores practicas para revisar codigo de IA

1. Tratar review como trabajo de alta concentracion; proteger ventanas de 25-30 minutos sin interrupcion
2. Pair programming en los reviews mas riesgosos
3. Romper codigo IA en unidades de review pequenas
4. **Buscar estados de fallo**: articular como se veria codigo incorrecto ANTES de revisar
5. Pedir a los desarrolladores que **expliquen el codigo IA en sus propias palabras** (si no pueden, no se mergea)
6. Fortalecer capas automatizadas (type systems, linters, SAST en CI)
7. **Principio core: Mientras mas rapido se escribe codigo, mas lento debe ser el review**

## 4.5 Burnout de mantenedores open source

**Tidelift 2024:**
- **60% de mantenedores** no reciben pago por su trabajo
- **44%** citan burnout como razon para irse
- **~60%** han dejado o considerado dejar de mantener sus proyectos
- Mantenedores pagados son **55% mas propensos** a implementar mejores practicas de seguridad

**Como la IA empeora el problema:**

Las herramientas de IA han hecho **trivialmente barato generar PRs** sin hacer nada para reducir el costo de revisarlos. Revisar PRs generados por IA es "mind-numbing", quitando la motivacion intrinseca del trabajo.

Jiaxiao Zhou (Microsoft Azure): *"Los reviewers ya no pueden asumir que los autores entienden o escribieron el codigo."*

### xz-utils como caso de estudio

- Identidad fabricada ("Jia Tan"), cuentas sockpuppet coordinadas
- 2.6 anos de ingenieria social contra un mantenedor quemado (Lasse Collin)
- Collin habia comunicado abiertamente sus problemas de salud mental
- Backdoor insertado en componente usado por virtualmente toda distribucion Linux
- **El burnout de mantenedores no es solo un problema de bienestar — es una vulnerabilidad de seguridad de infraestructura critica**

## 4.6 Framework de responsabilidad

### Quien es responsable cuando codigo de IA causa dano?

El **EU Cyber Resilience Act (CRA)** da respuesta clara: **el fabricante del producto final**. No distingue entre codigo humano y codigo generado por IA.

- **Multas**: Hasta 15 millones de euros o 2.5% de ingresos globales anuales
- **Reporte de vulnerabilidades**: obligatorio desde septiembre 11, 2026
- **Cumplimiento total**: diciembre 11, 2027

### Que debe validar un ingeniero ANTES de aceptar output de IA

1. **Seguridad**: Correr SAST/DAST en todo codigo generado por IA; NUNCA confiar en IA para autenticacion, autorizacion o criptografia
2. **Correctitud**: Verificar logica de negocio manualmente; tests generados por IA pueden compartir los mismos supuestos erroneos
3. **Dependencias**: Verificar que cada paquete existe y es el correcto (proteger contra slopsquatting)
4. **Fit arquitectonico**: IA no entiende las restricciones de diseno de tu sistema
5. **Licensing**: IA puede reproducir codigo con licencia incompatible
6. **Documentacion de intent**: **Si no puedes explicar por que el codigo funciona, no lo mergees**

## 4.7 Donde la IA SI ayuda (contrapunto)

### El patron "10x en boilerplate, 0.5x en problemas nuevos"

**Donde IA sobresale:**
- Generacion de boilerplate (CRUD, serializacion, configuracion)
- Scaffolding de tests
- Explicar codigo desconocido a nuevos desarrolladores
- Borradores de documentacion
- Reducir tiempo de consulta de docs
- Scaffolding en frameworks desconocidos
- Regex, conversiones de formato, transformaciones mecanicas

**Donde IA perjudica o estanca:**
- Problemas algoritmicos nuevos que requieren razonamiento profundo
- Decisiones arquitectonicas en sistemas complejos
- Codigo sensible a seguridad (auth, crypto)
- Codigo critico de performance (IA genera 8x mas I/O excesivo)
- Debugging de interacciones multi-componente
- Codebases grandes y maduras donde el contexto profundo importa (el escenario METR)

### Segun nivel de experiencia

| Nivel | Ganancia de productividad |
|-------|--------------------------|
| Juniors | 21-40% (IA llena gaps de conocimiento) |
| Seniors | 7-16% en el mejor caso; frecuentemente mas lentos |
| Expertos en codebase familiar | **-19%** (estudio METR) |

### El dato para cerrar

**73% de implementaciones de herramientas de IA en empresas son terminadas por reviews de seguridad.**

### Referencias AI Slop y seguridad
- Estudio METR: https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/
- METR ArXiv: https://arxiv.org/abs/2507.09089
- Veracode 2025 GenAI Report: https://www.veracode.com/blog/genai-code-security-report/
- CodeRabbit AI vs Human: https://www.coderabbit.ai/blog/state-of-ai-vs-human-code-generation-report
- GitHub Kill Switch: https://www.theregister.com/2026/02/03/github_kill_switch_pull_requests_ai/
- Slopsquatting: https://www.infosecurity-magazine.com/news/ai-hallucinations-slopsquatting/
- Tidelift 2024 Maintainer Report: https://tidelift.com/about/press-releases/survey-finds-many-open-source-maintainers-are-stressed-out-and-underpaid-but-persist-so-they-can-make-a-positive-impact
- Georgetown CSET Cybersecurity Risks: https://cset.georgetown.edu/wp-content/uploads/CSET-Cybersecurity-Risks-of-AI-Generated-Code.pdf
- Productividad paradox: https://www.cerbos.dev/blog/productivity-paradox-of-ai-coding-assistants

---

# RESUMEN EJECUTIVO: Lo que debes dominar para la ponencia

## Los 3 actos y sus datos killer

| Acto | Lo que debes poder explicar | Dato killer |
|------|----------------------------|-------------|
| **1. Agentes + Filtracion** | Por que Claude Code ≠ Opus en Cursor. Las 7 capas del harness. El agent loop de 88 lineas. Que revelo la filtracion (KAIROS, anti-distillation, undercover mode, 44 feature flags). | 188K tokens en Cursor vs 33K en Claude Code (5.7x). 512K lineas por un .npmignore faltante. Claw-Code: 50K stars en 2 horas. |
| **2. Modelos locales** | Gemma 4, DeepSeek R1, cuantizacion (Q4_K_M = sweet spot), Ollama. Demo en tu RTX 3060 12GB. | Gemma 4 E4B corre en 3GB RAM. Costo local: ~$3.5 USD/mes vs $90/MTok Opus en la nube. |
| **3. El precio** | METR: 19% mas lento. 2.74x mas vulnerabilidades. Slopsquatting. El gorila en el CT scan. xz-utils. Checklist de validacion. | Desarrolladores creen ser 24% mas rapidos cuando son 19% mas lentos. 73% de implementaciones IA terminadas por security review. |

## El mensaje que debe quedar

**Apertura:** "Cualquier persona puede construir software con IA, gratis, desde su laptop."  
**Desarrollo:** "Miren como funciona por dentro (agentes), miren que corre en su telefono (modelos locales)."  
**Giro:** "Pero los que usan IA sin entender son mas lentos, generan mas bugs, y estan quebrando el open source."  
**Cierre:** "El rol del ingeniero ya no es escribir codigo — es entender, validar y tomar responsabilidad. Su conocimiento vale MAS ahora, no menos."

---

# ANEXO A: MCP — Model Context Protocol (Material Complementario)

## 1.1 Que es MCP (tecnico)

MCP es un **protocolo abierto** (MIT License) que estandariza como las aplicaciones de IA se comunican con herramientas y fuentes de datos externas. Fue creado por **David Soria Parra** y **Justin Spahr-Summers** en Anthropic, lanzado en noviembre de 2024.

**Analogia directa:** Asi como LSP (Language Server Protocol) estandarizo como los IDEs hablan con compiladores de lenguajes, MCP estandariza como las aplicaciones de IA hablan con herramientas.

**Especificacion actual:** version `2025-11-25`  
**Repo:** https://github.com/modelcontextprotocol/modelcontextprotocol  
**Docs:** https://modelcontextprotocol.io

## 1.2 El problema N x M (esto hay que explicarlo en la ponencia)

**Sin MCP:**
```
             GitHub   Slack   Postgres   Jira   Filesystem
Claude         X        X        X        X         X
ChatGPT        X        X        X        X         X
Gemini         X        X        X        X         X
Cursor         X        X        X        X         X

Total integraciones = N x M = 4 x 5 = 20
Con 10 apps y 100 herramientas = 1,000 integraciones custom
```

**Con MCP:**
```
Claude  ──┐                  ┌── GitHub MCP Server
ChatGPT ──┤                  ├── Slack MCP Server
Gemini  ──┼── MCP Protocol ──┼── Postgres MCP Server
Cursor  ──┤                  ├── Jira MCP Server
Copilot ──┘                  └── Filesystem MCP Server

Total = N + M = 5 + 5 = 10
Con 10 apps y 100 herramientas = 110 implementaciones
```

Es el mismo patron que USB-C (un puerto, cualquier dispositivo) o HTTP (un protocolo, cualquier servidor web).

## 1.3 Formato de mensajes: JSON-RPC 2.0

Toda comunicacion MCP usa JSON-RPC 2.0, codificado en UTF-8. Tres tipos de mensaje:

**Request** (tiene `id`, espera respuesta):
```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/call",
  "params": {
    "name": "get_forecast",
    "arguments": { "latitude": 5.55, "longitude": -73.35 }
  }
}
```

**Response** (corresponde al `id` del request):
```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "content": [{ "type": "text", "text": "Temperatura: 18C..." }]
  }
}
```

**Notification** (sin `id`, fire-and-forget):
```json
{
  "jsonrpc": "2.0",
  "method": "notifications/initialized"
}
```

## 1.4 Transportes

| Transporte | Uso | Como funciona |
|---|---|---|
| **stdio** | Servidores locales | El cliente lanza el servidor como subproceso. Mensajes via stdin/stdout, delimitados por newlines. stderr solo para logs. |
| **Streamable HTTP** | Servidores remotos | Endpoint HTTP unico. POST envia JSON-RPC. Puede hacer upgrade a SSE para streaming. Soporta sesiones via `MCP-Session-Id`. |

**Nota:** SSE (el transporte viejo de 2024) esta **deprecado** desde spec 2025-03-26.

## 1.5 Los tres primitivos de MCP

| Primitivo | Que es | Analogia |
|-----------|--------|----------|
| **Tools** | Funciones que el LLM puede invocar (con aprobacion del usuario). Ej: `run_query`, `send_email`, `create_pr`. | Las "manos" de la IA |
| **Resources** | Datos de solo lectura que el cliente puede obtener para contexto. Direccionados por URIs. Ej: `file:///path/to/doc.md` | Los "ojos" de la IA |
| **Prompts** | Templates de interaccion reutilizables que estructuran como el usuario interactua con el LLM via el server. | Los "playbooks" |

Adicionalmente, los **clientes** pueden ofrecer capacidades al servidor:
- **Sampling**: El servidor puede pedir al LLM que genere texto (recursion agentica)
- **Roots**: El servidor puede preguntar sobre limites del filesystem
- **Elicitation**: El servidor puede pedir informacion adicional al usuario

## 1.6 Ciclo de vida de un servidor MCP

### Fase 1: Inicializacion (handshake de 3 pasos)
```
Client ──> Server:  initialize (version del protocolo, capacidades del cliente)
Server ──> Client:  InitializeResult (capacidades del servidor, version negociada)
Client ──> Server:  notifications/initialized (confirmacion)
```

### Fase 2: Operacion
Intercambio normal de JSON-RPC:
- `tools/list` — descubrir herramientas disponibles
- `tools/call` — invocar una herramienta
- `resources/list` / `resources/read` — descubrir y leer recursos
- `prompts/list` / `prompts/get` — descubrir y obtener templates

### Fase 3: Shutdown
stdio: el cliente cierra stdin. HTTP: DELETE con `MCP-Session-Id`.

## 1.7 Ejemplo practico: Servidor MCP en Python

```python
from mcp.server.fastmcp import FastMCP
import json

mcp = FastMCP("university-db")

# Base de datos simulada
STUDENTS = {
    "2024001": {"name": "Maria Garcia", "program": "Ing. Sistemas", "gpa": 4.2},
    "2024002": {"name": "Carlos Lopez", "program": "Ing. Electronica", "gpa": 3.8},
    "2024003": {"name": "Ana Torres", "program": "Ing. Sistemas", "gpa": 4.5},
}

@mcp.tool()
async def lookup_student(student_id: str) -> str:
    """Look up a student by their ID number.
    
    Args:
        student_id: The student's institutional ID (e.g., '2024001')
    """
    student = STUDENTS.get(student_id)
    if not student:
        return f"No student found with ID {student_id}"
    return json.dumps(student, indent=2, ensure_ascii=False)

@mcp.tool()
async def list_students_by_program(program: str) -> str:
    """List all students enrolled in a specific program.
    
    Args:
        program: Name of the academic program (e.g., 'Ing. Sistemas')
    """
    matches = [
        {"id": sid, **info}
        for sid, info in STUDENTS.items()
        if info["program"].lower() == program.lower()
    ]
    return json.dumps(matches, indent=2, ensure_ascii=False)

if __name__ == "__main__":
    mcp.run(transport="stdio")
```

**Setup:**
```bash
uv init university-mcp && cd university-mcp
uv add "mcp[cli]"
# Copiar el codigo en university_server.py
```

**Probar con MCP Inspector:**
```bash
npx @modelcontextprotocol/inspector uv run university_server.py
```

**Conectar a Claude Code:**
```bash
claude mcp add university-db -- uv run /ruta/absoluta/university_server.py
```

**REGLA CRITICA:** En servidores stdio, NUNCA usar `print()` a stdout. Corrompe el stream JSON-RPC. Usar `print(..., file=sys.stderr)`.

## 1.8 El "MCP Tax" — Costo en tokens

**Esto es importante entenderlo**: cada herramienta MCP inyecta su schema JSON completo en la ventana de contexto del LLM en **cada turno de conversacion**.

| Escenario | Overhead en tokens |
|---|---|
| 1 herramienta promedio | 300-600 tokens |
| GitHub MCP server (93 herramientas) | ~55,000 tokens solo en schemas |
| Power user tipico (10 servers, ~15 tools c/u) | ~75,000 tokens por turno |
| 120 herramientas en 25 turnos | ~362,000 tokens consumidos solo por schemas |

**Ejemplo de costo**: GitHub MCP (55K tokens/turno) con pricing de Claude Sonnet (~$3/MTok input), 1,000 requests/dia = ~$170/dia o **$5,100/mes** solo en overhead de schemas.

**Optimizaciones:**
- Just-in-time tool loading (cargar solo cuando se necesita)
- `mcp2cli` corta desperdicio en 96-99%
- Speakeasy reporto reduccion de 100x con toolsets dinamicos
- Claude Code carga solo **nombres** de herramientas al inicio, busca schemas on-demand

## 1.9 Seguridad de MCP

Entre enero-febrero 2026 se reportaron **30+ CVEs** contra servidores y clientes MCP.

**Vectores de ataque principales:**
1. **Tool Poisoning**: Un servidor MCP malicioso modifica descripciones de herramientas para inyectar instrucciones al LLM. Caso real: un servidor MCP no oficial de Postmark (1,500 descargas semanales) agrego un campo BCC oculto a `send_email`, copiando todos los correos a un atacante.
2. **Prompt Injection via tool descriptions**: Las descripciones son texto no confiable inyectado al contexto del LLM.
3. **Exposicion de datos**: ~1,000 servidores MCP encontrados expuestos en internet publico sin autenticacion, algunos conectados a clusters Kubernetes y CRMs.
4. **53% de servidores** usan API keys estaticas (sin OAuth).

## 1.10 Gobernanza: AAIF

El **9 de diciembre de 2025**, la Linux Foundation creo la **Agentic AI Foundation (AAIF)**. Anthropic dono MCP a esta fundacion.

**Miembros Platinum (Governing Board):** AWS, Anthropic, Block, Bloomberg, Cloudflare, Google, Microsoft, OpenAI

**Proyectos fundacionales:**
- MCP (Anthropic) — el protocolo
- goose (Block) — framework de agentes open source
- AGENTS.md (OpenAI) — convencion para definir comportamiento de agentes

**Significado:** Anthropic, OpenAI, Google y Microsoft — competidores directos — gobiernan juntos el mismo protocolo. Senal de que MCP es un estandar de industria, no una jugada de vendor lock-in.

## 1.11 Estadisticas actuales de MCP

- **97+ millones** de descargas mensuales del SDK
- **10,000+** servidores activos
- Soporte nativo en: Claude, ChatGPT, Gemini, Cursor, Copilot, VS Code

### Referencias MCP
- Spec oficial: https://modelcontextprotocol.io/specification/2025-11-25
- Docs: https://modelcontextprotocol.io
- Repo de servidores oficiales: https://github.com/modelcontextprotocol/servers
- Awesome MCP servers: https://github.com/wong2/awesome-mcp-servers
- AAIF: https://aaif.io
- Roadmap 2026: https://blog.modelcontextprotocol.io/posts/2026-mcp-roadmap/
- MCP Token Tax: https://onlycli.github.io/OnlyCLI/blog/mcp-token-cost-benchmark/
- Seguridad MCP: https://www.akto.io/blog/mcp-security-best-practices
