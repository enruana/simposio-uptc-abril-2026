# Guia Practica: Ejecutar Modelos de IA Localmente

**Hardware de referencia:** AMD Ryzen 7 5700X (8 cores/16 threads), NVIDIA RTX 3060 12GB VRAM, 16GB RAM, Ubuntu 24.04, 367GB disco libre  
**Fecha de investigacion:** Abril 2026

---

## 1. Que modelos puede ejecutar este hardware?

### Regla general de VRAM

El calculo base es: `parametros (en miles de millones) x bytes por parametro`.
- FP16 = 2 bytes por parametro (7B = 14GB)
- Q8_0 = 1 byte por parametro (7B = 7GB)
- Q4_K_M = ~0.5 bytes por parametro (7B = ~4.5GB)

Con 12GB de VRAM, el limite practico es: **modelos de hasta ~14B en Q4, o hasta ~8B en Q8**. A esto hay que sumarle 1-2GB de overhead para KV cache y contexto.

### Tabla completa de compatibilidad

| Modelo | Parametros | Cuantizacion | VRAM necesaria | RAM necesaria | Tokens/seg (estimado) | Funciona? |
|--------|-----------|-------------|----------------|---------------|----------------------|-----------|
| **Gemma 4 E2B** | 2B | Q4_K_M | ~1 GB | 4 GB | 25-30 t/s | SI - sobrado |
| **Gemma 4 E2B** | 2B | FP16 | ~4 GB | 6 GB | 18-22 t/s | SI - sobrado |
| **Gemma 4 E4B** | 4B (efectivos) | Q4_K_M | ~2.5 GB | 6 GB | 18-22 t/s | SI - recomendado |
| **Gemma 4 E4B** | 4B (efectivos) | FP16 | ~8 GB | 8 GB | 12-15 t/s | SI - bien |
| **Gemma 4 26B-A4B** | 26B total / 4B activos (MoE) | Q4_K_M | ~13-15 GB | 20 GB | - | NO - excede 12GB VRAM |
| **Gemma 4 31B** | 31B (denso) | Q4_K_M | ~20 GB | 24 GB | - | NO - excede por mucho |
| **DeepSeek R1 Distill 7B** (Qwen) | 7B | Q4_K_M | ~4.5 GB | 8 GB | 40-55 t/s | SI - rapido |
| **DeepSeek R1 Distill 8B** (Llama) | 8B | Q4_K_M | ~5 GB | 8 GB | 35-50 t/s | SI - rapido |
| **DeepSeek R1 Distill 14B** (Qwen) | 14B | Q4_K_M | ~9 GB | 12 GB | 22-31 t/s | SI - ajustado |
| **DeepSeek R1 Distill 32B** | 32B | Q4_K_M | ~18 GB | 24 GB | - | NO - excede VRAM |
| **DeepSeek V3/R1 671B** | 671B | cualquier | 350+ GB | 400+ GB | - | NO - imposible |
| **Llama 4 Scout** | 109B total / 17B activos (MoE) | INT4 | ~55 GB | 64 GB | - | NO - necesita H100 |
| **Llama 4 Maverick** | 400B total / 17B activos (MoE) | INT4 | ~200 GB | 256 GB | - | NO - datacenter |
| **Qwen 3 8B** | 8B | Q4_K_M | ~5 GB | 8 GB | 42-55 t/s | SI - excelente |
| **Qwen 3 14B** | 14B | Q4_K_M | ~8-9 GB | 12 GB | 22-31 t/s | SI - bueno |
| **Qwen 3 32B** | 32B | Q4_K_M | ~16 GB | 24 GB | - | NO - excede VRAM |
| **Qwen 3.5 9B** | 9B | Q4_K_M | ~5.5 GB | 8 GB | 35-45 t/s | SI |
| **Qwen 3.5 27B** | 27B | Q4_K_M | ~14 GB | 20 GB | - | NO - excede VRAM |
| **Phi-4** | 14B | Q4_K_M | ~7 GB | 10 GB | 25-35 t/s | SI - bien |
| **Phi-4** | 14B | Q8_0 | ~14 GB | 16 GB | - | NO - limite exacto, inestable |
| **Phi-4 Mini** | 3.8B | Q4_K_M | ~2.5 GB | 6 GB | 40-50 t/s | SI - rapido |
| **Mistral 7B** | 7B | Q4_K_M | ~4.5 GB | 8 GB | 45-60 t/s | SI - muy rapido |

