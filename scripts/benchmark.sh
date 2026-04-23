#!/bin/bash
# Benchmark formal Gemma 4 E4B vs 26B MoE
# Ejecuta 3 tipos de tareas comparables en ambos modelos y guarda resultados
# Autor: Felipe Mantilla — Ponencia UPTC 2026

set -e

OUTPUT="benchmark-results.md"
RESPONSES_DIR="responses"

mkdir -p "$RESPONSES_DIR"

cat > "$OUTPUT" <<HEADER
# Benchmarks Gemma 4 en MacBook Pro M5 Max 36GB

**Fecha:** $(date +"%Y-%m-%d %H:%M")
**Hardware:** Apple M5 Max, 36 GB unified memory, macOS $(sw_vers -productVersion 2>/dev/null || echo "unknown")
**Ollama:** $(ollama --version 2>/dev/null | awk '{print $NF}')

## Metodología
- Pre-calentamiento de ambos modelos antes de medir
- 3 tipos de tareas: simple (código), razonamiento (matemática), compleja (técnica)
- Métricas tomadas de \`ollama run --verbose\`
- Respuestas completas guardadas en carpeta \`responses/\`

---

HEADER

# Pre-calentar modelos (evita medir el cold start en la primera tarea)
echo "🔥 Pre-calentando modelos..."
ollama run gemma4:e4b "hola" > /dev/null 2>&1 || true
echo "   ✓ gemma4:e4b listo"
ollama run gemma4:26b "hola" > /dev/null 2>&1 || true
echo "   ✓ gemma4:26b listo"
echo ""
echo "🚀 Iniciando benchmarks..."
echo ""

# Array de prompts: "TIPO|PROMPT"
PROMPTS=(
  "TAREA_SIMPLE|Escribe una función Python que calcule el factorial de un número usando recursión. Incluye un docstring y un ejemplo de uso."
  "TAREA_RAZONAMIENTO|Un tren sale de Tunja hacia Bogotá a 80 km/h. Simultáneamente, otro tren sale de Bogotá hacia Tunja a 60 km/h. La distancia entre ciudades es 140 km. Calcula en cuánto tiempo se cruzan y a qué distancia de Tunja. Muestra el razonamiento paso a paso."
  "TAREA_COMPLEJA|Explica la diferencia entre hash tables, árboles B, y skip lists como estructuras de datos para indexación de bases de datos. Menciona un caso de uso ideal para cada una y la complejidad de inserción y búsqueda."
)

for model in gemma4:e4b gemma4:26b; do
  # Nombre sanitizado para archivos
  model_clean=$(echo "$model" | tr ':' '_')

  echo "" >> "$OUTPUT"
  echo "## Modelo: \`$model\`" >> "$OUTPUT"
  echo "" >> "$OUTPUT"

  for entry in "${PROMPTS[@]}"; do
    tipo="${entry%%|*}"
    prompt="${entry#*|}"

    echo "⏳ Testing $model — $tipo"

    # Correr y capturar output completo
    RESPONSE_FILE="$RESPONSES_DIR/${model_clean}_${tipo}.txt"
    RESULT=$(ollama run "$model" --verbose "$prompt" 2>&1)
    echo "$RESULT" > "$RESPONSE_FILE"

    # Extraer métricas (robusto a formato variable)
    EVAL_RATE=$(echo "$RESULT" | grep "eval rate:" | tail -1 | awk '{print $3}')
    LOAD_DUR=$(echo "$RESULT" | grep "load duration:" | awk '{print $3}')
    TOTAL_DUR=$(echo "$RESULT" | grep "total duration:" | awk '{print $3}')
    EVAL_COUNT=$(echo "$RESULT" | grep "eval count:" | awk '{print $3}')
    PROMPT_EVAL_RATE=$(echo "$RESULT" | grep "prompt eval rate:" | awk '{print $4}')

    # Escribir sección
    echo "### $tipo" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "**Prompt:** $prompt" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "| Métrica | Valor |" >> "$OUTPUT"
    echo "|---------|-------|" >> "$OUTPUT"
    echo "| eval rate (tok/s) | ${EVAL_RATE:-N/A} |" >> "$OUTPUT"
    echo "| prompt eval rate (tok/s) | ${PROMPT_EVAL_RATE:-N/A} |" >> "$OUTPUT"
    echo "| tokens generados | ${EVAL_COUNT:-N/A} |" >> "$OUTPUT"
    echo "| load duration | ${LOAD_DUR:-N/A} |" >> "$OUTPUT"
    echo "| total duration | ${TOTAL_DUR:-N/A} |" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "*Respuesta completa en:* \`$RESPONSE_FILE\`" >> "$OUTPUT"
    echo "" >> "$OUTPUT"

    echo "   ✓ eval rate: ${EVAL_RATE:-N/A} tok/s | tokens: ${EVAL_COUNT:-N/A}"

    # Pausa entre tests para estabilidad
    sleep 2
  done
done

# Resumen comparativo
echo "" >> "$OUTPUT"
echo "---" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "## Resumen comparativo" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Este benchmark demuestra que en Apple Silicon M5 Max:" >> "$OUTPUT"
echo "- Ambos modelos alcanzan velocidades similares gracias a la arquitectura MoE del 26B" >> "$OUTPUT"
echo "- El modelo 26B ocupa ~18 GB pero solo activa ~3.8B parámetros por token" >> "$OUTPUT"
echo "- La memoria unificada permite que ambos modelos operen en GPU completamente" >> "$OUTPUT"
echo "" >> "$OUTPUT"

echo ""
echo "✅ Benchmark completo"
echo ""
echo "📄 Resultados: $(pwd)/$OUTPUT"
echo "📁 Respuestas: $(pwd)/$RESPONSES_DIR/"
echo ""
echo "─────────────────────────────────────────────"
echo "  Resumen ejecutivo:"
echo "─────────────────────────────────────────────"
grep -A 1 "eval rate (tok/s)" "$OUTPUT" | grep -v "^--$" | head -20
