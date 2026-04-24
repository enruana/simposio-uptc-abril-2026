# 🎤 IA Abierta — Simposio UPTC 2026

> **El Poder, la Arquitectura y el Precio de No Entender lo que Generas**

Materiales completos de una ponencia de 45 minutos presentada en el **Simposio de Ingeniería de Sistemas** de la **Universidad Pedagógica y Tecnológica de Colombia (UPTC)** en abril de 2026.

**Ponentes:** Felipe Mantilla · Zabdiel Blanco

---

![License: MIT](https://img.shields.io/badge/License-MIT-00ff88?style=flat-square)
![Made with ❤️ in Colombia](https://img.shields.io/badge/Made_with_❤️_in-Colombia-FFCD00?style=flat-square)
![Status: Complete](https://img.shields.io/badge/Status-Complete-00cc6f?style=flat-square)
![Topics](https://img.shields.io/badge/Topics-AI_·_Open_Source_·_Claude_Code_·_Gemma-333?style=flat-square)

---

## 📖 Sobre la ponencia

La IA dejó de ser un servicio exclusivo: cualquier estudiante puede ejecutar modelos competitivos en su laptop y usar agentes autónomos que escriben, editan y ejecutan código. Este poder es **inédito**, pero introduce riesgos que la mayoría de desarrolladores desconoce.

La ponencia articula **tres actos conectados** usando la estructura narrativa del **Hero's Journey**, donde el héroe es el estudiante en la audiencia:

| Acto | Tema | Minutos |
|:----:|:-----|:-------:|
| **I** | **La filtración de Claude Code** — Arquitectura real de un agente de IA de clase mundial (512,000 líneas de código expuestas en npm el 31 de marzo de 2026) | 0 – 18 |
| **II** | **IA en tu laptop** — Demo en vivo: Gemma 4 corriendo localmente con Ollama + Claude Code, sin internet, gratis, apache 2.0 | 18 – 28 |
| **III** | **El precio de no entender** — Estudio METR 2025 (-19% productividad con IA), slopsquatting, prompt injection, y el framework de responsabilidad profesional | 28 – 45 |

### 💡 Tesis central

> **"Ya no necesitamos ser solo buenos programadores. Necesitamos ser problem solvers, critical thinkers.
> Pensar más, programar menos."**

---

## 🚀 Cómo ver la presentación

### Opción 1 — La más rápida (recomendada para la ponencia)

**Doble-click en `presentation/index.html`**. Se abre en tu navegador. Sin servidor, sin dependencias, sin internet necesario.

```bash
# macOS / Linux
open presentation/index.html

# O simplemente doble-click desde el finder/explorador
```

**Para el modo presentador con notas del speaker en ventana separada:**
- Apretá tecla `P` dentro del deck (o click en **📺 Notas**)
- Se abre una ventana nueva con las notas detalladas
- Arrastrá la ventana principal al proyector; dejá la de notas en tu laptop

### Opción 2 — Desarrollo con hot reload (Slidev)

```bash
cd presentation
npm install
npm run dev     # abre http://localhost:3030
npm run export-pdf   # genera PDF de respaldo
```

Ver [`presentation/README.md`](presentation/README.md) para detalles completos.

---

## 📂 Estructura del repositorio

```
.
├── 📄 README.md                        ← estás aquí
├── 📄 LICENSE                          (MIT)
├── 📄 CONTRIBUTING.md                  Cómo contribuir
│
├── 📂 presentation/                    La presentación (HTML + CSS + JS)
│   ├── index.html                      Deck principal (abrir con doble-click)
│   ├── presenter.html                  Modo presentador con notas
│   ├── slides.md                       Fuente alternativa para Slidev
│   ├── style.css                       Tema oscuro custom
│   ├── package.json                    Dependencias Slidev (opcional)
│   ├── README.md                       Guía completa de uso
│   └── public/
│       ├── diagrams/                   SVGs estilo Excalidraw
│       ├── images/                     Imágenes del deck
│       ├── logos/                      Logos (UPTC, Claude, Gemma, Ollama)
│       ├── screenshots/                Capturas (tweet de la filtración, etc.)
│       └── qr-repo.svg                 QR al repositorio
│
├── 📂 docs/                            Documentación técnica y de investigación
│   ├── 01-propuesta.md                 Propuesta ejecutiva para los organizadores
│   ├── 02-investigacion-completa.md    Reporte completo de investigación
│   ├── 03-guion-ponencia.md            Guion literal de 45 minutos
│   ├── 04-fundamentos-tecnicos.md      Estudio profundo de cada tema técnico
│   ├── 05-arquitectura-agentes.md      Deep-dive de la arquitectura Claude Code
│   ├── 06-definicion-alto-nivel.md     Visión y decisiones clave del proyecto
│   ├── 99-historial-desarrollo.md      Workflow y log de preparación
│   └── guias/
│       ├── modelos-locales.md          Guía técnica: correr modelos locales
│       ├── claude-code-gemma.md        Integrar Claude Code + Gemma 4
│       └── mac-m5max.md                Setup específico para MacBook M5 Max
│
└── 📂 scripts/                         Scripts operativos
    ├── benchmark.sh                    Benchmark Gemma E4B vs 26B
    ├── claude-local                    Lanzar Claude Code con Gemma local
    └── claude-mode.sh                  Toggle settings.json Ollama/Anthropic
```

---

## 🎯 ¿Qué vas a encontrar acá?

### Para organizadores de eventos similares
- 📋 [**Propuesta ejecutiva**](docs/01-propuesta.md) lista para copiar/adaptar
- 🎬 [**Guion de 45 minutos**](docs/03-guion-ponencia.md) listo para dos ponentes
- 🎨 [**Presentación en HTML**](presentation/) lista para proyectar

### Para ingenieros curiosos
- 🏗️ [**Arquitectura completa de Claude Code**](docs/05-arquitectura-agentes.md) (basada en la filtración de marzo 2026)
- 🦙 [**Cómo correr Gemma 4 localmente**](docs/guias/modelos-locales.md) con Ollama
- 🔧 [**Integración Claude Code + Gemma local**](docs/guias/claude-code-gemma.md) — el truco del demo
- 📊 [**Scripts de benchmark**](scripts/benchmark.sh) reproducibles

### Para estudiantes
- 📖 [**Fundamentos técnicos completos**](docs/04-fundamentos-tecnicos.md) (cuantización, harness, agentes, AI slop)
- 🎓 Contexto sobre **MCP, DeepSeek, Ollama, Claude Code**, y por qué 2026 cambia todo
- 🚨 Evidencia del **estudio METR 2025** sobre productividad real con IA

---

## 🛠️ Tecnologías referenciadas

| Herramienta | Descripción | Link |
|------------|-------------|------|
| **Claude Code** | Agente de código de Anthropic · filtrado 31/03/2026 | [claude.ai/code](https://claude.ai/code) |
| **Gemma 4** | Modelos abiertos de Google (Apache 2.0) | [Google DeepMind](https://deepmind.google/models/gemma/gemma-4/) |
| **Ollama** | Runtime para correr modelos localmente | [ollama.com](https://ollama.com) |
| **Claw-Code** | Reimplementación Python de Claude Code (150K+ ⭐) | [github.com/instructkr/claw-code](https://github.com/instructkr/claw-code) |
| **Slidev** | Framework de presentaciones Markdown + Vue | [sli.dev](https://sli.dev) |

---

## 📊 Datos y estudios citados

- **METR 2025** — *Measuring the Impact of AI on Software Engineering Productivity* ([paper](https://arxiv.org/abs/2507.09089))
- **Veracode 2025** — *GenAI Code Security Report* (2.74x más vulnerabilidades en código generado por IA)
- **GitHub Octoverse 2025** — *State of the Open Source Maintainer*
- **Caso Postmark MCP** — septiembre 2025, primer incidente documentado de prompt injection en producción
- **Caso huggingface-cli** — paquete alucinado con 30,000+ descargas (slopsquatting)
- **Filtración Claude Code** — 31 de marzo de 2026 ([tweet original](https://x.com/Fried_rice/status/...))

---

## 🤝 Contribuciones

Este es un repositorio educativo público. Si encuentras errores, tienes sugerencias, o querés adaptar el material para otra universidad o evento — **¡adelante!**. Lee [CONTRIBUTING.md](CONTRIBUTING.md).

El repo está diseñado para ser **forkeable**: cambiás los ponentes, la universidad, algunos datos específicos, y tienes una ponencia lista.

---

## 📜 Licencia

[MIT License](LICENSE) — Usalo, modificalo, compartilo libremente. Solo pedimos que mantengas el crédito original.

---

## ✨ Créditos

**Ponentes:**
- [@enruana](https://github.com/enruana) — Felipe Mantilla (egresado UPTC)
- Zabdiel Blanco

**Inspiración y referencias:**
- La comunidad open source global que hizo posible Gemma, Ollama, Claw-Code
- Anthropic — por la filtración accidental que se convirtió en regalo pedagógico
- Sigrid Jin — por demostrar en 2 horas lo que una sola persona puede construir
- Todos los estudiantes de la UPTC que aún se preguntan si su esfuerzo vale la pena
  (tu trabajo vale **más** ahora, no menos)

---

<p align="center">
  <strong>Porque nunca fue programar.</strong><br>
  <em>Fue pensar.</em>
</p>

<p align="center">
  <sub>🦙 Generado con amor · Abril 2026 · Tunja, Colombia</sub>
</p>