### Benchmarks reales en RTX 3060 12GB (via hardware-corner.net)

| Modelo | Cuantizacion | Contexto | Procesamiento prompt | Generacion |
|--------|-------------|----------|---------------------|------------|
| Qwen3 8B | Q4_K | 4K | 1,696 t/s | 55.2 t/s |
| Qwen3 8B | Q4_K | 16K | 1,119 t/s | 42.0 t/s |
| Qwen3 8B | Q4_K | 32K | 764 t/s | 31.9 t/s |
| Qwen3 14B | Q4_K | 4K | 972 t/s | 31.2 t/s |
| Qwen3 14B | Q4_K | 16K | 678 t/s | 22.7 t/s |

**Nota:** La RTX 3060 12GB tiene 360 GB/s de ancho de banda de memoria, lo que le da ventaja incluso sobre la RTX 4060 en generacion de tokens pese a ser hardware mas antiguo.

### Los mejores modelos para tu hardware (recomendaciones)

1. **Para demo rapida y multimodal:** `gemma4:e4b` -- soporta texto, vision y audio, 128K contexto
2. **Para razonamiento (cadena de pensamiento):** `deepseek-r1:8b` -- razonamiento paso a paso visible
3. **Para uso general de alta calidad:** `qwen3:14b` -- mejor balance calidad/velocidad para 12GB
4. **Para velocidad maxima:** `qwen3:8b` o `mistral:7b` -- 45-55 t/s fluido
5. **Para codigo:** `phi4:14b` -- especializado en codigo y razonamiento

---

## 2. Ollama: Guia completa de configuracion

### 2.1 Pre-requisito: Drivers NVIDIA

```bash
# Verificar si ya tienes drivers NVIDIA
nvidia-smi

# Si no tienes drivers, instalar:
sudo apt update
sudo apt install -y nvidia-driver-560
sudo reboot

# Despues del reinicio, verificar:
nvidia-smi
# Debes ver tu RTX 3060 con 12GB listada
```

Si `ubuntu-drivers` falla o instala una version incorrecta:

```bash
# Metodo alternativo via PPA (mas consistente en Ubuntu 24.04)
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo ubuntu-drivers autoinstall
sudo reboot
```

### 2.2 Instalar Ollama

```bash
# Instalacion con un solo comando
curl -fsSL https://ollama.com/install.sh | sh

# Verificar que esta corriendo
ollama --version

# Verificar que detecta la GPU
ollama run --verbose gemma4:e4b 2>&1 | head -5
# Debe mostrar "using CUDA" o similar
```

Ollama se instala como un servicio systemd que arranca automaticamente:

```bash
# Verificar servicio
systemctl status ollama

# Ver logs
journalctl -u ollama -f

# Reiniciar si hay problemas
sudo systemctl restart ollama
```

### 2.3 Descargar y ejecutar modelos

```bash
# Descargar un modelo (se guarda en ~/.ollama/models/)
ollama pull gemma4:e4b          # ~3 GB descarga
ollama pull qwen3:8b             # ~5 GB descarga
ollama pull qwen3:14b            # ~9 GB descarga
ollama pull deepseek-r1:8b       # ~5 GB descarga
ollama pull phi4                 # ~9 GB descarga (14B Q4)

# Ejecutar interactivamente
ollama run gemma4:e4b

# Ejecutar con un prompt directo
ollama run qwen3:8b "Explica que es un compilador en 3 oraciones"

# Ver modelos descargados
ollama list

# Eliminar un modelo
ollama rm nombre-del-modelo

# Ver informacion detallada de un modelo
ollama show qwen3:8b
```

### 2.4 API REST de Ollama

Ollama expone una API REST en `http://localhost:11434` automaticamente.

**Generar texto (endpoint /api/generate):**

```bash
curl http://localhost:11434/api/generate -d '{
  "model": "qwen3:8b",
  "prompt": "Que es la recursion en programacion?",
  "stream": false
}'
```

**Chat con historial (endpoint /api/chat):**

```bash
curl http://localhost:11434/api/chat -d '{
  "model": "gemma4:e4b",
  "messages": [
    {"role": "system", "content": "Eres un profesor de ingenieria de sistemas."},
    {"role": "user", "content": "Explica MCP (Model Context Protocol) de forma simple."}
  ],
  "stream": false
}'
```

**Listar modelos disponibles:**

