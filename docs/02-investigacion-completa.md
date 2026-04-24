# Ponencia — Simposio UPTC 2026

**Titulo propuesto:** "IA Abierta: El Poder, la Arquitectura y el Precio de No Entender lo que Generas"  
**Duracion:** ~45 minutos  
**Audiencia:** Profesores y estudiantes de ultimo semestre de Ingenieria de Sistemas  
**Fecha de investigacion:** Abril 2026

---

## Idea Central (Hilo Narrativo)

Estamos entrando en una nueva etapa del software donde la inteligencia artificial deja de ser una herramienta aislada y se convierte en una **infraestructura abierta, accesible y ejecutable por cualquier persona**. Cualquier estudiante con un laptop puede hoy correr modelos de IA competitivos y usar agentes que escriben, editan y ejecutan codigo por ellos. Eso es un poder sin precedentes. Pero poder sin conocimiento es peligroso.

La ponencia articula esta tesis en tres actos conectados:

1. **Nuevas formas de trabajar** — Los agentes de codigo en terminal ya no son promesas: son realidad. La filtracion masiva del codigo fuente de Claude Code (512,000 lineas, 31 de marzo de 2026) revelo la arquitectura completa de un agente de clase mundial y demostro que la diferencia no esta en el modelo, sino en la orquestacion. Esto desato el repositorio de mas rapido crecimiento en la historia de GitHub.
2. **El acceso masivo al poder** — Modelos abiertos como DeepSeek (MIT) y la familia Gemma 4 de Google corren en un telefono. Ollama te da IA local en una linea de comando. Las barreras economicas desaparecieron.
3. **El precio de no entender** — Generar codigo es trivial. Pero el estudio METR demostro que los desarrolladores con IA son 19% mas lentos (creyendo ser 24% mas rapidos). El codigo generado tiene 2.74x mas vulnerabilidades. El "AI slop" esta quebrando el open source. El conocimiento y la validacion son MAS importantes ahora, no menos.

---

## Acto 1: Los Agentes de Codigo — La Filtracion que Revelo Como Funciona la Magia

### Descripcion

Entre 2025 y 2026, todas las grandes empresas de IA lanzaron agentes de codificacion open source que operan directamente desde la terminal. Es la primera vez que todos los gigantes compiten simultaneamente con estrategia open-source-first en la misma categoria de producto.

### Principales herramientas

| Herramienta | Empresa | GitHub Stars | Fecha de lanzamiento |
|-------------|---------|-------------|---------------------|
| Claude Code | Anthropic | 111K+ | Febrero 2025 |
| Gemini CLI | Google | 100K+ | Abril 2025 |
| Codex CLI | OpenAI | 74K+ | Abril 2025 |
| OpenCode | Comunidad (vendor-neutral) | 140K+ | Abril 2025 |
| Qwen Code | Alibaba | 22K+ | Junio 2025 |

### LA GRAN FILTRACION: El Source Map de Claude Code (31 de marzo de 2026)

El 31 de marzo de 2026, Anthropic publico la version 2.1.88 del paquete npm `@anthropic-ai/claude-code` con un error critico: incluyo un archivo **source map** (`.js.map`) de **59.8 MB** que, al decodificarse, revelo el codigo fuente original completo de Claude Code — **~1,900 archivos TypeScript y mas de 512,000 lineas de codigo**.

#### Como ocurrio

El error fue simple pero devastador: faltaba una entrada `*.map` en el archivo `.npmignore`. Con el bundler Bun (que usa Claude Code), los source maps se generan por defecto a menos que se desactiven explicitamente. El ingeniero de Anthropic **Boris Cherny** confirmo que fue "un error humano, no un bug de tooling".

> Nota: Este fue el **segundo incidente identico** — el primero ocurrio el 24 de febrero de 2025.

El investigador de seguridad **Chaofan Shou** (@shoucccc) fue el primero en descubrirlo y publicarlo en X. En cuestion de horas, el codebase completo fue descargado, archivado en GitHub (1,100+ stars, 1,900+ forks) y analizado por miles de desarrolladores.

#### Lo que se revelo: Arquitectura

1. **Sistema de herramientas (tools)**: Definiciones para lectura de archivos, ejecucion de bash, busqueda (Grep/Glob), edicion, acceso LSP (jerarquias de llamadas, definiciones, referencias).
2. **Motor de consultas**: Manejo de llamadas a la API del LLM y orquestacion.
3. **Orquestacion multi-agente**: Capacidad de crear "sub-agentes" o swarms para tareas complejas. Tres modelos de ejecucion: fork, teammate y worktree con cache de contexto heredado.
4. **Capa de comunicacion bidireccional**: Conecta extensiones de IDE con el CLI de Claude Code.
5. **Memoria de tres capas**: Index (siempre cargado, ~150 chars por entrada), Topic Files (cargados on-demand), Transcripts (accesibles solo via grep).
6. **Optimizacion de prompt cache**: Sistema `SYSTEM_PROMPT_DYNAMIC_BOUNDARY` que separa prompts en secciones estaticas (cacheables) y dinamicas. Secciones marcadas como `DANGEROUS_uncachedSystemPromptSection` para advertir a ingenieros del costo de romper la cache.
7. **5 estrategias de compactacion de contexto** y un sistema de 25+ event hooks.

