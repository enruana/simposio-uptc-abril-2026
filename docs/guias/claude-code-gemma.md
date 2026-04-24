# Guia Practica: Claude Code + Gemma 4 Local

**Objetivo:** Entender la estructura de Claude Code, correr Gemma 4 localmente, y conectar ambos. Material para demo en vivo en la ponencia UPTC.

**Hardware de referencia:** AMD Ryzen 7 5700X, NVIDIA RTX 3060 12GB, 16GB RAM, Ubuntu 24.04.

---

## PARTE A: Estructura practica de Claude Code

### A.1 Instalacion en Ubuntu 24.04

**Recomendado (instalador nativo, sin dependencia de Node.js):**
```bash
curl -fsSL https://claude.ai/install.sh | bash
```
Instala en `~/.local/bin/claude` + payload versionado en `~/.local/share/claude`. Auto-actualiza en background.

**Via apt (repo firmado):**
```bash
sudo install -d -m 0755 /etc/apt/keyrings
sudo curl -fsSL https://downloads.claude.ai/keys/claude-code.asc -o /etc/apt/keyrings/claude-code.asc
echo "deb [signed-by=/etc/apt/keyrings/claude-code.asc] https://downloads.claude.ai/claude-code/apt/stable stable main" \
  | sudo tee /etc/apt/sources.list.d/claude-code.list
sudo apt update && sudo apt install claude-code
```

**Verificar:**
```bash
claude --version
claude doctor
```

**Autenticacion:**
- Claude subscription (Pro/Max/Team): `claude auth login` → OAuth en browser
- Anthropic Console (pay-as-you-go): `claude auth login --console`
- Token para CI: `claude setup-token`

Credenciales se guardan en `~/.claude/.credentials.json` (permisos 0600).

### A.2 Como funciona por dentro

`claude` es un binario nativo unico (no proceso Node). Cuando lo ejecutas:

1. Carga `~/.claude/settings.json` → `.claude/settings.json` (proyecto) → `.claude/settings.local.json` (personal)
2. Sube desde CWD cargando cada `CLAUDE.md` y `CLAUDE.local.md` que encuentra
3. Lanza MCP servers como subprocesos (stdio)
4. Conecta a `ANTHROPIC_BASE_URL` (default: `https://api.anthropic.com`)
5. Persiste sesion como JSONL en `~/.claude/projects/<slug>/<uuid>.jsonl` — cada mensaje, tool call y respuesta es una linea
6. Ejecuta herramientas localmente (Bash, Read, Write, Edit, Glob, Grep, etc.)

### A.3 Estructura de directorios

```
~/.claude/
├── .credentials.json         # Tokens OAuth
├── settings.json             # Config de usuario
├── settings.local.json       # Overrides personales
├── projects/<slug>/*.jsonl   # Transcripts de sesion por proyecto
├── sessions/                 # Metadata de sesiones
├── todos/, tasks/, plans/    # Estado del agente
├── file-history/             # Historial de ediciones (para undo)
├── shell-snapshots/          # Envs de shell por sesion
├── session-env/              # Env files por sesion
├── plugins/                  # Plugins instalados
└── cache/, downloads/, paste-cache/, debug/

<project>/.claude/
├── settings.json             # Config compartida del equipo (commit)
├── settings.local.json       # Personal (gitignored)
├── skills/                   # Skills del proyecto
├── agents/                   # Definiciones de subagentes
├── hooks/                    # Scripts de hooks
└── commands/                 # Slash commands custom
<project>/.mcp.json           # MCP servers del proyecto (commit)
<project>/CLAUDE.md           # Memoria del proyecto (commit)
<project>/CLAUDE.local.md     # Memoria personal (gitignored)
```

### A.4 Anatomia de settings.json