```bash
curl http://localhost:11434/api/tags
```

**Compatibilidad con OpenAI API:**

Ollama es compatible con el formato de la API de OpenAI, lo que permite usarlo como reemplazo directo:

```bash
curl http://localhost:11434/v1/chat/completions -d '{
  "model": "qwen3:8b",
  "messages": [{"role": "user", "content": "Hola, que puedes hacer?"}]
}'
```

Esto permite usar librerias como `openai` de Python apuntando a `http://localhost:11434/v1`.

### 2.5 Configuracion avanzada de GPU

```bash
# Verificar que Ollama esta usando GPU durante inferencia
# En otra terminal mientras ejecutas un prompt:
watch -n 1 nvidia-smi

# Forzar uso de GPU especifica (si tienes varias)
CUDA_VISIBLE_DEVICES=0 ollama serve

# Variables de entorno utiles (editar /etc/systemd/system/ollama.service)
# OLLAMA_NUM_PARALLEL=2     # Peticiones en paralelo
# OLLAMA_MAX_LOADED_MODELS=1 # Modelos en memoria simultaneamente
# OLLAMA_FLASH_ATTENTION=1   # Activar Flash Attention (mas rapido)
```

Para modificar la configuracion del servicio:

```bash
sudo systemctl edit ollama
# Agregar en la seccion [Service]:
# Environment="OLLAMA_FLASH_ATTENTION=1"
# Environment="OLLAMA_NUM_PARALLEL=2"

sudo systemctl daemon-reload
sudo systemctl restart ollama
```

### 2.6 Problemas conocidos y soluciones

| Problema | Solucion |
|----------|----------|
| GPU no detectada despues de suspender/reanudar | `sudo rmmod nvidia_uvm && sudo modprobe nvidia_uvm` |
| "no nvidia devices detected by library" | `sudo nvidia-modprobe -u` y reiniciar ollama |
| Modelo corre en CPU en vez de GPU | Verificar `nvidia-smi`. Si funciona, reiniciar: `sudo systemctl restart ollama` |
| Actualizacion de driver rompe deteccion | Probar version anterior del driver; configurar `OLLAMA_LLM_LIBRARY` para bypass manual |
| Conflicto con driver Nouveau | `sudo apt purge xserver-xorg-video-nouveau` y reiniciar |
| Modelo demasiado grande, se cuelga | Usar un modelo mas pequeno o mayor cuantizacion (Q4 en vez de Q8) |
| Error "out of memory" con contexto largo | Reducir contexto: `ollama run modelo --num-ctx 4096` |

**Herramienta de monitoreo recomendada:**

```bash
# Instalar nvtop para monitoreo visual de GPU
sudo apt install nvtop
nvtop
```

---

## 3. llama.cpp: Cuando y por que usarlo

### 3.1 Relacion con Ollama

Ollama usa llama.cpp como motor de inferencia internamente. Piensa en llama.cpp como el motor y Ollama como el auto que lo hace accesible. Usar llama.cpp directamente te da:

- **15-30% mas rendimiento** con configuracion manual optimizada
- **Ventanas de contexto mas grandes** (32K+ vs ~11K por defecto en Ollama)
- **Control total** sobre parametros de inferencia, muestreo, lotes
- **Soporte para hardware exotico** (ARM, Raspberry Pi, Android)

**Cuando usar llama.cpp en vez de Ollama:**
- Necesitas maximizar tokens/segundo para una demo
- Quieres contextos muy largos (32K-128K tokens)
- Necesitas controlar parametros de muestreo especificos
- Quieres compilar con optimizaciones especificas para tu CPU/GPU
- Investigacion o experimentacion avanzada

**Cuando quedarte con Ollama:**
- Prototipado rapido y demostraciones
- Necesitas la API REST para integrar con aplicaciones
- Quieres descargar modelos con un solo comando
- No quieres compilar nada

### 3.2 Formato GGUF

GGUF (GPT-Generated Unified Format) es el formato estandar de llama.cpp para modelos cuantizados. Reemplazo al antiguo GGML. Ventajas:

- Archivo unico autocontenido (modelo + tokenizador + metadatos)
- Soporta multiples niveles de cuantizacion
- Compatible con CPU y GPU (CUDA, Metal, Vulkan)
- Todos los modelos en Ollama son GGUF internamente

### 3.3 Niveles de cuantizacion explicados

