# Simposio UPTC Abril 2026 — Ponencia sobre IA Abierta

Materiales de investigación, fundamentos técnicos y scripts para la ponencia del **Simposio UPTC 2026**.

## Título de la ponencia

**"IA Abierta: El Poder, la Arquitectura y el Precio de No Entender lo que Generas"**

## Tesis central

La IA dejó de ser un servicio exclusivo: hoy cualquier estudiante puede ejecutar modelos competitivos en su laptop y usar agentes autónomos que escriben, editan y ejecutan código. Este poder es inédito, pero introduce riesgos que la mayoría de desarrolladores desconoce.

La ponencia articula tres actos conectados:

1. **Cómo funcionan los agentes de IA por dentro** — Usando como caso de estudio la filtración accidental del código fuente de Claude Code (31 de marzo de 2026, 512,000 líneas expuestas vía source map en npm).
2. **La democratización real: modelos abiertos en hardware local** — Demostración en vivo corriendo Gemma 4 26B MoE localmente con Ollama y Claude Code apuntando al modelo local.
3. **El precio de no entender lo que generas** — Evidencia científica (METR 2025, Veracode 2025) sobre productividad, vulnerabilidades y responsabilidad profesional.

## Audiencia

Profesores y estudiantes de últimos semestres de Ingeniería de Sistemas — Universidad Pedagógica y Tecnológica de Colombia (UPTC).

## Estructura del repositorio

```
.
├── propuesta-ponencia.md         # Propuesta ejecutiva para los organizadores
├── ideas-ponencia.md             # Reporte completo de investigación (3 actos)
├── docs/
│   ├── fundamentos-completos.md  # Estudio profundo de cada tema
│   ├── deep-dive-agent-architecture.md
│   ├── guia-modelos-locales.md   # Guía práctica para correr modelos locales
│   ├── guia-practica-claude-code-gemma.md
│   └── guia-practica-mac-m5max.md  # Guía específica MacBook M5 Max
└── scripts/
    └── benchmark.sh              # Benchmark Gemma 4 E4B vs 26B MoE
```

## Demo técnica

El demo en vivo ejecuta Claude Code apuntando a Gemma 4 26B MoE corriendo localmente:

- **Hardware de referencia:** MacBook Pro M5 Max, 36 GB memoria unificada
- **Modelo:** Gemma 4 26B MoE (Apache 2.0), ranking #6 global en Arena AI
- **Stack:** Claude Code → Ollama (endpoint Anthropic-compatible) → Gemma 4
- **Sin conexión a internet** — todo local

Comando clave:
```bash
export ANTHROPIC_BASE_URL="http://localhost:11434"
export ANTHROPIC_AUTH_TOKEN="ollama"
claude --model gemma4:26b
```

## Referencias principales

- Filtración de Claude Code: [The Register](https://www.theregister.com/2026/03/31/anthropic_claude_code_source_code/) · [VentureBeat](https://venturebeat.com/technology/claude-codes-source-code-appears-to-have-leaked-heres-what-we-know)
- Estudio METR sobre productividad con IA: [metr.org](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/)
- Veracode 2025 GenAI Code Security Report
- Gemma 4 (Google DeepMind): [deepmind.google/models/gemma/gemma-4](https://deepmind.google/models/gemma/gemma-4/)
- Claude Code Router: [github.com/musistudio/claude-code-router](https://github.com/musistudio/claude-code-router)

## Autor

Felipe Mantilla · Abril 2026

---

*Todo el material es de acceso libre. Usalo, modifícalo, critícalo. Ese es el punto.*
