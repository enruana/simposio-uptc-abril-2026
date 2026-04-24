# 🛠️ Scripts

Herramientas operativas para correr la demo de la ponencia y generar datos reproducibles.

---

## 📋 Contenido

| Script | Descripción | Ejecutable |
|--------|-------------|:----------:|
| [`claude-local`](claude-local) | Lanza Claude Code apuntando a un modelo Ollama local | ✅ |
| [`claude-mode.sh`](claude-mode.sh) | Alterna el `~/.claude/settings.json` entre modo Ollama y Anthropic | ✅ |
| [`benchmark.sh`](benchmark.sh) | Benchmark comparativo de modelos Gemma 4 (E4B vs 26B MoE) | ✅ |

---

## ⚡ Requisitos

Todos los scripts requieren:

- **macOS o Linux** (bash)
- **[Ollama](https://ollama.com)** instalado y corriendo (`ollama serve`)
- **[Claude Code](https://claude.ai/code)** instalado (`curl -fsSL https://claude.ai/install.sh | bash`)

Para los modelos, descargalos primero:

```bash
ollama pull gemma4:e4b      # modelo punto de entrada (4 GB)
ollama pull gemma4:26b      # modelo del demo (17 GB)
```

---

## 🎬 `claude-local`

Atajo para lanzar Claude Code con el modelo local de Ollama.

### Uso

```bash
./scripts/claude-local                # usa gemma4:e4b por defecto
./scripts/claude-local gemma4:26b     # usa el modelo 26B
./scripts/claude-local llama3.2       # o cualquier otro modelo de Ollama
```

### Qué hace

Configura las variables de entorno necesarias para que Claude Code apunte al servidor local de Ollama en vez de a la API de Anthropic:

```bash
ANTHROPIC_BASE_URL=http://localhost:11434
ANTHROPIC_AUTH_TOKEN=ollama
ANTHROPIC_API_KEY=""
```

Luego lanza `claude --model <nombre_modelo>`.

### Instalación como comando global (opcional)

```bash
# Copialo a tu PATH
cp scripts/claude-local ~/.local/bin/
chmod +x ~/.local/bin/claude-local

# Ahora podés usarlo desde cualquier lugar
claude-local gemma4:26b
```

---

## 🔄 `claude-mode.sh`

Alterna el archivo `~/.claude/settings.json` entre dos configuraciones:

- **Modo `ollama`** — Claude Code habla con Ollama local
- **Modo `anthropic`** — Claude Code habla con la API oficial (modo normal)

### Uso

```bash
./scripts/claude-mode.sh ollama       # activar modo Ollama local
./scripts/claude-mode.sh anthropic    # volver al modo API normal
./scripts/claude-mode.sh status       # ver en qué modo estás
```

### Cuándo usarlo

Durante la ponencia, querés tener:
1. Claude Code en **modo Anthropic** (API normal) para el primer demo "ChatGPT/Cursor"
2. Alternar a **modo Ollama** para el demo "sin internet con Gemma local"

Este script hace ese cambio de estado limpio y reversible sin tener que recordar exportar variables.

---

## 📊 `benchmark.sh`

Ejecuta un benchmark comparativo entre **Gemma 4 E4B** y **Gemma 4 26B MoE** con tres tareas (simple, razonamiento, complejo). Genera un reporte markdown con métricas citables.

### Uso

```bash
cd scripts
./benchmark.sh
```

### Qué genera

- `benchmark-results.md` — tabla con métricas (tokens/s, latencia, calidad percibida)
- `responses/` — carpeta con las respuestas completas de cada modelo para cada tarea

### Duración

~5-10 minutos dependiendo de tu hardware. El 26B tarda más.

### Output esperado (ejemplo en MacBook M5 Max)

```
Modelo      | Tarea        | Tokens/s | Tiempo total | Calidad
------------|--------------|----------|--------------|--------
gemma4:e4b  | Simple       | 54.3     | 8.2s         | Buena
gemma4:e4b  | Razonamiento | 48.1     | 15.4s        | Aceptable
gemma4:e4b  | Complejo     | 42.7     | 32.1s        | Aceptable
gemma4:26b  | Simple       | 31.2     | 12.8s        | Excelente
gemma4:26b  | Razonamiento | 28.6     | 24.7s        | Excelente
gemma4:26b  | Complejo     | 26.1     | 48.3s        | Excelente
```

---

## 🐛 Troubleshooting

### "Claude Code no responde / se queda colgado"

El problema más común: **contexto de Ollama demasiado chico**. Ollama por defecto usa 4096 tokens, pero Claude Code necesita ~35K para su system prompt + tools.

**Solución:** configurar `OLLAMA_CONTEXT_LENGTH=32768` antes de lanzar `ollama serve`:

```bash
export OLLAMA_CONTEXT_LENGTH=32768
ollama serve
```

O directamente en la app de Ollama: **Settings → Context Length → 32768**.

### "Gemma genera lentísimo la primera vez"

Es el **pre-calentamiento del modelo**. La primera request carga los pesos a memoria (5-10 segundos). Las siguientes son rápidas.

**Para la ponencia:** ejecutá un prompt dummy antes de subir al escenario:

```bash
ollama run gemma4:26b "hola"
```

### "Error: ANTHROPIC_BASE_URL not recognized"

Actualizá Claude Code a la última versión:

```bash
claude update
# o reinstalar:
curl -fsSL https://claude.ai/install.sh | bash
```

---

## 🔗 Ver también

- [`../docs/guias/claude-code-gemma.md`](../docs/guias/claude-code-gemma.md) — guía completa de la integración
- [`../docs/guias/modelos-locales.md`](../docs/guias/modelos-locales.md) — qué modelo usar según tu hardware
- [`../presentation/`](../presentation/) — la presentación que usa este demo