| Cuantizacion | Bits | Tamano (7B) | Tamano (14B) | Perdida calidad | Uso recomendado |
|-------------|------|-------------|-------------|-----------------|-----------------|
| **FP16** | 16 | 14 GB | 28 GB | Ninguna (referencia) | Solo si tienes VRAM de sobra |
| **Q8_0** | 8 | 7.5 GB | 15 GB | Minima (~indistinguible de FP16) | Calidad maxima con cuantizacion |
| **Q6_K** | 6 | 5.5 GB | 11 GB | Muy baja | Cuando puedes pagar un poco mas de VRAM |
| **Q5_K_M** | 5 | 5.3 GB | 10 GB | Baja (+0.06 perplejidad) | **Sweet spot calidad/eficiencia** |
| **Q4_K_M** | 4 | 4.5 GB | 9 GB | Moderada (+0.18 perplejidad) | **Recomendado para la mayoria** |
| **Q4_K_S** | 4 | 4.3 GB | 8.5 GB | Moderada-alta | Si necesitas ahorrar cada MB |
| **Q3_K_M** | 3 | 3.5 GB | 7 GB | Notable | Solo si no cabe en Q4 |
| **Q2_K** | 2 | 2.5 GB | 5 GB | Alta | Ultimo recurso, calidad degradada |
| **IQ4_XS** | ~4 | 4.2 GB | 8.4 GB | Baja (mejor que Q4_K_M) | Alternativa moderna a Q4 |

**Que significan los sufijos:**
- **Q** = Quantized (cuantizado), el numero es los bits
- **K** = K-quant, usa estructura jerarquica de super-bloques (256 valores) con escalas por sub-bloque. Mucho mejor que cuantizacion uniforme antigua
- **S/M/L** = Small/Medium/Large -- cuantos tensores se mantienen a mayor precision. M es el balance recomendado
- **IQ** = Importance-weighted Quantization -- usa datos estadisticos de prompts reales para minimizar perdida

**Recomendacion para tu RTX 3060 12GB:**
- Modelos 7-8B: usa **Q5_K_M** o **Q8_0** (te sobra VRAM)
- Modelos 14B: usa **Q4_K_M** (el unico que cabe comodo)
- Modelos 3-4B: usa **Q8_0** o incluso **FP16** (son tan pequenos que no importa)

### 3.4 Compilar y usar llama.cpp con CUDA

```bash
# Instalar dependencias
sudo apt install -y build-essential cmake git

# Clonar repositorio
git clone https://github.com/ggml-org/llama.cpp.git
cd llama.cpp

# Compilar con soporte CUDA (RTX 3060 = compute capability 8.6)
cmake -B build -DGGML_CUDA=ON -DCMAKE_CUDA_ARCHITECTURES=86
cmake --build build --config Release -j$(nproc)

# Descargar un modelo GGUF (ejemplo: Qwen3 8B Q4_K_M de Unsloth)
# Puedes descargar desde Hugging Face:
# https://huggingface.co/unsloth/Qwen3-8B-GGUF

# Ejecutar inferencia
./build/bin/llama-cli \
  -m ~/models/qwen3-8b-q4_k_m.gguf \
  -p "Explica el patron Observer en programacion orientada a objetos" \
  -n 512 \
  -ngl 99 \
  --temp 0.7

# -ngl 99 = enviar TODAS las capas a la GPU (crucial para rendimiento)
# -n 512 = generar hasta 512 tokens
# --temp 0.7 = temperatura de muestreo

# Servidor API compatible con OpenAI
./build/bin/llama-server \
  -m ~/models/qwen3-8b-q4_k_m.gguf \
  -ngl 99 \
  -c 8192 \
  --host 0.0.0.0 \
  --port 8080
```

---

## 4. vLLM: Para uso en produccion/servidor

### 4.1 Cuando usar vLLM vs Ollama

| Caracteristica | Ollama | vLLM |
|----------------|--------|------|
| Facilidad de instalacion | Excelente (1 comando) | Moderada (pip/docker) |
| Rendimiento con 1 usuario | Bueno | Bueno |
| Rendimiento con N usuarios | Limitado | Excelente (PagedAttention, batching continuo) |
| Compatibilidad API OpenAI | Si | Si (nativa) |
| Cuantizacion GGUF | Si (nativa) | Parcial (AWQ, GPTQ) |
| Hardware minimo | 4GB VRAM | 12GB+ VRAM recomendado |
| Caso de uso | Desarrollo, demos, uso personal | APIs multi-usuario, produccion |

