# 🎬 Demo Output — Artefactos Generados en Vivo

Esta carpeta guarda **archivos que Gemma 4 generó en tiempo real** durante las pruebas del demo del Acto 2. Son piezas de evidencia, no plantillas ni código operativo.

## ¿Por qué guardarlos?

Forman parte del valor pedagógico de la ponencia: muestran lo que un modelo de pesos abiertos, cuantizado a 4 bits y corriendo en una laptop sin internet, puede producir cuando se lo invoca a través de un agente harness (Claude Code → Ollama).

Funcionan también como **plan B**: si el demo en vivo falla, podemos abrir estos archivos y narrar lo que el modelo ya construyó previamente.

## Inventario

| Archivo | Modelo | Cómo se generó | Notas |
|---------|--------|----------------|-------|
| [`feedback_form.html`](feedback_form.html) | `gemma4:26b` (Q4_K_M, 17 GB) | Claude Code apuntando a Ollama local, con prompt pidiendo formulario de feedback dark-mode con accent cyan | Gemma improvisó un estilo **retro terminal** (fuente VT323, cyan + magenta neón, copy "SYSTEM ONLINE") en vez del minimalismo que se pidió. Hallazgo interesante: los modelos abiertos siguen el espíritu del prompt, no la letra |

## Notas técnicas del momento de captura

- **Hardware:** MacBook Pro M5 Max, 36 GB unified memory, macOS 26.4
- **Velocidad medida:** ~85 tok/s eval rate (idéntica entre E4B y 26B MoE)
- **Modo Claude Code:** Ollama (ver `scripts/claude-mode.sh ollama`)
- **Context length:** 32K (`OLLAMA_CONTEXT_LENGTH=32768`)
- **Thinking mode:** activo por default — observación: requirió prompts imperativos ("usá Write YA") para destrabar el loop de planificación y ejecutar la herramienta

## Cómo abrir

```bash
# macOS
open feedback_form.html

# O servirlo localmente
python3 -m http.server 8000  # luego abrir http://localhost:8000/feedback_form.html
```

## Referencias cruzadas

- Guion del demo: [`docs/03-guion-ponencia.md`](../../../docs/03-guion-ponencia.md)
- Historial completo de las pruebas: [`docs/99-historial-desarrollo.md`](../../../docs/99-historial-desarrollo.md)
- Cómo reproducir: [`docs/guias/claude-code-gemma.md`](../../../docs/guias/claude-code-gemma.md)