#### Lo que se revelo: Funciones secretas y no publicadas

| Funcion | Descripcion |
|---------|-------------|
| **KAIROS** | Modo de agente autonomo que opera continuamente sin input del usuario. Recibe heartbeats preguntando "anything worth doing right now?". Incluye webhooks de GitHub, cron cada 5 minutos, workers daemon en background. Los agentes **siguen trabajando incluso con el laptop cerrado**. |
| **ULTRAPLAN** | Modo que delega planificacion a una sesion remota de Opus 4.6 en Cloud Container Runtime, con hasta **30 minutos** para pensar. Polling cada 3 segundos. |
| **/dream** | Skill de "destilacion nocturna de memoria". Proceso `autoDream` que consolida aprendizaje y reorganiza memoria cada noche. Triple-gated: tiempo (24+ hrs), sesiones (5+), y file locks con rollback. |
| **Buddy/Companion** | Sistema Tamagotchi que genera criaturas deterministicas (18 especies, rareza por tiers, 1% shiny) desde el ID del usuario, con stats RPG como "DEBUGGING" y "SNARK" (feature de April Fools). |
| **TungstenTool** | Control interno de keystrokes y captura de pantalla, protegido por verificacion de tipo de usuario en build-time. |
| **Voice Mode** | Modo de comandos de voz completo. |
| **Browser Control** | Control de navegador via Playwright. |
| **44 feature flags** | Funciones completamente construidas pero no activadas, con codigo compilado detras de flags. |

#### Lo que se revelo: Mecanismos de proteccion

**Anti-Destilacion (anti_distillation)**:
- **Fake Tools**: Cuando se activa el flag `ANTI_DISTILLATION_CC`, se inyectan **herramientas senuelo** en los system prompts para envenenar datos de entrenamiento de competidores.
- **CONNECTOR_TEXT**: Segundo nivel que buferea texto del asistente entre llamadas de herramientas, lo resume con firmas criptograficas, y devuelve solo resumenes — impidiendo que competidores capturen cadenas de razonamiento completas.
- **Debilidad**: Ambos mecanismos se desactivan con `CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS` o via proxy MITM que elimine el campo `anti_distillation`.

**Undercover Mode** (`undercover.ts`):
- Modo activo **por defecto** que elimina toda traza de informacion interna de Anthropic en repositorios externos.
- Instruye al modelo a no mencionar codenames internos ("Capybara", "Tengu", "Numbat"), canales de Slack, ni identificarse como "Claude Code".
- **No tiene opcion de desactivacion** ("There is NO force-OFF").
- Consecuencia: los commits creados por IA desde empleados de Anthropic en proyectos open source **no revelan que fueron generados por IA**.
- Se revelo una lista de **22 repositorios internos privados** incluyendo `anthropics/casino`, `anthropics/forge-web`, `anthropics/mobile-apps`, `anthropics/claude-for-hiring`.

**DRM a Nivel de HTTP (Native Client Attestation)**:
- Las peticiones API incluyen un placeholder `cch=00000` que el runtime HTTP de Bun (escrito en Zig) reemplaza con un hash computado antes de la transmision.
- Esto **prueba criptograficamente** que las peticiones vienen de binarios autenticos de Claude Code — es "DRM para llamadas API, a nivel de transporte HTTP".
- Al implementarlo debajo de la capa JavaScript (en Zig compilado), Anthropic hizo el spoofing mucho mas dificil.

#### Lo que se revelo: Codenames de modelos internos

| Codename | Descripcion |
|----------|-------------|
| **Capybara/Mythos** | Version 8 con 1M de contexto y "fast mode". Notas internas mencionan problemas con sobre-comentar y afirmaciones falsas. |
| **Numbat** | Etiquetado con comentarios de ventana de lanzamiento proximo. |
| **Fennec** | Especulado como Opus 4.6. |
| **Tengu** | Referenciado en undercover mode. |

#### Lo que se revelo: Vulnerabilidades

- **Parser Differential en Bash**: El sistema de validacion de bash usa `shell-quote` cuya regex BAREWORD trata retornos de carro (`\r`) como limites de token, pero bash no. Un atacante puede crear comandos con caracteres CR embebidos para evadir validadores.
- **Ataque via Context Compaction**: Cuando las conversaciones exceden limites, un Claude mas pequeno crea resumenes. Instrucciones embebidas en archivos del proyecto (CLAUDE.md, README) sobreviven la compresion sin etiquetado de origen, permitiendo **inyeccion via archivos de configuracion aparentemente inocuos**.
- **Problemas de rendimiento**: Una consulta interna de BigQuery (10 de marzo de 2026) identifico 1,279 sesiones con fallos de compactacion alcanzando 3,272 reintentos, desperdiciando ~**250K llamadas API/dia globalmente**.