**Usa vLLM cuando:** necesitas servir un modelo a multiples usuarios concurrentes con baja latencia, o cuando necesitas throughput alto y batching automatico.

**Usa Ollama cuando:** necesitas simplicidad, demos, desarrollo, o uso personal.

### 4.2 Estado actual con RTX 3060

**Advertencia importante:** vLLM tiene problemas conocidos con GPUs Ampere de 12GB (incluyendo RTX 3060). El issue #27934 del repositorio oficial documenta crashes de memoria con modelos 7B-13B por bugs en el calculo de KV cache del motor V1.

**Si aun quieres intentarlo:**

```bash
# Instalar via pip
pip install vllm

# Ejecutar con limites de memoria ajustados
python -m vllm.entrypoints.openai.api_server \
  --model Qwen/Qwen2.5-7B-Instruct \
  --max-model-len 4096 \
  --gpu-memory-utilization 0.85 \
  --dtype half \
  --port 8000

# O via Docker (mas estable)
docker run --gpus all \
  -p 8000:8000 \
  vllm/vllm-openai:latest \
  --model Qwen/Qwen2.5-7B-Instruct \
  --max-model-len 4096 \
  --gpu-memory-utilization 0.85
```

**Workarounds para RTX 3060:**
- Limitar `--max-model-len` a 4096 o menos
- Usar `--gpu-memory-utilization 0.80` para dejar headroom
- Preferir modelos AWQ/GPTQ cuantizados sobre FP16
- Si hay crashes, probar `--enforce-eager` para desactivar CUDA graphs

**Veredicto para tu hardware:** Para un RTX 3060 12GB con un solo usuario, Ollama es la mejor opcion. vLLM brilla en hardware con 24GB+ de VRAM.

---

## 5. Comparacion de costos: Local vs API

### 5.1 Costo de ejecutar localmente

**Consumo electrico de tu sistema bajo carga de inferencia:**
- RTX 3060 TDP: 170W (pico real durante inferencia: ~150-200W)
- CPU + resto del sistema: ~80-100W
- Total sistema bajo carga: ~250-300W
- En idle (modelo cargado pero sin generar): ~100W

**Calculo mensual (uso moderado: 4 horas/dia de inferencia activa):**
- 300W x 4h x 30 dias = 36 kWh/mes
- Costo en Colombia (~$700 COP/kWh = ~$0.16 USD/kWh): **~$5.75 USD/mes**
- Costo en USA (~$0.15 USD/kWh): **~$5.40 USD/mes**
- Costo en Europa (~$0.30 USD/kWh): **~$10.80 USD/mes**

**Inversion unica del hardware:**
Tu hardware ya lo tienes, pero como referencia el costo de construir un sistema similar hoy:
- RTX 3060 12GB: ~$250-300 USD (usada) / ~$350 USD (nueva)
- Ryzen 7 5700X + mobo + 16GB RAM: ~$250 USD
- Total estimado: ~$500-600 USD

### 5.2 Precios de APIs (abril 2026)

| Proveedor | Modelo | Input / M tokens | Output / M tokens | Notas |
|-----------|--------|------------------|--------------------|-------|
| **Anthropic** | Claude Opus 4.6 | $5.00 | $25.00 | Maximo rendimiento |
| **Anthropic** | Claude Sonnet 4.6 | $3.00 | $15.00 | Balance calidad/costo |
| **Anthropic** | Claude Haiku 4.5 | $1.00 | $5.00 | Rapido y economico |
| **OpenAI** | GPT-5.4 | $2.50 | $10.00 | Modelo flagship |
| **OpenAI** | GPT-5 Mini | $0.25 | $2.00 | Economico |
| **OpenAI** | GPT-5 Nano | $0.05 | $0.40 | Ultra-economico |
| **DeepSeek** | V3.2 | $0.28 | $0.42 | El mas barato con calidad |
| **Google** | Gemini 2.5 Flash | $0.30 | $2.50 | Rapido y barato |
| **Google** | Gemini 2.5 Pro | $1.25 | $10.00 | Alta calidad |

### 5.3 En que punto conviene ejecutar localmente?

**Escenario: uso personal/desarrollo (1M tokens/dia = ~750 paginas de texto)**

