# Workflow de Preparación — Simposio UPTC 2026

Documento de estado y guía para continuar la preparación de la ponencia desde el Mac.

**Última actualización:** 2026-04-23
**Hardware principal:** MacBook Pro M5 Max, 36 GB unified memory, macOS 26.4.1

---

## 1. Contexto del proyecto

**Ponencia:** *IA Abierta: El Poder, la Arquitectura y el Precio de No Entender lo que Generas*
**Duración:** 45 minutos
**Fecha:** Abril 2026 (Simposio UPTC)
**Audiencia:** Profesores y estudiantes de últimos semestres de Ingeniería de Sistemas

### Tesis central
La IA dejó de ser un servicio exclusivo: cualquiera puede correr modelos competitivos en su laptop y usar agentes autónomos. Ese poder es inédito, pero peligroso si no se entiende. El rol del ingeniero es **entender, validar y responsabilizarse**.

### Estructura de 3 actos
1. **Agentes de IA y la filtración de Claude Code** — cómo funciona por dentro
2. **Modelos abiertos en hardware local** (demo en vivo)
3. **El precio de no entender** — AI slop, vulnerabilidades, responsabilidad

---

## 2. Fase conceptual — preguntas y respuestas clave

Estas son las 5 preguntas pedagógicas que validaste. Sirven como **material para responder en el Q&A** de la ponencia.

### Pregunta 1 — ¿Por qué Gemma 4 26B MoE pesa 18 GB y no 52 GB o 104 GB?

**Respuesta:** Está cuantizado a 4 bits (Q4_K_M), lo que reduce cada peso a 0.5 bytes. Los 13 GB teóricos (26B × 0.5) más ~5 GB de overhead (metadata, tokenizer, chat template, router MoE) dan los 18 GB reales.

**Matiz:** Q4 no es la precisión más baja. La escalera baja hasta Q2_K o IQ1_S, pero Q4_K_M es el sweet spot donde la degradación es imperceptible (~2% vs FP16) con ahorro de 75% de memoria.

### Pregunta 2 — En una laptop de 16 GB, ¿podés correr Gemma 4 26B MoE?

**Respuesta:** No cabe: 18 GB del modelo + 4-6 GB de KV cache + 6-8 GB del sistema superan los 32 GB. Bajar a Q3_K_M (~14 GB) es viable pero pierde 5-8% de calidad y degrada tool calling.

**Mejor alternativa:** usar Gemma 4 E4B en Q4_K_M (10 GB) — la regla general es que un modelo más pequeño bien cuantizado rinde mejor que uno grande mal cuantizado.

### Pregunta 3 — PC con RTX 4080 (16 GB VRAM) + 32 GB RAM vs MacBook Air M3 con 24 GB unificada, ¿cuál corre mejor Gemma 4 26B MoE?

**Respuesta corta:** El Mac, por memoria unificada.

**Respuesta completa:**
- Para modelos grandes (20B+): gana el Mac — la GPU usa toda la RAM sin pasar por PCIe
- Para modelos medianos (7B-14B) que caben en VRAM dedicada: gana el PC — RTX 4080 tiene 49 TFLOPS vs ~4 TFLOPS del M3
- Regla: **memoria unificada gana cuando el modelo es grande; GPU dedicada gana cuando cabe en VRAM**
- Tu M5 Max rompe ambos lados: 36 GB unificados + 18 TFLOPS GPU

### Pregunta 4 — Claude Code con Gemma local dice "no puedo leer archivos". ¿Diagnóstico?

**Respuesta:** Ollama está truncando el contexto. Default es `num_ctx=4096`, pero Claude Code inyecta ~35K tokens (system prompt + definiciones de herramientas). Se cortan los primeros 31K, el modelo nunca ve las herramientas, parece estar sin capacidades.

**Solución:** `OLLAMA_CONTEXT_LENGTH=32768` antes de lanzar el servidor (o configurarlo en la app nativa).

### Pregunta 5 — ¿Por qué no usar Opus 4.6 directo desde la API en vez de Claude Code?

**Respuesta:** Analogía inicial: Opus solo es un científico brillante en una habitación sin libros, computador ni laboratorio. Claude Code lo equipa con todo.

**Tres capas concretas que tendrías que replicar:**
1. **Sistema de herramientas (~40 tools)** — esquemas JSON, parseo, ejecución, retroalimentación
2. **Sistema de permisos + clasificador independiente** — 3 tiers, sandbox OS-level, antijailbreak
3. **Gestión de contexto** — 5 estrategias de compactación, memoria persistente, subagentes