```json
{
  "model": "claude-sonnet-4-6",
  "autoUpdatesChannel": "stable",
  "env": {
    "DISABLE_AUTOUPDATER": "0"
  },
  "permissions": {
    "defaultMode": "default",
    "allow": ["Bash(git status)", "Bash(git diff *)", "Read", "WebSearch"],
    "deny":  ["Bash(rm -rf *)", "Edit(.env)"],
    "ask":   ["Bash(git push *)"]
  },
  "hooks": {
    "PostToolUse": [...]
  }
}
```

**Permisos — orden de evaluacion:** deny → ask → allow. Deny siempre gana.

**Modos de permiso** (cambiar con `Shift+Tab` in-session):
- `default` — reads OK, pregunta en writes/Bash
- `acceptEdits` — auto-aprueba ediciones
- `plan` — solo analisis, no modificaciones
- `auto` — clasificador built-in decide
- `bypassPermissions` — skip prompts (aun respeta deny rules)

### A.5 Seleccion de modelo

**Aliases disponibles:**
- `opus` → claude-opus-4-7 (el mas capaz)
- `sonnet` → claude-sonnet-4-6 (default, mejor balance)
- `haiku` → claude-haiku-4-5 (mas rapido y barato)
- `opusplan` — hibrido: Opus para plan, auto-switch a Sonnet para implementacion

**Formas de cambiar modelo:**
```bash
claude --model sonnet              # Por sesion
claude --model claude-opus-4-7     # ID completo
```

**In-session:**
```
/model             # Picker interactivo
/model opus        # Switch directo
```

**En `settings.json`:**
```json
{ "model": "sonnet" }
```

**Variables de entorno:**
- `ANTHROPIC_MODEL` — modelo default
- `ANTHROPIC_DEFAULT_OPUS_MODEL`, `ANTHROPIC_DEFAULT_SONNET_MODEL`, `ANTHROPIC_DEFAULT_HAIKU_MODEL` — overrides por alias

### A.6 Variables de entorno criticas (la llave para usar modelos locales)

| Variable | Proposito |
|----------|----------|
| `ANTHROPIC_BASE_URL` | Override del host API (default: `https://api.anthropic.com`) |
| `ANTHROPIC_API_KEY` | Header `x-api-key` |
| `ANTHROPIC_AUTH_TOKEN` | Header `Authorization: Bearer <token>` |
| `ANTHROPIC_MODEL` | Modelo default |
| `ANTHROPIC_CUSTOM_HEADERS` | Headers extra |
| `API_TIMEOUT_MS` | Timeouts mas largos para inferencia local |
| `DISABLE_PROMPT_CACHING` | Desactivar cache headers que backends locales no entienden |
| `CLAUDE_CODE_ATTRIBUTION_HEADER` | "0" para desactivar (causa ~90% slowdown en locales) |

### A.7 Comandos slash mas importantes

| Comando | Proposito |
|---------|----------|
| `/help` | Referencia |
| `/model [alias]` | Cambiar modelo |
| `/clear` | Wipe conversacion |
| `/compact [focus]` | Resumir historia para liberar tokens |
| `/config` | Editor de settings interactivo |
| `/mcp` | Status de MCP servers + OAuth |
| `/hooks` | Browser de hooks |
| `/agents` | Listar subagentes |
| `/memory` | Editar CLAUDE.md |
| `/init` | Generar CLAUDE.md starter para el codebase |
| `/review` | Review de PR |
| `/security-review` | Auditar cambios pendientes |

**Shortcuts interactivos:**
- `Shift+Tab` — cicla modos de permiso
- `Ctrl+O` — abre transcript (muestra hook firings)
- `Esc` — interrumpe el modelo
- `!<cmd>` — ejecuta comando shell
- `#` — agrega al CLAUDE.md

---

## PARTE B: Gemma 4 local en tu RTX 3060

### B.1 Prerequisitos: Driver NVIDIA

**El orden importa.** Ollama detecta el driver al instalarse. Si no esta, instala version CPU-only silenciosamente.