| Metodo | Costo mensual |
|--------|--------------|
| Local (tu hardware, electricidad) | ~$6 USD |
| DeepSeek API (1M tokens/dia) | ~$21 USD |
| Claude Haiku API (1M tokens/dia) | ~$180 USD |
| Claude Sonnet API (1M tokens/dia) | ~$540 USD |
| GPT-5.4 API (1M tokens/dia) | ~$375 USD |

**Break-even vs DeepSeek API:**
- Si ya tienes el hardware: local es mas barato desde el dia 1
- Si necesitas comprar hardware (~$600): break-even en ~3-4 meses vs DeepSeek, ~1 mes vs Claude Sonnet

**Escenario: equipo de 5 desarrolladores (5M tokens/dia)**
- Local: ~$10 USD/mes (electricidad)
- DeepSeek API: ~$105 USD/mes
- Claude Sonnet: ~$2,700 USD/mes
- Break-even del hardware: ~1-2 meses vs cualquier API premium

**Conclusion:** Si usas modelos de IA diariamente y puedes aceptar un modelo local de 7-14B en vez de Claude Opus o GPT-5, local es enormemente mas barato. El hardware se paga solo rapidamente.

**Pero:** Los modelos locales que puedes correr (7-14B) son significativamente menos capaces que Claude Opus 4.6 o GPT-5.4. No es una comparacion directa de calidad, solo de costo.

---

## 6. Lo que NO puedes hacer localmente con este hardware

### Modelos que no caben

| Modelo | Por que no | Que necesitarias |
|--------|-----------|-----------------|
| Gemma 4 26B-A4B | Necesita ~15GB VRAM en Q4 | RTX 4090 (24GB) |
| Gemma 4 31B | Necesita ~20GB en Q4 | 2x RTX 3090 o RTX 4090 |
| DeepSeek R1 32B distill | Necesita ~18GB en Q4 | RTX 4090 (24GB) |
| DeepSeek V3/R1 671B | Necesita 350+ GB | Cluster de 8x H100 |
| Llama 4 Scout | Necesita ~55GB en INT4 | 1x H100 80GB |
| Llama 4 Maverick | Necesita ~200GB en INT4 | 4x H100 80GB |
| Qwen 3 72B | Necesita ~36GB en Q4 | 2x RTX 4090 |
| Qwen 3.5 397B | Necesita ~200GB en FP8 | 8x H100 |

### Limitaciones cualitativas

- **Razonamiento complejo de multiples pasos:** Los modelos de 7-14B son notablemente inferiores a Claude Opus/GPT-5 en tareas que requieren razonamiento profundo, planificacion, o comprension de contextos muy largos.
- **Generacion de codigo largo y complejo:** Un modelo local de 14B puede generar funciones individuales bien, pero no puede arquitectar sistemas completos como lo hacen los modelos frontier.
- **Tareas multilingues avanzadas:** Los modelos pequenos tienen menos capacidad en idiomas distintos al ingles.
- **Contexto largo real:** Aunque algunos modelos anuncian 128K tokens de contexto, en 12GB de VRAM el contexto practico es 4K-16K tokens antes de que la memoria se agote.
- **Generacion de imagenes:** Este setup no puede ejecutar modelos de generacion de imagenes como Stable Diffusion XL de forma comoda (necesita ~10GB solo para el modelo, sin dejar espacio para LLMs).
- **Fine-tuning:** Con 12GB de VRAM y 16GB de RAM, el fine-tuning esta muy limitado. QLoRA en modelos de 7B es posible pero ajustado.

### Lo que SI debes seguir usando con APIs en la nube

- Claude Opus / GPT-5 para tareas complejas de razonamiento, analisis de documentos largos, y generacion de codigo complejo
- Modelos de generacion de imagenes (DALL-E, Midjourney)
- Transcripcion de audio (Whisper API es mas practico que local para volumen alto)
- Embeddings de alta dimension para RAG en produccion

---

## 7. Setup listo para demo en vivo

### Opcion A: Demo minima (5 minutos de setup)

```bash
# Paso 1: Verificar GPU
nvidia-smi

# Paso 2: Instalar Ollama (si no esta instalado)
curl -fsSL https://ollama.com/install.sh | sh

# Paso 3: Descargar y ejecutar Gemma 4 E4B (modelo multimodal de Google)
ollama run gemma4:e4b
# Esperar descarga (~3 GB), luego escribir preguntas directamente

# Ejemplo de prompts para la demo:
# "Explica que es el Model Context Protocol en 3 oraciones"
# "Escribe una funcion en Python que implemente un servidor MCP basico"
# "Que ventajas tiene ejecutar modelos de IA localmente?"
```

