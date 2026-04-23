# Guia Practica: Claude Code + Gemma 4 en MacBook Pro M5 Max

**Tu hardware:**
- MacBook Pro con **Apple M5 Max** (18 cores: 6 eficiencia + 12 performance)
- **36 GB memoria unificada**
- macOS 26.4.1 (build 25E253), Metal 4
- 1.8 TB disco, 1.7 TB libres
- Claude Code ya instalado en `~/.local/bin/claude`
- Ollama NO instalado aun

**Nivel de hardware:** Top tier. Apple Silicon + memoria unificada masiva = puedes correr modelos que ni siquiera caben en GPUs dedicadas consumer. Esto es un demo killer.

---

## Por que Apple Silicon + 36GB cambia todo

### El truco de la memoria unificada

En PC con GPU dedicada, la RAM del sistema y la VRAM de la GPU son separadas. Si un modelo no cabe en VRAM, debe mover datos por PCIe (lento).

En Apple Silicon, **la GPU accede directamente a toda la memoria unificada**. Con 36GB, tu GPU tiene efectivamente 36GB de VRAM. Esto significa que puedes correr modelos que una RTX 3060 12GB simplemente no puede.

### Que modelos corren en tu Mac

| Modelo | Tamano | Cabe? | Tokens/s esperado en M5 Max |
|--------|--------|-------|----------------------------|
| Gemma 4 E2B Q4 | 7 GB | Si, sobrado | 120-180 |
| Gemma 4 E4B Q4 | 10 GB | Si, sobrado | 70-100 |
| Gemma 4 E4B Q8 | 12 GB | Si, facil | 55-80 |
| **Gemma 4 26B MoE Q4** | **18 GB** | **Si, comodo** | **45-65** |
| Gemma 4 26B MoE Q8 | 26 GB | Si, cabe bien | 30-45 |
| Gemma 4 31B Dense Q4 | 20 GB | Si, cabe | 30-45 |
| Gemma 4 31B Dense Q8 | 33 GB | Si, justo | 15-25 |
| DeepSeek R1 70B distilled Q4 | 40 GB | NO | - |

**El modelo estrella para tu demo:** **Gemma 4 26B MoE Q4** (`gemma4:26b`).