La filtración del source map (31 marzo 2026) expuso las 512,000 líneas exactas que hacen esto. Proyectos como Claw-Code están replicándolo en Python.

---

## 3. Estado técnico actual

### En el desktop Ubuntu (donde se ha trabajado hasta ahora)
- ✅ Repo creado: https://github.com/enruana/simposio-uptc-abril-2026
- ✅ Toda la documentación y scripts subidos
- ✅ Investigación completa en `docs/`

### En el Mac M5 Max (donde va el demo)
- ✅ Claude Code 2.1.118 instalado en `~/.local/bin/claude`
- ✅ Autenticado y funcional (sesiones activas en `~/.claude/`)
- ✅ Ollama instalado (app nativa, v0.21.1)
- ✅ Context length configurado a 32K
- ✅ Gemma 4 E4B descargado (9.6 GB) — eval rate: **84.97 tok/s**
- ✅ Gemma 4 26B MoE descargado (17 GB) — eval rate: **85.52 tok/s**

### Hallazgos confirmados empíricamente
- **Ambos modelos corren a ~85 tok/s** en el M5 Max (MoE confirma teoría)
- **Thinking mode visible** en Gemma 4 — oro para la demo (se puede mostrar el razonamiento)
- **Cold start 26B: 5.58s** (normal para 17 GB)
- **Prompt eval rate 129.94 tok/s** — procesa input muy rápido

---

## 4. Tareas completadas

### Fase conceptual
- [x] #1 Pesos de modelos y cuánto ocupan
- [x] #2 Cuantización Q4_K_M y trade-offs
- [x] #3 Memoria unificada vs VRAM dedicada
- [x] #4 Context window y KV cache
- [x] #5 Modelo raw vs agent harness

### Instalación y setup
- [x] #6 Verificar Claude Code funcional
- [x] #7 Instalar Ollama en macOS
- [x] #8 Configurar Ollama con context length grande

### Modelos
- [x] #9 Descargar Gemma 4 E4B
- [x] #10 Descargar Gemma 4 26B MoE

---

## 5. Tareas pendientes (para ejecutar desde el Mac)

### Tarea 11 — Benchmark formal y documentado

**Qué:** Correr el script `scripts/benchmark.sh` en el Mac para generar números citables de rendimiento.

**Cómo:**
```bash
cd ~/Desktop/simposio-uptc-abril-2026  # o donde clones el repo
cd scripts
./benchmark.sh
```

**Tiempo:** 3-5 minutos.

**Output esperado:**
- `benchmark-results.md` con tabla comparativa E4B vs 26B en 3 tareas
- Carpeta `responses/` con las respuestas completas

**Qué pasar al siguiente paso:** el contenido del `benchmark-results.md`.

---

### Tarea 12 — Crear `~/.claude/settings.json` optimizado para modelos locales

**Qué:** Agregar variables de entorno a Claude Code para que funcione bien con backends locales.

**Cuidado:** tu `settings.json` actual tiene config de voice. **Hay que hacer MERGE, no sobreescribir.**

**Estado actual:**
```json
{
  "voiceEnabled": true,
  "voice": {
    "enabled": true,
    "mode": "hold"
  }
}
```

**Estado objetivo:**
```json
{
  "voiceEnabled": true,
  "voice": {
    "enabled": true,
    "mode": "hold"
  },
  "env": {
    "CLAUDE_CODE_ATTRIBUTION_HEADER": "0",
    "DISABLE_PROMPT_CACHING": "1",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "API_TIMEOUT_MS": "600000",
    "DISABLE_INTERLEAVED_THINKING": "1"
  }
}
```

**Por qué cada flag:**
- `CLAUDE_CODE_ATTRIBUTION_HEADER=0` — evita invalidar KV cache (~90% slowdown sin esto)
- `DISABLE_PROMPT_CACHING=1` — Ollama no entiende los cache_control fields de Anthropic
- `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1` — 100% local, sin telemetría
- `API_TIMEOUT_MS=600000` — 10 min para tareas largas en local
- `DISABLE_INTERLEAVED_THINKING=1` — Gemma no soporta thinking blocks de Claude

**Comando sugerido para el merge:**
```bash
# Backup primero
cp ~/.claude/settings.json ~/.claude/settings.json.bak

# Usar jq para agregar env preservando el resto
jq '. + {env: {
  "CLAUDE_CODE_ATTRIBUTION_HEADER": "0",
  "DISABLE_PROMPT_CACHING": "1",
  "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
  "API_TIMEOUT_MS": "600000",
  "DISABLE_INTERLEAVED_THINKING": "1"
}}' ~/.claude/settings.json > /tmp/settings.json && mv /tmp/settings.json ~/.claude/settings.json

# Verificar
cat ~/.claude/settings.json
```