### Opcion B: Demo con multiples modelos (15 minutos de setup)

```bash
# Pre-descargar modelos (hacer ANTES de la presentacion)
ollama pull gemma4:e4b           # Google Gemma 4 - multimodal
ollama pull deepseek-r1:8b       # DeepSeek R1 - razonamiento
ollama pull qwen3:8b             # Qwen 3 - uso general

# Durante la demo, alternar entre modelos:
ollama run gemma4:e4b "Que ves en esta imagen?" 
# (nota: para imagenes necesitas usar la API, no CLI)

ollama run deepseek-r1:8b "Resuelve paso a paso: si tengo 3 servidores con 99.9% uptime cada uno, cual es el uptime total del sistema?"
# DeepSeek R1 mostrara su cadena de razonamiento con etiquetas <think>

ollama run qwen3:8b "Escribe un endpoint REST en FastAPI que reciba texto y devuelva un resumen"
```

### Opcion C: Demo con interfaz web (20 minutos de setup)

```bash
# Paso 1: Asegurar que Ollama esta corriendo
sudo systemctl start ollama

# Paso 2: Instalar Open WebUI via Docker
docker run -d \
  --name open-webui \
  -p 3000:8080 \
  -v open-webui:/app/backend/data \
  --add-host=host.docker.internal:host-gateway \
  -e OLLAMA_BASE_URL=http://host.docker.internal:11434 \
  --restart always \
  ghcr.io/open-webui/open-webui:main

# Paso 3: Abrir en navegador
# http://localhost:3000
# Crear cuenta local (primera vez)
# Seleccionar modelo (gemma4:e4b, deepseek-r1:8b, etc.)
# Interfaz tipo ChatGPT ejecutandose 100% local
```

### Opcion D: Demo via API (para mostrar integracion programatica)

```python
# archivo: demo_local_ai.py
# pip install openai

from openai import OpenAI

# Apuntar a Ollama local (compatible con API de OpenAI)
client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama"  # Ollama no requiere API key real
)

# Ejemplo 1: Chat simple
response = client.chat.completions.create(
    model="qwen3:8b",
    messages=[
        {"role": "system", "content": "Eres un asistente tecnico experto."},
        {"role": "user", "content": "Que es MCP y por que importa para el futuro del software?"}
    ],
    temperature=0.7
)
print(response.choices[0].message.content)

# Ejemplo 2: Comparar modelos
modelos = ["gemma4:e4b", "deepseek-r1:8b", "qwen3:8b"]
pregunta = "Explica la diferencia entre compilador e interprete"

for modelo in modelos:
    print(f"\n{'='*50}")
    print(f"Modelo: {modelo}")
    print(f"{'='*50}")
    resp = client.chat.completions.create(
        model=modelo,
        messages=[{"role": "user", "content": pregunta}],
        temperature=0.7
    )
    print(resp.choices[0].message.content[:500])
```

### Checklist pre-demo

```bash
# Ejecutar todo esto ANTES de la presentacion:

# 1. Verificar GPU
nvidia-smi

# 2. Verificar Ollama
ollama --version
systemctl status ollama

# 3. Verificar modelos descargados
ollama list

# 4. Hacer un "warm up" de cada modelo (carga en GPU)
ollama run gemma4:e4b "test" && echo "OK"
ollama run deepseek-r1:8b "test" && echo "OK"
ollama run qwen3:8b "test" && echo "OK"

# 5. Monitoreo en terminal separada
nvtop  # o: watch -n 1 nvidia-smi

# 6. Verificar espacio en disco
df -h /home
```

### Tips para la demo en vivo

1. **Pre-descarga todo.** Las descargas de modelos son de 3-9 GB y no deben hacerse en vivo.
2. **Haz warm-up.** La primera ejecucion de un modelo tarda 5-10 segundos en cargar a GPU. Las siguientes son instantaneas.
3. **Usa prompts cortos.** Para la demo, preguntas de 1-2 oraciones generan respuestas rapidas y visualmente impactantes.
4. **Muestra nvidia-smi.** Ver la GPU al 98% de uso mientras genera texto es muy visual.
5. **Compara modelos.** Hacer la misma pregunta a 2-3 modelos diferentes muestra la diversidad del ecosistema.
6. **Muestra la velocidad.** Los 40-55 tokens/segundo de un modelo 8B son visualmente rapidos, casi como leer texto normal.
7. **DeepSeek R1 es el mas impresionante para demos** porque muestra su proceso de razonamiento paso a paso dentro de etiquetas `<think>`.
8. **Prepara un plan B.** Si la GPU falla, Ollama automaticamente usa CPU (mas lento pero funcional). Tener un modelo pequeno como gemma4:e2b garantiza que siempre habra algo que mostrar.