#### El efecto en el ecosistema open source: La explosion

La filtracion fue un sismo para el ecosistema de agentes de codigo:

**Claw-Code: El repositorio mas rapido en la historia de GitHub**

Sigrid Jin, preocupada por la exposicion legal de alojar codigo propietario directamente, tomo un enfoque diferente: una **reescritura clean-room en Python** usando oh-my-codex (OmX). Capturo los patrones arquitectonicos sin copiar codigo fuente.

- Alcanzo **50,000 estrellas en aproximadamente 2 horas** tras su publicacion.
- Superó 55,800 stars y 58,200 forks para el 1 de abril.
- Se autodenomina "el repo mas rapido en la historia en superar 50K/100K stars".

**Claurst: Reescritura en Rust**

Una reimplementacion clean-room del comportamiento de Claude Code en Rust, con soporte multi-proveedor. Evoluciono de clon a agente TUI independiente con capacidades propias.

**Otros efectos**:

| Efecto | Descripcion |
|--------|-------------|
| **Reescrituras en multiples lenguajes** | La comunidad comenzo a portar la logica del agente a Python, Rust y otros lenguajes. |
| **Benchmark para la industria** | Construir un agente de IA production-grade antes requeria descubrir limites de seguridad, permisos y gestion de contexto desde cero. Ahora hay una implementacion de referencia completa. |
| **Cambio de ventaja competitiva** | Cuando la arquitectura ya no es secreta, la diferenciacion se mueve de "como construirlo" a "que modelo usar" y "que tan buena es la experiencia". |
| **Riesgo de seguridad** | La fuente filtrada permite forks maliciosos que reempaquetan Claude Code con backdoors insertados. Ataques de supply chain via servidores MCP pueden exfiltrar datos con los mismos privilegios que las herramientas built-in. |

#### La respuesta de Anthropic

Anthropic confirmo el incidente calificandolo como:

> *"A release packaging issue caused by human error, not a security breach. No sensitive customer data or credentials were involved or exposed."*

- La version 2.1.88 fue retirada de npm.
- Anthropic emitio **DMCA notices** contra repositorios en GitHub que contenian el codigo TypeScript original.
- Sin embargo, las reescrituras clean-room como **Claw-Code** (Python) y **Claurst** (Rust) **permanecen activas**, ya que no son copias directas del codigo propietario.
- La efectividad legal de reclamaciones DMCA contra reimplementaciones generadas por IA **no ha sido probada en cortes**.

### CLAVE PARA LA PONENCIA: Por que Claude Code NO es lo mismo que usar Opus 4.6 en Cursor

> **Este es un punto que muchos desarrolladores no entienden y que la filtracion deja en evidencia.**

Muchos desarrolladores asumen que Claude Code = Opus 4.6 con una terminal bonita. No es asi. La filtracion revelo que lo que hace poderoso a Claude Code no es el modelo, sino los **~512,000 lineas de infraestructura que orquestan al modelo**. Todos los modelos actuales (Opus, GPT-5.4, Gemini) tienen capacidades similares. La diferencia esta en **que construyes alrededor del modelo**.

#### Analogia para explicarlo rapido (2-3 min en la ponencia)

```
Usar Opus 4.6 directamente (API/Cursor/IDE):
  = Tener un cerebro brillante sentado en una silla
  → Puede pensar, pero no puede moverse, ni abrir archivos, ni ejecutar comandos.
  → Le pasas texto, te devuelve texto. Fin.

Usar Claude Code:
  = Ese mismo cerebro + un cuerpo completo con manos, ojos, memoria y reglas
  → Puede leer tu codigo, editarlo, ejecutar tests, navegar tu repo,
    crear sub-agentes, recordar entre sesiones, y decidir cuando parar.
  → Tiene ~40 herramientas, permisos, sandbox, memoria persistente.
```

#### Lo que la filtracion revelo de la arquitectura (el "cuerpo" del agente)

**1. El Agent Loop (~88 lineas que lo cambian todo)**

El loop central es sorprendentemente simple:
1. Recibe input del usuario → lo agrega al array de mensajes
2. Envia mensajes al modelo con system prompt
3. El modelo responde y puede pedir usar herramientas
4. Si pide herramientas → verifica permisos → ejecuta → agrega resultado → vuelve al paso 2
5. Si no pide herramientas → termina

**El unico estado es un array de mensajes.** No hay state machine, no hay workflow graph. Esta simplicidad es la que hace al sistema robusto.

**2. El sistema de herramientas (~19-40 tools)**