---

### Tarea 13 — Crear el script `claude-local`

**Qué:** Atajo de terminal que lanza Claude Code apuntando a Gemma 4 local.

**Cómo:**
```bash
mkdir -p ~/bin

cat > ~/bin/claude-local <<'SCRIPT'
#!/bin/bash
# Lanza Claude Code apuntando a Ollama (Gemma 4 local)
# Uso: claude-local [modelo]
# Default: gemma4:e4b
# Potencia: claude-local gemma4:26b

export ANTHROPIC_BASE_URL="http://localhost:11434"
export ANTHROPIC_AUTH_TOKEN="ollama"
export ANTHROPIC_API_KEY=""

MODEL="${1:-gemma4:e4b}"
shift || true

echo "Claude Code → $MODEL (via Ollama local)"
exec claude --model "$MODEL" "$@"
SCRIPT

chmod +x ~/bin/claude-local

# Agregar al PATH si no está
if ! echo $PATH | grep -q "$HOME/bin"; then
  echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
fi

source ~/.zshrc
which claude-local
```

---

### Tarea 14 — Primera prueba Claude Code + Gemma 4 E4B

**Qué:** Validar end-to-end que el pipeline funciona.

**Setup:**
```bash
mkdir -p ~/demo-ponencia-uptc
cd ~/demo-ponencia-uptc

cat > vulnerable_login.py <<'EOF'
def login(user, password):
    query = f"SELECT * FROM users WHERE user={user} AND pass={password}"
    return db.execute(query)
EOF
```

**Prueba:**
```bash
claude-local gemma4:e4b
```

**Dentro de Claude Code:**
```
> Lee vulnerable_login.py y dime si tiene problemas de seguridad.
  Si los tiene, escribe una versión corregida.
```

**Resultado esperado:**
1. Pide permiso Read → aprobar
2. Identifica SQL injection
3. Pide permiso Write/Edit → aprobar
4. Genera versión con parametrización

**Si falla:** diagnosticar con las respuestas de la Pregunta 4 (context truncation).

---

### Tarea 15 — Prueba con Gemma 4 26B MoE

**Qué:** Validar que el modelo estrella funciona para la demo.

```bash
cd ~/demo-ponencia-uptc
claude-local gemma4:26b
```

**Prompt más ambicioso:**
```
> Analiza la estructura de este directorio. Crea un script Python
  `analyze_csv.py` que reciba un CSV, calcule estadísticas por columna,
  detecte outliers, e imprima un reporte formateado. Usa solo stdlib.
```

**Medir:** tiempo total, cantidad de turnos, calidad del código.

---

### Tarea 16 — Directorio completo de demo con archivos pre-preparados

**Qué:** Preparar ambiente con varios archivos listos para el demo en vivo (NO improvisar frente a la audiencia).