---

## Fuentes

- [Gemma 4 Hardware Requirements (avenchat.com)](https://avenchat.com/blog/gemma-4-hardware-requirements)
- [Gemma 4 VRAM Requirements - Every GPU Tested (gemma4guide.com)](https://gemma4guide.com/guides/gemma4-vram-requirements)
- [Gemma 4 12GB VRAM Recommendations (bswen.com)](https://docs.bswen.com/blog/2026-04-03-gemma-4-12gb-vram-recommendations/)
- [Which Gemma 4 Model Should I Use? (gemma4-ai.com)](https://gemma4-ai.com/blog/gemma4-which-model)
- [Unsloth Gemma 4 - How to Run Locally](https://unsloth.ai/docs/models/gemma-4)
- [GPU Requirements Cheat Sheet 2026 (Spheron)](https://www.spheron.network/blog/gpu-requirements-cheat-sheet-2026/)
- [RTX 3060 12GB LLM Benchmarks (hardware-corner.net)](https://www.hardware-corner.net/gpu-llm-benchmarks/rtx-3060-12gb/)
- [GPU System Requirements for DeepSeek-R1 (apxml.com)](https://apxml.com/posts/gpu-requirements-deepseek-r1)
- [DeepSeek R1 Local Setup Guide 2026 (compute-market.com)](https://www.compute-market.com/blog/deepseek-r1-local-setup-guide-2026)
- [Llama 4 GPU System Requirements (apxml.com)](https://apxml.com/posts/llama-4-system-requirements)
- [Llama 4 Hardware Requirements 2026 (compute-market.com)](https://www.compute-market.com/blog/llama-4-local-hardware-guide-2026)
- [LLM API Pricing 2026 (tldl.io)](https://www.tldl.io/resources/llm-api-pricing-2026)
- [DeepSeek API Pricing 2026 (tldl.io)](https://www.tldl.io/resources/deepseek-api-pricing)
- [Ollama GPU Support Docs](https://docs.ollama.com/gpu)
- [Ollama Troubleshooting Docs](https://docs.ollama.com/troubleshooting)
- [Ollama API Documentation](https://docs.ollama.com/api/introduction)
- [Install Ollama and OpenWebUI on Ubuntu 24.04 with RTX 3060 (bittenbypython.com)](https://www.bittenbypython.com/en/posts/install_ollama_openwebui_ubuntu_nvidia/)
- [Ollama Ubuntu NVIDIA Driver Pitfalls Guide (itecsonline.com)](https://itecsonline.com/post/ollama-ubuntu-nvidia)
- [GGUF Quantization Explained (willitrunai.com)](https://willitrunai.com/blog/quantization-guide-gguf-explained)
- [Quantization Methods Discussion (llama.cpp GitHub #2094)](https://github.com/ggml-org/llama.cpp/discussions/2094)
- [Unified Evaluation of llama.cpp Quantization (arxiv.org)](https://arxiv.org/html/2601.14277v1)
- [llama.cpp vs Ollama vs vLLM Comparison (decodesfuture.com)](https://www.decodesfuture.com/articles/llama-cpp-vs-ollama-vs-vllm-local-llm-stack-guide)
- [Ollama vs llama.cpp vs vLLM (aimadetools.com)](https://www.aimadetools.com/blog/ollama-vs-llama-cpp-vs-vllm/)
- [vLLM RTX 3060 Memory Issues (GitHub #27934)](https://github.com/vllm-project/vllm/issues/27934)
- [Local LLM vs Cloud API Cost Analysis 2026 (sitepoint.com)](https://www.sitepoint.com/local-llms-vs-cloud-api-cost-analysis-2026/)
- [Running Local LLMs in Expensive Energy Markets (xda-developers.com)](https://www.xda-developers.com/run-local-llms-one-worlds-priciest-energy-markets/)
