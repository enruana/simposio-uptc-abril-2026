#!/bin/bash
# claude-mode.sh — Alterna settings.json de Claude Code entre Ollama (local) y Anthropic (cloud)
#
# Uso:
#   ./claude-mode.sh ollama      # activa flags para Gemma 4 local via Ollama
#   ./claude-mode.sh anthropic   # remueve flags (modo API normal)
#   ./claude-mode.sh status      # muestra modo actual
#
# Preserva cualquier otra configuración en settings.json. Hace backup automático.
# Autor: Felipe Mantilla — Ponencia UPTC 2026

set -euo pipefail

SETTINGS="$HOME/.claude/settings.json"
BACKUP="$HOME/.claude/settings.json.bak"

# Las 5 flags que se activan en modo Ollama
OLLAMA_KEYS=(
  "CLAUDE_CODE_ATTRIBUTION_HEADER"
  "DISABLE_PROMPT_CACHING"
  "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC"
  "API_TIMEOUT_MS"
  "DISABLE_INTERLEAVED_THINKING"
)

OLLAMA_ENV='{
  "CLAUDE_CODE_ATTRIBUTION_HEADER": "0",
  "DISABLE_PROMPT_CACHING": "1",
  "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
  "API_TIMEOUT_MS": "600000",
  "DISABLE_INTERLEAVED_THINKING": "1"
}'

usage() {
  cat <<EOF
Uso: $(basename "$0") [ollama|anthropic|status]

  ollama     Activa flags para usar Gemma 4 local via Ollama
             - CLAUDE_CODE_ATTRIBUTION_HEADER=0   (preservar KV cache)
             - DISABLE_PROMPT_CACHING=1            (Ollama no soporta cache_control)
             - CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1  (100% local)
             - API_TIMEOUT_MS=600000               (10 min para tareas largas)
             - DISABLE_INTERLEAVED_THINKING=1      (Gemma no tiene thinking blocks)

  anthropic  Remueve esas flags (vuelve a modo API Anthropic normal)

  status     Muestra modo actual y flags activos

Archivo: $SETTINGS
Backup:  $BACKUP (automático antes de cada cambio)
EOF
  exit 1
}

# Prerequisitos
[ -f "$SETTINGS" ] || { echo "✗ Error: $SETTINGS no existe" >&2; exit 1; }
command -v jq >/dev/null || { echo "✗ Error: jq no está instalado — ejecutá: brew install jq" >&2; exit 1; }

MODE="${1:-}"

# Construir filtro jq para borrar las keys de Ollama
DEL_FILTER=""
for key in "${OLLAMA_KEYS[@]}"; do
  DEL_FILTER="${DEL_FILTER}.${key}, "
done
DEL_FILTER="${DEL_FILTER%, }"

case "$MODE" in
  ollama)
    cp "$SETTINGS" "$BACKUP"
    # Merge: preserva .env existente, agrega/sobreescribe las 5 keys de Ollama
    jq --argjson ollama_env "$OLLAMA_ENV" '
      .env = (.env // {}) + $ollama_env
    ' "$SETTINGS" > "$SETTINGS.tmp"
    mv "$SETTINGS.tmp" "$SETTINGS"
    echo "✓ Modo OLLAMA activado"
    echo "  Backup: $BACKUP"
    echo ""
    echo "Flags activos en settings.json:"
    jq -r '.env | to_entries[] | "  \(.key)=\(.value)"' "$SETTINGS"
    ;;

  anthropic)
    cp "$SETTINGS" "$BACKUP"
    # Surgical: borrar solo las 5 keys de Ollama, preservar cualquier otra
    # Si .env queda vacío después, eliminar .env por completo
    jq "
      if .env then
        .env |= del($DEL_FILTER)
        | if (.env | length) == 0 then del(.env) else . end
      else . end
    " "$SETTINGS" > "$SETTINGS.tmp"
    mv "$SETTINGS.tmp" "$SETTINGS"
    echo "✓ Modo ANTHROPIC activado"
    echo "  Backup: $BACKUP"
    echo "  Flags de Ollama removidas"
    if jq -e '.env' "$SETTINGS" >/dev/null 2>&1; then
      echo ""
      echo "Otras env vars preservadas:"
      jq -r '.env | to_entries[] | "  \(.key)=\(.value)"' "$SETTINGS"
    fi
    ;;

  status)
    # Contar cuántas flags de Ollama están activas
    active=0
    for key in "${OLLAMA_KEYS[@]}"; do
      if jq -e ".env.${key}" "$SETTINGS" >/dev/null 2>&1; then
        active=$((active + 1))
      fi
    done
    total=${#OLLAMA_KEYS[@]}

    if [ "$active" -eq "$total" ]; then
      echo "Modo actual: OLLAMA (todas las $total flags activas)"
    elif [ "$active" -eq 0 ]; then
      echo "Modo actual: ANTHROPIC (ninguna flag de Ollama activa)"
    else
      echo "Modo actual: MIXTO ($active/$total flags de Ollama activas)"
      echo "  Usá './$(basename "$0") ollama' o './$(basename "$0") anthropic' para normalizar"
    fi
    echo ""
    if jq -e '.env' "$SETTINGS" >/dev/null 2>&1; then
      echo "Contenido de .env en settings.json:"
      jq -r '.env | to_entries[] | "  \(.key)=\(.value)"' "$SETTINGS"
    else
      echo "Bloque .env no existe en settings.json"
    fi
    ;;

  *)
    usage
    ;;
esac