```bash
sudo ubuntu-drivers list
sudo ubuntu-drivers autoinstall
sudo reboot
```

Despues del reboot:
```bash
nvidia-smi
```

Deberias ver tu RTX 3060, driver 550+ (para soporte Ampere optimo), y version CUDA. **NO necesitas instalar CUDA Toolkit** — Ollama trae su propio runtime CUDA.

### B.2 Instalar Ollama

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

Crea usuario/grupo `ollama`, instala binario en `/usr/local/bin/ollama`, monta systemd unit y arranca el servicio.

### B.3 Variantes de Gemma 4 y cual elegir para tu GPU

Gemma 4 (2 abril 2026) viene en 4 tamanos, todos Apache 2.0, multimodales, con function calling nativo.

| Variante | Comando | Tamano | VRAM | Cabe en 12GB? | Tokens/s esperado |
|----------|---------|--------|------|---------------|-------------------|
| E2B Q4_K_M | `ollama pull gemma4:e2b` | 7.2 GB | ~5 GB | Si, comodo | 90-150 |
| E2B Q8_0 | `ollama pull gemma4:e2b-it-q8_0` | 8.1 GB | ~8 GB | Si | 70-110 |
| **E4B Q4_K_M** | `ollama pull gemma4:e4b` | 9.6 GB | ~6-8 GB | **Si — recomendado** | **50-80** |
| E4B Q8_0 | `ollama pull gemma4:e4b-it-q8_0` | 12 GB | ~12 GB | Justo, spillover parcial | 30-50 |
| 26B MoE Q4_K_M | `ollama pull gemma4:26b` | 18 GB | ~14-18 GB | NO en GPU completa | 8-15 con spillover |
| 31B Dense Q4_K_M | `ollama pull gemma4:31b` | 20 GB | ~20 GB | NO, muy grande | No intentar |

`gemma4:latest` = alias de `gemma4:e4b-it-q4_K_M`.

**Recomendacion para tu maquina:** `gemma4:e4b`. Cabe 100% en GPU, balance optimo calidad/velocidad, function calling nativo, contexto 128K.

### B.4 Verificar que la GPU se esta usando

```bash
ollama pull gemma4:e4b
ollama run gemma4:e4b "Dime hola en una oracion."
```

En otra terminal, con el modelo cargado:
```bash
ollama ps
```

Mira la columna `PROCESSOR`. Debe decir `100% GPU`. Si dice `CPU` o `XX% CPU / YY% GPU`, esta haciendo spillover.

Verifica tambien con `nvidia-smi` — deberias ver el proceso `ollama` consumiendo VRAM.

### B.5 Habilitar acceso remoto (si lo necesitas para la demo)

El servicio fue instalado por systemd, asi que `export OLLAMA_HOST` desde shell no tiene efecto. Debes editar el unit de systemd:

```bash
sudo systemctl edit ollama.service
```

Agregar este bloque, guardar y salir:
```ini
[Service]
Environment="OLLAMA_HOST=0.0.0.0:11434"
Environment="OLLAMA_ORIGINS=*"
Environment="OLLAMA_CONTEXT_LENGTH=32768"
```

**Importante:** `OLLAMA_CONTEXT_LENGTH=32768` es CRITICO para Claude Code. El default de 4K trunca silenciosamente el prompt de Claude Code (~35K tokens) y el modelo nunca ve las herramientas.

Luego:
```bash
sudo systemctl daemon-reload
sudo systemctl restart ollama
ss -tlnp | grep 11434        # Debe decir 0.0.0.0:11434
```

### B.6 APIs disponibles

**Endpoints nativos:**
- `POST /api/generate` — single-turn completion
- `POST /api/chat` — multi-turn chat (con tools)
- `GET /api/tags` — listar modelos
- `POST /api/pull` — pull programatico
- `POST /api/embeddings` — embeddings