Cuando usas Opus 4.6 en Cursor, el IDE le da al modelo unas pocas herramientas basicas. Claude Code le da **~40 herramientas especializadas** con permisos granulares:

| Categoria | Herramientas | Que permiten |
|-----------|-------------|-------------|
| Archivos | Read, Edit, Write, Glob | Leer, editar, crear, buscar archivos |
| Ejecucion | Bash | Ejecutar cualquier comando en terminal |
| Busqueda | Grep, Glob, LSP | Buscar en codigo, navegar definiciones, encontrar referencias |
| Subagentes | Agent, SendMessage | Crear agentes especializados que trabajan en paralelo |
| Web | WebSearch, WebFetch | Buscar y leer contenido de internet |
| MCP | mcp__*__* | Conectarse a CUALQUIER herramienta externa via MCP |
| Memoria | Auto Memory, CLAUDE.md | Recordar entre sesiones, cargar contexto del proyecto |
| Notebooks | NotebookEdit | Editar Jupyter notebooks |

**Dato revelado por la filtracion**: Claude Code no carga todos los schemas de herramientas MCP al contexto. Solo carga los **nombres** al inicio, y busca los schemas on-demand cuando los necesita. Esto ahorra tokens y es una decision de ingenieria clave.

**3. El sistema de permisos (3 niveles)**

Cada herramienta pasa por un pipeline de permisos:

| Nivel | Ejemplo | Accion |
|-------|---------|--------|
| **Tier 1: Auto-aprobado** | Leer archivos, buscar texto | Se ejecuta sin preguntar |
| **Tier 2: Pedir confirmacion** | Editar archivos, ejecutar comandos | Pregunta al usuario (o en modo auto, un clasificador Sonnet evalua) |
| **Tier 3: Bloquear** | Acceso fuera del directorio, exfiltracion | Denegado siempre |

**Detalle critico revelado**: En modo `auto`, un **clasificador de seguridad separado** (otra instancia de Sonnet) evalua si la accion es segura. Este clasificador **deliberadamente no ve la prosa del agente** para evitar prompt injection. El modelo que razona y el que autoriza son independientes.

**4. Memoria de 3 capas**

| Capa | Que almacena | Cuando se carga |
|------|-------------|----------------|
| **Index** | Punteros ligeros (~150 chars) | Siempre |
| **Topic Files** | Conocimiento real por tema | Bajo demanda |
| **Transcripts** | Historial de conversaciones | Solo via grep, nunca cargado completo |

Cuando usas Opus 4.6 en Cursor, cada sesion empieza de cero. Claude Code recuerda entre sesiones: patrones de tu codebase, decisiones de debugging, y preferencias aprendidas.

**5. Compactacion de contexto (5 estrategias)**

Al ~98% de capacidad de la ventana de contexto, el sistema **automaticamente resume** la historia anterior conservando metadata critica. Elimina imagenes/PDFs y comprime, pero reinyecta CLAUDE.md en cada turno. Cursor simplemente pierde contexto o trunca.

**6. Subagentes con aislamiento**

Claude Code puede crear **subagentes** — instancias independientes con:
- Contexto aislado (no contaminan la sesion principal)
- Herramientas restringidas (un subagente de auditoria solo puede leer, no editar)
- Ejecucion en paralelo (multiples agentes trabajando simultaneamente)
- Aislamiento en worktrees de Git (editan en ramas temporales sin tocar main)

**7. Sandbox a nivel de OS**

- macOS: Seatbelt isolation
- Linux: bubblewrap
- Procesos hijos heredan las restricciones
- Incluso si el modelo quisiera escapar, el kernel lo impide

#### La diferencia en numeros

Un benchmark revelo que una tarea que consumio **188K tokens en Cursor** fue completada por Claude Code en **33K tokens** — casi **6x mas eficiente**. La orquestacion inteligente de contexto, herramientas y permisos hace que el mismo modelo rinda dramaticamente mejor.

#### Resumen para la ponencia (1 slide)