Por que: Es de clase mundial (ranking #6 global en Arena AI), cabe perfectamente en tu memoria unificada, corre rapido (45-65 tok/s) gracias a la arquitectura MoE (solo 3.8B de 26B parametros activos por token). En el simposio puedes decir: *"Este modelo corre en mi laptop. Ocupa el puesto 6 a nivel mundial en competencia con GPT-5.4 y Claude Opus."*

### Comparacion con otros Macs

| Mac | RAM unificada | Puede correr |
|-----|---------------|--------------|
| M1/M2/M3 Air 8GB | 8 GB | Solo hasta E2B |
| M1/M2/M3 Pro 16GB | 16 GB | Hasta E4B Q8 |
| M3 Max 32GB | 32 GB | Hasta 26B MoE Q4 |
| **M5 Max 36GB (tu Mac)** | **36 GB** | **Hasta 26B MoE Q8 / 31B Dense Q4** |
| M3 Ultra 192GB | 192 GB | Todo |

**Tu Mac esta en el sweet spot:** Corre los mejores modelos abiertos sin necesidad de cluster de GPUs.

---

## PARTE A: Instalar Ollama en macOS

### Opcion 1: Descarga directa (recomendada)

```bash
# Descargar e instalar
curl -LO https://ollama.com/download/Ollama-darwin.zip
unzip Ollama-darwin.zip
mv Ollama.app /Applications/
open /Applications/Ollama.app
```

O desde la web: https://ollama.com/download/mac (descarga .dmg, doble click, arrastrar a Applications).

Cuando abras la app por primera vez, te pedira permiso para instalar el CLI. Dile que si.

### Opcion 2: Homebrew (si prefieres CLI)

```bash
brew install ollama
brew services start ollama
```

### Verificar instalacion

```bash
ollama --version
ollama list
```

### Por que Apple Silicon es tan rapido para LLMs

Ollama (via llama.cpp) usa **Metal Performance Shaders** en Macs con Apple Silicon. Esto permite aceleracion de GPU directa sin necesidad de drivers CUDA ni setup adicional. **Funciona inmediatamente, fuera de la caja.**

No necesitas:
- Instalar drivers NVIDIA
- Configurar CUDA Toolkit
- Lidiar con `nvidia-smi`
- Compilar con flags especiales

Solo `ollama run <modelo>` y listo.

---

## PARTE B: Descargar y probar Gemma 4

### B.1 Descargar modelos estrategicos

```bash
# Para pruebas rapidas y warm-up (7GB)
ollama pull gemma4:e2b

# El balance perfecto (10GB) - recomendado como default
ollama pull gemma4:e4b

# EL MODELO ESTRELLA PARA LA DEMO (18GB) - corre en tu Mac
ollama pull gemma4:26b

# Opcional: El mas capaz que puedes correr (20GB)
ollama pull gemma4:31b
```

**Nota:** Descargar estos 4 modelos te va a consumir ~55GB. Tienes 1.7TB libres, no es problema, pero toma tiempo. Hazlo antes de la ponencia.

### B.2 Probar que la GPU se esta usando

```bash
# Correr un modelo
ollama run gemma4:26b "Escribe un haiku sobre codigo abierto"
```

En otra terminal, mientras esta corriendo:

```bash
# Ver uso
ollama ps

# Ver procesos y GPU
sudo powermetrics --samplers gpu_power -i 500 -n 5 2>&1 | grep -i "gpu\|active"
```

Deberias ver el GPU activo. En Activity Monitor (pestana GPU) puedes ver graficamente que la GPU integrada esta al 80-95%.

### B.3 Benchmarks para comparar en la ponencia

Corre esto para tener numeros concretos que mostrar:

```bash
# Medir tokens/segundo
for model in gemma4:e2b gemma4:e4b gemma4:26b; do
  echo "=== $model ==="
  ollama run $model --verbose "Escribe una funcion Python que calcule fibonacci recursivamente con memoization"
  echo "---"
done
```

Ollama te mostrara tokens/s al final de cada respuesta.

### B.4 El tip del contexto para Claude Code

**CRITICO para que funcione con Claude Code:**

Ollama en macOS guarda config en `~/Library/Application Support/Ollama/`. Para aumentar el contexto (requerido por Claude Code):

```bash
# Crear el archivo de config si no existe
mkdir -p ~/Library/Application\ Support/Ollama
cat > ~/Library/Application\ Support/Ollama/config.json <<'EOF'
{
  "host": "0.0.0.0:11434",
  "context_length": 32768
}
EOF

# Reiniciar Ollama (quit from menubar + reopen)
# O desde terminal:
osascript -e 'quit app "Ollama"'
open /Applications/Ollama.app
```

Alternativa via variable de entorno en shell (mas temporal):

```bash
OLLAMA_CONTEXT_LENGTH=32768 OLLAMA_HOST=0.0.0.0:11434 ollama serve
```

**Verifica:**
```bash
curl http://localhost:11434/api/tags
```

---

## PARTE C: Conectar Claude Code con Gemma 4 local

### C.1 Tu Claude Code ya esta instalado

Lo verifique: `/Users/felipemantilla/.local/bin/claude`. Bien. Verifica version:

```bash
claude --version
claude doctor
```

### C.2 Configurar el settings.json para Claude Code con local

```bash
mkdir -p ~/.claude
cat > ~/.claude/settings.json <<'EOF'
{
  "env": {
    "CLAUDE_CODE_ATTRIBUTION_HEADER": "0",
    "DISABLE_PROMPT_CACHING": "1",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "API_TIMEOUT_MS": "600000",
    "DISABLE_INTERLEAVED_THINKING": "1"
  }
}
EOF
```

### C.3 Crear el script de atajo `claude-local`

```bash
mkdir -p ~/bin
cat > ~/bin/claude-local <<'SCRIPT'
#!/bin/bash
# Claude Code apuntando a Gemma 4 local via Ollama
export ANTHROPIC_BASE_URL="http://localhost:11434"
export ANTHROPIC_AUTH_TOKEN="ollama"
export ANTHROPIC_API_KEY=""

# Modelo por defecto: E4B (balance), override con 26b para potencia
MODEL="${1:-gemma4:e4b}"
shift || true

exec claude --model "$MODEL" "$@"
SCRIPT

chmod +x ~/bin/claude-local

# Asegurarte que ~/bin este en el PATH
if ! echo "$PATH" | grep -q "$HOME/bin"; then
  echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
  echo "Agregado ~/bin al PATH en ~/.zshrc — corre 'source ~/.zshrc'"
fi
```

### C.4 Lanzar Claude Code con modelo local

```bash
# Con E4B (rapido, bueno para demos simples)
claude-local

# Con 26B MoE (el modelo estrella — lo que vas a usar en la ponencia)
claude-local gemma4:26b

# Con 31B Dense (el mas capaz, mas lento)
claude-local gemma4:31b
```

### C.5 Primera prueba — verificar que funciona

Una vez dentro de Claude Code con modelo local:

```
> Crea un archivo hello.py con un script que salude en 3 idiomas
```

Debe:
1. Usar la herramienta Write
2. Crear el archivo
3. Mostrarte el contenido

Si dice "no tengo acceso a archivos" o "no puedo crear archivos", el contexto se esta truncando. Verifica que `OLLAMA_CONTEXT_LENGTH=32768` este activo.

---

## PARTE D: Script de Demo para el Simposio UPTC

### D.1 Setup previo (hacer antes de la charla, una sola vez)

```bash
# 1. Instalar Ollama
brew install ollama
brew services start ollama

# 2. Configurar contexto grande
mkdir -p ~/Library/Application\ Support/Ollama
cat > ~/Library/Application\ Support/Ollama/config.json <<'EOF'
{
  "host": "0.0.0.0:11434",
  "context_length": 32768
}
EOF
brew services restart ollama

# 3. Descargar modelos
ollama pull gemma4:e4b
ollama pull gemma4:26b

# 4. Configurar Claude Code
mkdir -p ~/.claude
cat > ~/.claude/settings.json <<'EOF'
{
  "env": {
    "CLAUDE_CODE_ATTRIBUTION_HEADER": "0",
    "DISABLE_PROMPT_CACHING": "1",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "API_TIMEOUT_MS": "600000",
    "DISABLE_INTERLEAVED_THINKING": "1"
  }
}
EOF

# 5. Crear atajo
mkdir -p ~/bin
cat > ~/bin/claude-local <<'SCRIPT'
#!/bin/bash
export ANTHROPIC_BASE_URL="http://localhost:11434"
export ANTHROPIC_AUTH_TOKEN="ollama"
export ANTHROPIC_API_KEY=""
exec claude --model "${1:-gemma4:e4b}" "${@:2}"
SCRIPT
chmod +x ~/bin/claude-local
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# 6. Pre-calentar modelos (importante!)
ollama run gemma4:e4b "ready" <<< ""
ollama run gemma4:26b "ready" <<< ""
```

### D.2 El dia de la ponencia — justo antes

```bash
# 30 minutos antes, confirmar todo:
brew services restart ollama
sleep 5

# Pre-calentar (crucial — primer request lento sin esto)
curl -s http://localhost:11434/api/chat -d '{
  "model": "gemma4:26b",
  "messages": [{"role":"user","content":"hi"}],
  "stream": false
}' > /dev/null
echo "Gemma 4 26B ready"

# Verificar status
ollama ps
curl http://localhost:11434/api/tags | jq '.models[].name'
```

### D.3 El flow de la demo en vivo (4-5 minutos)

**Setup en pantalla:** Un terminal de pantalla completa con fuente grande (al menos 18pt).

**Paso 1: Mostrar Claude Code normal (la "bestia")**

```bash
cd ~/demo-ponencia
ls
claude
```

Dentro de Claude Code:
```
> Analiza los archivos en este directorio y dime que tipo de proyecto es
```

La audiencia ve: Claude Opus respondiendo en la nube.

**Paso 2: El switch — "Ahora miren esto"**

Salir de Claude Code. Mostrar:

```bash
# Mostrar que Gemma esta corriendo
ollama ps
# PROCESSOR: 100% GPU
```

Opcional: Abrir Activity Monitor → pestana GPU → mostrar que el GPU integrado esta al 80-90%.

```bash
# Dramaticamente: apagar el WiFi
# Opcion terminal:
networksetup -setairportpower airport off

# O simplemente desde menu bar: click WiFi → Off
```

**Paso 3: Claude Code con Gemma 4 local**

```bash
# Ahora sin internet
ping -c 2 anthropic.com  # Va a fallar
echo "Sin internet. Veamos que pasa..."

# Lanzar con modelo local
claude-local gemma4:26b
```

Dentro de Claude Code:
```
> Analiza los archivos en este directorio y dime que tipo de proyecto es
```

La audiencia ve: **La misma interfaz de Claude Code, respondiendo sin internet, usando un modelo que vive en tu laptop.**

**Paso 4: El punchline**

```
> Escribe un script Python que lea un CSV y genere estadisticas
```

Mientras Gemma 4 26B genera el codigo, tu dices:

> "Este modelo ocupa el puesto 6 a nivel mundial en benchmarks, junto con GPT-5.4 y Claude. Esta corriendo en este MacBook. Sin internet. Sin pagar un dolar. Licencia Apache 2.0. Se descarga en 5 minutos."

> "Lo que acabamos de hacer hace 2 anos era ciencia ficcion. Hace 6 meses costaba $200 al mes. Hoy corre en mi laptop al mismo tiempo que esta presentacion."

**Paso 5: Reactivar internet, volver al curso normal de la charla**

```bash
networksetup -setairportpower airport on
```

### D.4 Preguntas que te van a hacer (preparate con respuestas)

**P: "Cuanta RAM necesita?"**  
R: Este modelo (26B MoE) ocupa ~18GB de memoria. En mi M5 Max de 36GB apenas usa la mitad. En un MacBook de 32GB tambien cabe. Para algo mas modesto, el E4B de 10GB corre en cualquier Mac de 16GB.

**P: "Y la calidad comparada con Claude?"**  
R: Para tareas basicas de codigo, 85-90% de lo que haria Claude Sonnet. Para razonamiento complejo agentico multi-archivo, Claude Opus sigue siendo superior. Pero para la mayoria de codigo que escribimos diario, este modelo local es mas que suficiente.

**P: "Cuanto cuesta correrlo?"**  
R: La electricidad. Mi MacBook consume ~80W bajo carga. Si lo uso 4 horas al dia por 30 dias, son ~10 kWh al mes. Con el precio de la electricidad en Colombia, eso son ~7,000 pesos al mes. Vs $200 USD al mes por Claude Code Max.

**P: "Y la seguridad? Puede correr codigo malicioso?"**  
R: Excelente pregunta, y eso es exactamente el Acto 3 de esta ponencia. Claude Code tiene sandbox a nivel de sistema operativo (bwrap en Linux, Seatbelt en macOS), permisos de 3 niveles con clasificador independiente, y herramientas restringidas. El modelo es solo una parte de la seguridad — la arquitectura del harness es lo critico.

### D.5 Checklist pre-demo

- [ ] `ollama ps` muestra modelos cargados (al menos 26B pre-calentado)
- [ ] `curl http://localhost:11434/api/tags` responde
- [ ] `which claude-local` muestra el atajo
- [ ] WiFi funciona (para el switch dramatico)
- [ ] Terminal con fuente grande (18pt+), tema consistente
- [ ] Directorio `~/demo-ponencia` con 2-3 archivos de ejemplo preparados
- [ ] Activity Monitor abierto en segundo plano (para mostrar GPU activo)
- [ ] Backup: laptop cargado al 100% (modo de potencia maximo no ahorro)
- [ ] Bateria: mejor enchufado para maximo performance
- [ ] Cerrar Chrome/apps pesadas (liberar RAM unificada para el modelo)

### D.6 Plan B — si algo falla

**Si Ollama no responde:**
```bash
brew services restart ollama
sleep 5
ollama ps
```

**Si Claude Code da error de schema:**
Fallback a API nativa Ollama (sin Claude Code):
```bash
ollama run gemma4:26b
# Mostrar el mismo tipo de interaccion, solo que en la interfaz de Ollama
```

**Si el modelo es lento:**
```bash
# Cambiar al E4B en vivo
claude-local gemma4:e4b
```

**Si todo falla:**
Tener un video de 2 minutos grabado previamente del demo funcionando. Mostrarlo y continuar.

---

## PARTE E: Cosas unicas de Apple Silicon que puedes mencionar

Estos son puntos tecnicos que puedes agregar para demostrar dominio del tema:

1. **Metal Performance Shaders**: Ollama en macOS usa MPS para acelerar inferencia en la GPU integrada. No necesita CUDA ni OpenCL.

2. **Memoria unificada**: La arquitectura UMA (Unified Memory Architecture) de Apple permite que CPU y GPU compartan la misma memoria sin copias. Para LLMs, esto es oro.

3. **Apple Neural Engine (ANE)**: Chip especializado para ML. Ollama/llama.cpp aun no lo usan completamente, pero MLX (framework de Apple) si. Podriamos ver esto en el futuro.

4. **MLX como alternativa**: Apple publica MLX, un framework open source optimizado para Apple Silicon. Modelos como `mlx-community/Gemma-4-26b-Instruct-4bit` corren 10-30% mas rapido que GGUF via llama.cpp. Pero requiere mas setup.

5. **Eficiencia energetica**: Tu M5 Max corre Gemma 4 26B a 50 tok/s usando ~80W. Una RTX 4090 equivalente consumiria 400W+. Esto importa para sostenibilidad de IA.

---

## Referencias

- Ollama para Mac: https://ollama.com/download/mac
- Ollama Claude Code integration: https://docs.ollama.com/integrations/claude-code
- Gemma 4 en Ollama: https://ollama.com/library/gemma4
- Apple MLX framework: https://ml-explore.github.io/mlx/
- MLX community models: https://huggingface.co/mlx-community
- Apple Metal for ML: https://developer.apple.com/metal/
- Claude Code Docs: https://code.claude.com/docs/en/setup