**Endpoints OpenAI-compatibles (drop-in):**
- `POST /v1/chat/completions` — API completa, soporta tools, streaming, JSON mode
- `POST /v1/completions` — legacy
- `POST /v1/embeddings` — embeddings
- `GET  /v1/models` — listar

**Endpoint Anthropic-compatible (CLAVE para Claude Code, desde Ollama v0.14):**
- `POST /v1/messages` — Anthropic Messages API nativo

### B.7 Test rapido de la API

```bash
# Chat con Ollama (nativo)
curl http://localhost:11434/api/chat -d '{
  "model": "gemma4:e4b",
  "messages": [{"role":"user","content":"Escribe un one-liner Python que invierta un string."}],
  "stream": false
}'

# OpenAI-compatible
curl http://localhost:11434/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ollama" \
  -d '{
    "model": "gemma4:e4b",
    "messages": [{"role":"user","content":"Say hello."}]
  }'
```

### B.8 Tool calling con Gemma 4

Gemma 4 soporta function calling de forma nativa en los tags oficiales de Ollama.

```bash
curl http://localhost:11434/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gemma4:e4b",
    "messages": [{"role":"user","content":"Cual es el clima en Bogota?"}],
    "tools": [{
      "type": "function",
      "function": {
        "name": "get_current_weather",
        "description": "Obtener temperatura actual de una ciudad",
        "parameters": {
          "type": "object",
          "properties": {
            "city": {"type":"string"},
            "unit": {"type":"string","enum":["celsius","fahrenheit"]}
          },
          "required": ["city"]
        }
      }
    }]
  }'
```

Respuesta esperada: `choices[0].message.tool_calls[0].function.name == "get_current_weather"` con `arguments` como JSON string.

### B.9 Limitaciones conocidas para la demo

- **E4B contra Claude Code puro:** Reportes de la comunidad indican que E4B lucha en loops agenticos multi-archivo de Claude Code. Para demo simple funciona, para tareas complejas conviene el 26B MoE con spillover (lento pero mas capaz).
- **Contexto practico:** 128K es el teorico. En tu 3060 con E4B Q4, el limite real con KV cache es ~32K.
- **Cold start:** Primera peticion despues de cargar el modelo toma 5-30s. **Pre-calienta con un curl dummy antes de la demo.**

---

## PARTE C: Conectar Claude Code con Gemma 4 local

### C.1 El insight clave

Claude Code es simplemente un cliente HTTP que habla la Anthropic Messages API. **No valida con quien habla.** Si le das un `ANTHROPIC_BASE_URL` diferente, habla con ese servidor. Ollama desde v0.14 implementa nativamente `/v1/messages` con semantica Anthropic. Esto significa:

**Puedes apuntar Claude Code a Gemma 4 corriendo localmente con 3 variables de entorno, sin proxy, sin ningun software adicional.**

### C.2 Recipe completa paso a paso

#### Paso 1: Verificar Ollama con contexto grande

**CRITICO:** El default de 4K tokens de Ollama trunca el prompt de Claude Code (que es ~35K). Edita el unit:

```bash
sudo systemctl edit ollama.service
```

Asegurate que tengas:
```ini
[Service]
Environment="OLLAMA_HOST=0.0.0.0:11434"
Environment="OLLAMA_CONTEXT_LENGTH=32768"
```

```bash
sudo systemctl daemon-reload
sudo systemctl restart ollama
```

#### Paso 2: Descargar Gemma 4

```bash
ollama pull gemma4:e4b
```

Pre-calienta:
```bash
ollama run gemma4:e4b "ready" <<< ""
```

#### Paso 3: Configurar Claude Code para evitar el bug del 90% slowdown

Crea/edita `~/.claude/settings.json`:

```json
{
  "env": {
    "CLAUDE_CODE_ATTRIBUTION_HEADER": "0",
    "DISABLE_PROMPT_CACHING": "1",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "API_TIMEOUT_MS": "600000"
  }
}
```