```
┌─────────────────────────────────────────────────────────┐
│              MODELO (Opus 4.6, GPT-5.4, etc.)           │
│         "El cerebro" — razona, genera, decide           │
├─────────────────────────────────────────────────────────┤
│          HARNESS / ORQUESTADOR (Claude Code)            │
│  "El cuerpo" — lo que la filtracion revelo:             │
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

**Mensaje clave**: *El modelo es intercambiable. La orquestacion es lo que crea la experiencia. Y ahora, gracias a la filtracion, sabemos exactamente como funciona.*

### La leccion mas profunda

La filtracion accidental de Claude Code podria convertirse en un **benchmark de la industria para practicas de ingenieria de agentes de IA**, analogo a como Android impulso el ecosistema movil al ser open source.

Para los estudiantes: no es la herramienta secreta lo que importa, sino **entender los fundamentos** — ingenieria de prompts, diseno de herramientas, gestion de contexto, y seguridad. Ahora pueden estudiar exactamente como funciona un agente de clase mundial.

### Referencias

- The Hacker News: https://thehackernews.com/2026/04/claude-code-tleaked-via-npm-packaging.html
- VentureBeat: https://venturebeat.com/technology/claude-codes-source-code-appears-to-have-leaked-heres-what-we-know
- InfoQ: https://www.infoq.com/news/2026/04/claude-code-source-leak/
- The Register: https://www.theregister.com/2026/03/31/anthropic_claude_code_source_code/
- DEV Community (analisis del incidente): https://dev.to/varshithvhegde/the-great-claude-code-leak-of-2026-accident-incompetence-or-the-best-pr-stunt-in-ai-history-3igm
- Alex Kim (fake tools, frustration regexes, undercover mode): https://alex000kim.com/posts/2026-03-31-claude-code-source-leak/
- Medium (512K lineas): https://tonylixu.medium.com/the-claude-code-source-leak-how-a-single-source-map-file-exposed-510-000-lines-of-code-0ac25df26fd2
- Penligent (que se expuso y que significa): https://www.penligent.ai/hackinglabs/claude-code-source-map-leak-what-was-exposed-and-what-it-means/
- Engineer's Codex (analisis profundo): https://read.engineerscodex.com/p/diving-into-claude-codes-source-code
- Sabrina.dev (analisis comprensivo): https://www.sabrina.dev/p/claude-code-source-leak-analysis
- Cybernews (Claw-Code, repo mas rapido en GitHub): https://cybernews.com/tech/claude-code-leak-spawns-fastest-github-repo/
- Claw-Code: https://github.com/instructkr/claw-code
- Claurst (Rust rewrite): https://github.com/Kuberwastaken/claurst
- Sourcemap archivado: https://github.com/leeyeel/claude-code-sourcemap
- Open Source For You (impacto en el ecosistema): https://www.opensourceforu.com/2026/04/anthropic-leak-exposes-claude-code-as-an-open-source-learning-event/
- Dark Reading (supply chain): https://www.darkreading.com/application-security/source-code-leaks-highlight-lack-supply-chain-oversight
- Heise Online: https://www.heise.de/en/news/Claude-Code-unintentionally-open-source-Source-map-reveals-all-11242079.html
- Layer5 (analisis completo): https://layer5.io/blog/engineering/the-claude-code-source-leak-512000-lines-a-missing-npmignore-and-the-fastest-growing-repo-in-github-history/
- WaveSpeedAI (Agent Harness Architecture): https://wavespeed.ai/blog/posts/claude-code-agent-harness-architecture/
- Penligent (Inside Claude Code: Tools, Memory, Hooks, MCP): https://www.penligent.ai/hackinglabs/inside-claude-code-the-architecture-behind-tools-memory-hooks-and-mcp/
- DEV Community (Agent Loop, Tool System, Permission Model): https://dev.to/brooks_wilson_36fbefbbae4/claude-code-architecture-explained-agent-loop-tool-system-and-permission-model-rust-rewrite-41b2
- WaveSpeedAI (Claude Code vs Cursor 2026): https://wavespeed.ai/blog/posts/claude-code-vs-cursor-2026/
- Addy Osmani (Code Agent Orchestra): https://addyosmani.com/blog/code-agent-orchestra/
- Claude Code Docs (Agent Teams): https://code.claude.com/docs/en/agent-teams
- Claude Code Docs (Sub-agents): https://code.claude.com/docs/en/sub-agents
- CosmicJS (Honest Comparison 2026): https://www.cosmicjs.com/blog/claude-code-vs-github-copilot-vs-cursor-which-ai-coding-agent-should-you-use-2026
- Claude Code (oficial): https://github.com/anthropics/claude-code
- Gemini CLI: https://github.com/google-gemini/gemini-cli
- Codex CLI: https://github.com/openai/codex
- OpenCode: https://github.com/opencode-ai/opencode

---

## Acto 2: Modelos Abiertos en Hardware Local — La Verdadera Democratizacion

### Descripcion

La combinacion de modelos de pesos abiertos cada vez mas capaces con herramientas de inferencia local ha eliminado la barrera economica para acceder a IA de alto nivel. Ya no necesitas una API de $200/mes ni una GPU de data center.

### DeepSeek: El terremoto desde China

DeepSeek-R1, lanzado en enero de 2025 bajo **licencia MIT**, demostro que los modelos abiertos pueden competir con los propietarios en razonamiento. DeepSeek-V3 (102K+ stars) es el modelo base, y R1 agrego capacidades de cadena de razonamiento.

| Modelo | Stars | Licencia | Capacidad |
|--------|-------|----------|-----------|
| DeepSeek-R1 | 92K+ | MIT | Razonamiento competitivo con modelos propietarios |
| DeepSeek-V3 | 102K+ | Open | Modelo base de R1 |
| DeepSeek-OCR | 23K+ | Open | Compresion optica de contextos |

### Google Gemma: IA de Clase Mundial en Tu Telefono

Google ha lanzado cuatro generaciones de modelos Gemma, cada una mas optimizada para hardware local:

#### Evolucion de Gemma

| Modelo | Fecha | Parametros | Novedad clave |
|--------|-------|-----------|---------------|
| Gemma 1 | Feb 2024 | 2B, 7B | Primer modelo abierto de Google |
| Gemma 2 | Jun 2024 | 2B, 9B, 27B | Calidad mejorada, solo texto |
| Gemma 3 | Mar 2025 | 270M a 27B | Multimodal, 128K contexto, 140+ idiomas |
| Gemma 3n | Jun 2025 | E2B (~2B eff), E4B (~4B eff) | Arquitectura mobile-first con PLE |
| FunctionGemma | Dic 2025 | 270M | Especializado en function calling en edge |
| **Gemma 4** | **Abr 2026** | E2B a 31B Dense | **Apache 2.0**, 256K contexto, MoE |

#### Gemma 4: El Mas Reciente (Abril 2, 2026)

Gemma 4 es el modelo mas capaz lanzado bajo **Apache 2.0** (la licencia mas permisiva que Google ha usado para Gemma):

| Variante | Parametros | RAM minima | Hardware objetivo | Benchmark destacado |
|----------|-----------|------------|-------------------|-------------------|
| E2B | ~2B efectivos | ~1.5GB (INT4) | Telefonos, Raspberry Pi | Audio + agentic workflows |
| E4B | ~4B efectivos | ~2-3GB | Telefonos, laptops | Multimodal completo |
| 26B MoE (A4B) | 25.2B total, 3.8B activos | ~8-12GB | Laptops, desktops | #6 global en Arena AI (calidad de 31B a fraccion del costo) |
| 31B Dense | 31B | ~16-24GB | Desktops, GPUs | AIME 2026: 89.2%, LiveCodeBench v6: 80%, #3 global Arena AI |

**La innovacion clave: Per-Layer Embeddings (PLE)**. Esta tecnica reduce dramaticamente el uso de memoria: un modelo de 5.1B parametros opera con footprint de solo 2B. Ninguna otra familia de modelos tiene esta arquitectura.

#### Performance en Hardware Consumer

| Hardware | Modelo | Rendimiento |
|----------|--------|-------------|
| Telefono (8GB RAM) | Gemma 4 E4B cuantizado | 10-25 tokens/segundo |
| Telefono (4GB RAM) | Gemma 4 E2B INT4 | Interactivo, 1.5GB RAM |
| Laptop (Apple Silicon M1-M4, 16GB) | Gemma 4 26B MoE | Corre en memoria unificada |
| Pixel 9 | Gemma 3 270M INT4 | 0.75% bateria por 25 conversaciones |
| Desktop (RTX 4090) | Gemma 4 31B Dense | Completo sin cuantizar |

#### Google AI Edge Gallery

Google lanzo una app (iOS y Android) que permite a cualquiera ejecutar Gemma 4 en su dispositivo: chat multi-turno con modo de razonamiento, comprension de imagenes via camara, transcripcion de audio y workflows agenticos. Alcanzo el **#8 en apps de productividad** en App Store.

### Comparativa con Otros Modelos Eficientes

| Modelo | Ventaja principal | Licencia | Nota |
|--------|------------------|----------|------|
| Gemma 4 E4B | Mejor ratio calidad/memoria, multimodal | Apache 2.0 | Unico con PLE |
| DeepSeek R1 (distilled 7B) | Superior en razonamiento | MIT | Menos optimizado para movil |
| Llama 4 Scout | MMLU 85.5% | Custom (700M MAU limit) | No mobile-first |
| Qwen 3.5 27B | MMLU Pro 86.1% | Apache 2.0 | Competitivo en multilingue |
| Phi-4-mini (3.8B) | Matematicas (MATH 80.4%) | MIT | Solo texto |

### Herramientas de Inferencia Local

| Herramienta | Que es | Soporte Gemma 4 |
|-------------|--------|-----------------|
| **Ollama** | Una linea para ejecutar cualquier modelo | Si (v0.20.0+), bug conocido en tool calling |
| **llama.cpp** | Inferencia en CPU, extrema portabilidad | Si, Google colaboro directamente |
| **LM Studio** | GUI para modelos locales | Si |
| **MLX** | Optimizado para Apple Silicon | Si |
| **vLLM** | Produccion de alta escala, multi-GPU | Si |

### Transicion narrativa

> Tenemos los agentes (Claude Code y sus herederos), sabemos como funcionan por dentro, y ahora tenemos modelos que corren en un telefono. La IA dejo de ser un servicio de elite — es una utilidad publica. Pero... ¿que pasa cuando todo el mundo puede generar codigo sin esfuerzo?

### Referencias

- DeepSeek-R1: https://github.com/deepseek-ai/DeepSeek-R1
- Gemma (Google DeepMind): https://deepmind.google/models/gemma/
- Gemma 4 anuncio: https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/
- Gemma 4 benchmarks: https://www.geeky-gadgets.com/gemma-4-benchmarks/
- Gemma 4 vs Qwen 3.5 vs Llama 4: https://ai.rs/ai-developer/gemma-4-vs-qwen-3-5-vs-llama-4-compared
- Gemma 4 guia local (Ollama + llama.cpp): https://zazencodes.substack.com/p/gemma-4-local-guide-ollama-llamacpp
- Google AI Edge Gallery: https://github.com/google-ai-edge/gallery
- FunctionGemma: https://blog.google/technology/developers/functiongemma/
- Mejores modelos locales 2026: https://localaimaster.com/blog/small-language-models-guide-2026
- Ollama: https://github.com/ollama/ollama
- llama.cpp: https://github.com/ggerganov/llama.cpp
- vLLM: https://github.com/vllm-project/vllm
- Guia de inferencia local 2026: https://dev.to/starmorph/local-llm-inference-in-2026-the-complete-guide-to-tools-hardware-open-weight-models-2iho
- NVIDIA RTX AI Garage - Gemma 4: https://blogs.nvidia.com/blog/rtx-ai-garage-open-models-google-gemma-4/
- Hugging Face - Welcome Gemma 4: https://huggingface.co/blog/gemma4

---

## Acto 3: El Precio de No Entender — AI Slop, Seguridad y Responsabilidad

### Descripcion

GitHub proceso 43.2 millones de pull requests por mes en 2025 (un incremento del 23% interanual). Sin embargo, una oleada de pull requests e issues generados por IA de baja calidad — denominados **"AI slop"** — esta sobrecargando a los mantenedores de proyectos open source. GitHub esta evaluando un mecanismo tipo "kill switch" para restringir PRs.

### El estudio METR: La paradoja de la productividad

Un estudio controlado aleatorizado de **METR** (julio 2025) con 16 desarrolladores open source experimentados trabajando en 246 issues reales revelo un hallazgo sorprendente:

- **Los desarrolladores usando herramientas de IA tardaron 19% mas** que sin ellas.
- Los propios desarrolladores habian predicho que la IA les ahorraria un 24% de tiempo.
- **Brecha de percepcion: 43%** entre lo que creian y lo que realmente paso.
- Causas: sobreoptimismo sobre la utilidad de la IA y el hecho de que la familiaridad profunda con el dominio reduce el valor marginal de la IA.

### Datos del ecosistema

| Metrica | Valor | Fuente |
|---------|-------|--------|
| Pull requests/mes en GitHub | 43.2M | Octoverse 2025 |
| Nuevos desarrolladores en GitHub (2025) | 36M (1 por segundo) | Octoverse 2025 |
| Repositorios relacionados con IA | 4.3M (+178% YoY) | Octoverse 2025 |
| Crecimiento en proyectos LLM | +178% YoY | GitHub Blog |

### El circulo vicioso

```
Generar codigo es trivial (agentes + modelos abiertos)
          ↓
