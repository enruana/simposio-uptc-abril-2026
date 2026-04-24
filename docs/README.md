# 📚 Documentación

Documentación completa del proyecto de la ponencia **"IA Abierta — Simposio UPTC 2026"**.

Los archivos están numerados para que los leas en orden si es tu primera vez, pero cada uno es autocontenido.

---

## 📖 Lectura recomendada por rol

### Si sos organizador de un evento similar
Empezá por [**01-propuesta.md**](01-propuesta.md) — propuesta ejecutiva lista para enviar a tu comité.

### Si sos ponente adaptando esta charla
1. [**02-investigacion-completa.md**](02-investigacion-completa.md) — todo el contexto y fuentes
2. [**03-guion-ponencia.md**](03-guion-ponencia.md) — guion minuto a minuto de 45 minutos
3. [**06-definicion-alto-nivel.md**](06-definicion-alto-nivel.md) — por qué tomamos cada decisión narrativa

### Si sos estudiante y querés entender el contenido técnico
1. [**04-fundamentos-tecnicos.md**](04-fundamentos-tecnicos.md) — explicaciones didácticas
2. [**05-arquitectura-agentes.md**](05-arquitectura-agentes.md) — deep-dive de Claude Code
3. [**guias/**](guias/) — cómo hacer las cosas en tu máquina

### Si querés replicar el demo
Directo a [**guias/claude-code-gemma.md**](guias/claude-code-gemma.md).

---

## 📑 Índice completo

### 🎯 Estrategia y narrativa

| # | Archivo | Qué encontrás | Longitud |
|---|---------|---------------|:--------:|
| 01 | [**Propuesta**](01-propuesta.md) | Descripción ejecutiva de la ponencia para organizadores | ~1 pág |
| 02 | [**Investigación completa**](02-investigacion-completa.md) | Reporte exhaustivo con todas las fuentes, datos, referencias | ~40 págs |
| 03 | [**Guion**](03-guion-ponencia.md) | Transcripción literal de los 45 minutos · para dos ponentes | ~30 págs |
| 06 | [**Definición alto nivel**](06-definicion-alto-nivel.md) | Visión del proyecto · decisiones clave · tesis central | ~10 págs |

### 🧠 Contenido técnico

| # | Archivo | Qué encontrás |
|---|---------|---------------|
| 04 | [**Fundamentos técnicos**](04-fundamentos-tecnicos.md) | Todo lo que el ponente necesita dominar: cuantización, harness, MoE, agent loop, tool calling, AI slop, estudio METR, etc. |
| 05 | [**Arquitectura agentes**](05-arquitectura-agentes.md) | Deep-dive de cómo funciona Claude Code (basado en la filtración de marzo 2026): agent loop, 7 capas, sistema de permisos, classifier independiente |

### 🛠️ Guías prácticas

| Archivo | Para qué |
|---------|----------|
| [**Modelos locales**](guias/modelos-locales.md) | Cómo correr Gemma 4, DeepSeek R1, Qwen 3.5 en tu hardware |
| [**Claude Code + Gemma**](guias/claude-code-gemma.md) | El truco del demo: conectar Claude Code con un modelo local vía Ollama |
| [**Mac M5 Max**](guias/mac-m5max.md) | Setup específico para MacBook Pro con Apple Silicon |

### 📊 Historial del desarrollo

| Archivo | Qué es |
|---------|--------|
| [**99-historial-desarrollo.md**](99-historial-desarrollo.md) | Workflow completo del desarrollo: decisiones, iteraciones, tareas completadas/pendientes. Útil si vas a adaptar el material. |

---

## 🗂️ Flujo recomendado de lectura

```
┌─────────────────────┐
│ 01-propuesta.md     │  (empezar acá si sos organizador)
└──────────┬──────────┘
           │
           ↓
┌─────────────────────┐
│ 06-definicion       │  ¿Por qué esta ponencia? ¿Qué tesis defiende?
│ -alto-nivel.md      │
└──────────┬──────────┘
           │
           ↓
┌─────────────────────┐
│ 02-investigacion    │  ← si querés las fuentes y el contexto completo
│ -completa.md        │
└──────────┬──────────┘
           │
           ↓
┌─────────────────────┐
│ 04-fundamentos      │  ← si vas a dar la ponencia (dominar el material)
│ -tecnicos.md        │
└──────────┬──────────┘
           │
           ↓
┌─────────────────────┐
│ 03-guion-ponencia   │  ← el guion literal para ensayar
│ .md                 │
└──────────┬──────────┘
           │
           ↓
┌─────────────────────┐
│ guias/              │  ← cómo hacer el demo técnico en vivo
│ claude-code-gemma   │
└─────────────────────┘
```

---

## 🔗 Relación con el resto del repo

```
docs/                          ← acá estás
├── 01-propuesta.md
├── ...
│
presentation/                  ← la presentación en sí
├── index.html                 ← doble-click para abrir
└── slides.md                  ← fuente de Slidev alternativa
│
scripts/                       ← herramientas operativas
├── benchmark.sh
└── claude-local
```

Para **correr la presentación**, andá a [`../presentation/`](../presentation/) → doble-click en `index.html`.