**Por que:** El header de atribucion default invalida el KV cache de modelos locales causando ~90% mas latencia.

#### Paso 4: Apuntar Claude Code a Ollama

```bash
export ANTHROPIC_BASE_URL="http://localhost:11434"
export ANTHROPIC_AUTH_TOKEN="ollama"
export ANTHROPIC_API_KEY=""
```

#### Paso 5: Lanzar Claude Code con Gemma 4

```bash
claude --model gemma4:e4b
```

O alternativamente, desde Ollama v0.14 hay un one-liner:
```bash
ollama launch claude --model gemma4:e4b
```

### C.3 Verificar que funciona

Una vez dentro de la sesion, prueba:
```
> Lee el archivo README.md y dime que dice
```

Si Gemma 4 usa la herramienta Read correctamente y te responde, funciona. Si dice cosas como "no tengo acceso a archivos", el contexto se esta truncando — incrementa `OLLAMA_CONTEXT_LENGTH`.

### C.4 Limitaciones reales

- **Sin prompt caching:** La optimizacion KV-cache de Anthropic es no-op localmente. Cada step hace full re-prefill.
- **Extended thinking es solo Claude:** Si ves errores de tipo `thinking` block, agrega `"DISABLE_INTERLEAVED_THINKING": "1"` al settings.
- **Loops agenticos debiles:** Gemma 4 E4B puede quedarse pegado re-llamando la misma herramienta. Mitigacion: quantizacion Q8 en vez de Q4, contexto >= 32K, usar 26B MoE para tareas complejas (lento pero mas robusto).
- **Context ceiling:** Claude Code asume 200K contexto. Localmente tienes 32K realista. `/compact` correra frecuentemente.
- **Feature parity:** Subagentes, MCP fan-out, tareas en background funcionan pero son mucho mas lentas.

### C.5 Plan B: Claude Code Router (si el path nativo falla)