Mas PRs e issues generados por IA
          ↓
Mantenedores sobrecargados (review burden > reviewer pool)
          ↓
Burnout acelerado de mantenedores
          ↓
Proyectos criticos sin mantenimiento
          ↓
Mas vulnerabilidades (como xz-utils)
```

### Transicion narrativa

> Agentes que escriben codigo por ti, modelos que corren gratis en tu laptop... y sin embargo: los desarrolladores con IA son mas lentos, el codigo generado tiene 2.74x mas vulnerabilidades, y el open source se esta ahogando en basura automatizada. El poder sin conocimiento produce ruido, no progreso.

### Por que importa

- Cuestiona la narrativa dominante de "la IA siempre mejora la productividad".
- Los mantenedores open source enfrentan burnout acelerado.
- Plantea un debate etico sobre responsabilidad al usar herramientas de IA.
- Invita a la audiencia a reflexionar: ¿cual es el rol del ingeniero cuando el codigo se genera solo?

### Referencias

- Estudio METR: https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/
- GitHub Kill Switch: https://www.opensourceforu.com/2026/02/github-weighs-pull-request-kill-switch-as-ai-slop-floods-open-source/
- Octoverse 2025: https://github.blog/news-insights/octoverse/octoverse-a-new-developer-joins-github-every-second-as-ai-leads-typescript-to-1/
- What to expect for Open Source in 2026: https://github.blog/open-source/maintainers/what-to-expect-for-open-source-in-2026/
- Impacto economico: https://pytorch.org/blog/open-source-ai-is-transforming-the-economy-heres-what-the-data-shows/

---

## Estructura Sugerida para los 45 Minutos

| Tiempo | Seccion | Contenido |
|--------|---------|-----------|
| 0-3 min | **Apertura** | Pregunta provocadora: "¿Que pasa cuando cualquier persona en el mundo puede construir software con IA, gratis, desde su laptop? ¿Y que pasa cuando no entiende lo que genero?" |
| 3-18 min | **Acto 1: Agentes** | Que es un agente de codigo vs usar un modelo directamente. La filtracion de Claude Code: las 7 capas del harness, 512K lineas, KAIROS, anti-distillation. Demo o video. Por que 188K tokens en Cursor = 33K en Claude Code. Claw-Code: 50K stars en 2 horas. |
| 18-28 min | **Acto 2: Modelos locales** | Demo en vivo: Ollama + Gemma 4 E4B en la RTX 3060. DeepSeek R1 bajo licencia MIT. Cuantizacion explicada. Un modelo de 4B parametros corre en 3GB de RAM. Costo: ~$3.5 USD/mes vs $90/MTok en la nube. Las barreras economicas desaparecieron. |
| 28-40 min | **Acto 3: El precio** | METR: 19% mas lentos creyendo ser 24% mas rapidos. Veracode: 2.74x mas vulnerabilidades. Slopsquatting. El gorila en el CT scan. AI slop quebrando el open source. xz-utils como caso de estudio. Checklist de validacion. "Si no puedes explicarlo, no lo mergees." |
| 40-45 min | **Cierre** | Agentes + modelos locales = poder sin precedentes. Pero: poder sin conocimiento es una nueva superficie de ataque. El rol del ingeniero ya no es escribir codigo — es entender, validar y tomar responsabilidad por lo que la IA genera. Ese criterio es lo que ustedes estan formando ahora. |

---

## Ideas Adicionales Investigadas (Anexo)

Las siguientes ideas fueron investigadas como parte de la preparacion y pueden usarse como material complementario, preguntas del publico, o ponencias futuras.

### Rust en el Kernel de Linux

Rust se expande en el kernel Linux (drivers de red, driver GPU "Nova" para NVIDIA, Binder para Android). Google reporto que bugs de memory safety en Android cayeron ~50% con mas codigo Rust. sudo-rs ya es production-ready. Ferrocene certifica Rust para ISO 26262.
- Refs: https://rust-for-linux.com, https://security.googleblog.com/, https://ferrocene.dev

### RISC-V: Soberania Tecnologica

China (Xiangshan), India (Shakti), UE (European Processor Initiative), alianza RISE impulsan RISC-V. Milk-V Pioneer ofrece workstations de 64 nucleos.
- Refs: https://riscv.org, https://riseproject.dev, https://github.com/OpenXiangShan/XiangShan

### Crisis de Licencias Open Source

HashiCorp → BSL (fork: OpenTofu), Redis → source-available (fork: Valkey), Elastic → volvio a AGPL. OSI publico OSAID v1.0 pero es controversial. "Open washing" en modelos de IA.
- Refs: https://opensource.org/ai, https://opentofu.org, https://valkey.io

### WebAssembly como Plataforma Universal

WASI Preview 2, Docker + WASM, wasmCloud 1.0, Spin 2.x. Arranque en microsegundos vs segundos de contenedores.
- Refs: https://bytecodealliance.org, https://wasmcloud.com, https://fermyon.com/spin

### Frameworks de Agentes de IA

CrewAI (45K stars), LangGraph 1.0, AutoGen (54K stars), SWE-agent (Princeton). 34.5M descargas en 2025 (+340% YoY).
- Refs: https://github.com/crewAIInc/crewAI, https://github.com/langchain-ai/langgraph

### EU Cyber Resilience Act

Vigente desde dic 2024. Introduce "open source steward". Preocupaciones sobre efecto disuasorio en contribuidores voluntarios.
- Refs: Regulation (EU) 2024/2847, https://eclipse-foundation.blog/

### Seguridad del Supply Chain (xz, polyfill.io)

Backdoor xz-utils (CVE-2024-3094): 2 anos de ingenieria social. polyfill.io: +100K sitios afectados. Fragilidad del modelo de mantenedor solitario.
- Refs: https://nvd.nist.gov/vuln/detail/CVE-2024-3094, https://opensourcepledge.com

### MCP (Model Context Protocol)

Estandar abierto (MIT) para conectar modelos de IA con herramientas. Creado por Anthropic (nov 2024), donado a Linux Foundation (dic 2025). 97M descargas mensuales, 10K+ servidores. Adoptado por OpenAI, Google, Microsoft. Resuelve el problema N x M de integraciones.
- Refs: https://modelcontextprotocol.io, https://www.anthropic.com/news/model-context-protocol

### Computacion Cuantica Open Source

Qiskit 1.0 (IBM), Cirq (Google/Willow), PennyLane, CUDA Quantum. Software open source como capa de acceso al hardware cuantico.
- Refs: https://qiskit.org, https://quantumai.google/cirq