**Archivos a crear en `~/demo-ponencia-uptc/`:**
1. `vulnerable_login.py` — código con SQL injection (ya creado en #14)
2. `data.csv` — datos de ejemplo para análisis
3. `src/`, `tests/`, `docs/` — estructura de proyecto
4. `README.md` — contexto del proyecto demo
5. `CLAUDE.md` — memoria del proyecto

**Ver detalles en `ideas-ponencia.md` y `docs/guia-practica-mac-m5max.md`.**

```bash
cd ~/demo-ponencia-uptc
git init
git add .
git commit -m "Initial demo setup"
```

---

### Tarea 17 — Escribir guion del demo minuto a minuto

**Qué:** Documento con el flow exacto de la demo en vivo.

**Ubicación sugerida:** `docs/guion-demo-en-vivo.md` en este repo.

**Estructura:**
- Minuto 0-1: Setup visual
- Minuto 1-2: Claude Code con API Anthropic (baseline)
- Minuto 2-3: El reveal de Gemma 4 corriendo local
- Minuto 3-4: El switch dramático (apagar WiFi)
- Minuto 4-5: Punchline y cierre

**Incluir exactos:**
- Comandos a ejecutar
- Prompts que se van a escribir
- Frases de narración en cada paso
- Qué debe verse en pantalla en cada momento

---

### Tarea 18 — Grabar video backup del demo

**Qué:** Video del demo completo funcionando (plan B si algo falla en vivo).

**Herramienta:** QuickTime Player (Cmd+5).

**Grabaciones:**
1. Versión completa (4-5 min) del flow del guion
2. Clips cortos de momentos clave:
   - `ollama ps` mostrando GPU al 100%
   - `networksetup airport off` + ping fallando
   - Claude Code generando código offline

**Guardar en:** `~/Desktop/Me/simposio-uptc-abril-2026/media/` (ignorado en git por tamaño).

---

### Tarea 19 — Slides base para los 3 actos

**Qué:** Deck de 30-40 slides para acompañar la ponencia.

**Tool sugerida:** Keynote o Google Slides.

**Estructura (ver detalle en la tarea #19 original):**
- Apertura (3 slides)
- Acto 1: Agentes (8-10 slides)
- Acto 2: Modelos locales + DEMO (10 slides)
- Acto 3: El precio (10 slides)
- Cierre (3-5 slides)

**Diseño:**
- Fondo oscuro (mejor para proyección)
- Un punto por slide
- Datos en tipografía grande
- Más imágenes/diagramas, menos texto

**Material base:** todos los documentos en `docs/` tienen el contenido listo para extraer.

---

### Tarea 20 — Checklist pre-ponencia (día-de)

**Qué:** Lista física para imprimir y llevar.

**Ver plantilla completa en el WORKFLOW anterior (esta sección del documento antes creado). Los puntos críticos:**

- MacBook al 100% + cargador conectado
- Modo "No molestar" activado
- Ollama corriendo (`ollama ps` verde)
- Gemma 4 26B pre-calentado
- Claude Code autenticado
- Directorio `~/demo-ponencia-uptc` con archivos
- Video backup en Desktop
- Slides respaldados en USB + Drive + email
- Agua a mano

---

### Tarea 21 — Ensayo completo cronometrado (2 pases)

**Qué:** Practicar la ponencia completa con reloj.

**Cronograma de ensayo:**
- Primer pase: ~50-55 min (encontrando baches)
- Segundo pase: ~45 min exactos (en serio, sin parar)

**Grabar audio del segundo ensayo.** Escuchar después para detectar:
- Palabras vacías ("eh", "este")
- Ritmo demasiado rápido
- Explicaciones confusas
- Transiciones abruptas entre actos

**Distribución de tiempo objetivo:**
- Apertura: 3 min
- Acto 1: 15 min
- Acto 2: 10 min (incluye demo en vivo)
- Acto 3: 12 min
- Cierre: 5 min
- **Total:** 45 min

---

## 6. Archivos de referencia en este repo

| Archivo | Para qué |
|---------|----------|
| `propuesta-ponencia.md` | Propuesta ejecutiva para organizadores |
| `ideas-ponencia.md` | Reporte completo de investigación en 3 actos |
| `docs/fundamentos-completos.md` | Estudio profundo de cada tema (ANEXO A sobre MCP complementario) |
| `docs/deep-dive-agent-architecture.md` | Arquitectura de agentes con detalles |
| `docs/guia-modelos-locales.md` | Guía práctica de modelos locales |
| `docs/guia-practica-claude-code-gemma.md` | Integración Claude Code + Ollama |
| `docs/guia-practica-mac-m5max.md` | Guía específica para MacBook M5 Max |
| `scripts/benchmark.sh` | Script de benchmark E4B vs 26B |
| `WORKFLOW.md` | Este documento — estado y pasos siguientes |

---

## 7. Comandos rápidos de referencia

```bash
# Ver modelos disponibles
ollama list

# Ver modelos cargados en memoria
ollama ps

# Correr un prompt rápido
ollama run gemma4:26b "prompt"

# Claude Code con Anthropic API (normal)
claude

# Claude Code con Gemma 4 local
claude-local gemma4:26b

# Verificar Ollama responde
curl http://localhost:11434/api/tags

# Ver GPU en acción
sudo powermetrics --samplers gpu_power -i 1000 -n 5
# O Activity Monitor → pestaña GPU

# Apagar/prender WiFi (para el demo dramático)
networksetup -setairportpower airport off
networksetup -setairportpower airport on

# Pre-calentar modelo antes de la ponencia
ollama run gemma4:26b "ready" <<< ""
```

---

## 8. Filosofía de la ponencia

Si hay que resumir todo en una frase para recordar durante la charla:

> **"El poder es real. La responsabilidad también. Tu conocimiento vale más ahora, no menos."**

Cada acto refuerza esta idea desde un ángulo distinto:
- Acto 1: entender lo que hace Claude Code es posible porque la filtración lo expuso
- Acto 2: correr IA localmente es posible porque open source eliminó las barreras
- Acto 3: saber qué aceptar y qué rechazar es tu responsabilidad profesional