Si durante la demo Ollama rechaza el schema de tools o streaming falla, tienes backup con [claude-code-router](https://github.com/musistudio/claude-code-router):

```bash
npm install -g @musistudio/claude-code-router
```

`~/.claude-code-router/config.json`:
```json
{
  "Providers": [{
    "name": "ollama",
    "api_base_url": "http://localhost:11434/v1/chat/completions",
    "api_key": "ollama",
    "models": ["gemma4:e4b", "gemma4:26b"],
    "transformer": { "use": ["enhancetool"] }
  }],
  "Router": {
    "default": "ollama,gemma4:e4b",
    "background": "ollama,gemma4:e4b"
  }
}
```

Lanzar:
```bash
ccr code
# o: eval "$(ccr activate)" && claude
```

El transformer `enhancetool` tolera JSON malformado en tool calls (critico para Gemma).

### C.6 Alternativa: herramientas que soportan modelos locales nativamente

Si queremos "experiencia estilo Claude Code" sin el baile del proxy, estas tienen soporte nativo para Ollama:

| Herramienta | Repo | Nota |
|-------------|------|------|
| **opencode** | `sst/opencode` | TUI vendor-neutral, soporta Ollama/OpenAI/Anthropic |
| **aider** | `Aider-AI/aider` | `aider --model ollama/gemma4:e4b` |
| **Continue.dev** | `continuedev/continue` | Extension VS Code/JetBrains |

---

## PARTE D: Script de Demo para la Ponencia

### Setup previo (hacer antes de la charla)

```bash
# 1. Instalar (si no esta)
curl -fsSL https://ollama.com/install.sh | sh
curl -fsSL https://claude.ai/install.sh | bash

# 2. Configurar Ollama para Claude Code
sudo systemctl edit ollama.service
# Agregar: Environment="OLLAMA_CONTEXT_LENGTH=32768"
sudo systemctl daemon-reload
sudo systemctl restart ollama

# 3. Descargar modelos
ollama pull gemma4:e4b
ollama pull gemma4:e2b  # Backup mas rapido

# 4. Pre-calentar
ollama run gemma4:e4b "ready" <<< ""

# 5. Configurar Claude Code
cat > ~/.claude/settings.json <<'JSON'
{
  "env": {
    "CLAUDE_CODE_ATTRIBUTION_HEADER": "0",
    "DISABLE_PROMPT_CACHING": "1",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "API_TIMEOUT_MS": "600000",
    "DISABLE_INTERLEAVED_THINKING": "1"
  }
}
JSON

# 6. Crear scripts de atajo
cat > ~/bin/claude-local <<'SCRIPT'
#!/bin/bash
export ANTHROPIC_BASE_URL="http://localhost:11434"
export ANTHROPIC_AUTH_TOKEN="ollama"
export ANTHROPIC_API_KEY=""
exec claude --model gemma4:e4b "$@"
SCRIPT
chmod +x ~/bin/claude-local
```

### Flow de la demo (3-4 minutos)

**Momento 1 — Mostrar Claude Code estandar (con API Anthropic):**
```bash
cd /tmp && mkdir demo-ponencia && cd demo-ponencia
claude
# > "Escribe un script Python que calcule Fibonacci"
```

**Momento 2 — Mostrar que es solo un cliente HTTP:**
```bash
# Exit de claude, luego:
env | grep ANTHROPIC
# Nada por ahora, apunta a api.anthropic.com por default
```

**Momento 3 — El switch a local:**
```bash
# En terminal:
ollama ps    # Muestra Gemma 4 cargado en GPU
nvidia-smi   # Muestra VRAM consumida

# Lanzar Claude Code con Gemma local:
claude-local
# > "Escribe un script Python que calcule Fibonacci"
```

**Momento killer para la audiencia:**
- Mostrar que no hay internet activo (`unplug wifi` o desactivar)
- Mostrar `nvidia-smi` activo con el proceso de Ollama
- Enfatizar: misma interfaz, misma experiencia, **cero costo, cero internet, todo en la maquina**

**Cierre:**
> "Esto es la democratizacion real. No necesitan $200 al mes. No necesitan internet. Pero necesitan entender lo que esta pasando — y eso es lo que viene en el Acto 3."

### Checklist pre-demo

- [ ] `ollama ps` muestra Gemma 4 cargado
- [ ] `nvidia-smi` muestra VRAM ocupada por ollama
- [ ] `curl http://localhost:11434/api/tags` responde
- [ ] `claude --version` funciona
- [ ] Variables de entorno exportadas o script `claude-local` listo
- [ ] Terminal con fuente >= 16pt para proyeccion
- [ ] Tema claro/oscuro consistente
- [ ] Un directorio de trabajo limpio listo
- [ ] Backup: tener `claude-code-router` configurado por si falla

---

## Referencias

- Claude Code Docs: https://code.claude.com/docs/en/setup
- Claude Code Settings: https://code.claude.com/docs/en/settings
- Ollama integration con Claude Code (oficial): https://docs.ollama.com/integrations/claude-code
- Ollama blog Anthropic compatibility: https://ollama.com/blog/claude
- Gemma 4 en Ollama: https://ollama.com/library/gemma4
- Gemma 4 Google DeepMind: https://deepmind.google/models/gemma/gemma-4/
- Claude Code Router: https://github.com/musistudio/claude-code-router
- Tool calling con Gemma 4: https://machinelearningmastery.com/how-to-implement-tool-calling-with-gemma-4-and-python/
- DataCamp tutorial: https://www.datacamp.com/tutorial/using-claude-code-with-ollama-local-models
- Jonathan's Blog guia completa: https://jonathansblog.co.uk/using-claude-code-with-local-llm-models-the-complete-guide
- PolySkill CCR guide: https://polyskill.ai/blog/claude-code-router
