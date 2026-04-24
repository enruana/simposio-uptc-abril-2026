# Presentación Simposio UPTC 2026

Deck HTML/CSS de la ponencia **"IA Abierta: El Poder, la Arquitectura y el Precio de No Entender lo que Generas"**.

**Ponentes:** Felipe Mantilla y Zabdiel Blanco

---

## 🎤 Modo presentador — notas del speaker en tab separado

**Este es el setup recomendado para dar la ponencia en vivo.**

Una vez que el servidor de desarrollo esté corriendo:

```bash
cd presentation
npm install          # primera vez
npm run dev          # arranca Slidev en http://localhost:3030
```

### Paso 1 — Pantalla principal (para el proyector)

La pantalla principal se abre automáticamente en `http://localhost:3030/`.
Este es el **deck visible para la audiencia**. Acá va el proyector.

### Paso 2 — Pantalla de presentador (para tu laptop / segunda pantalla)

Abrí una **nueva pestaña del navegador** y andá a:

```
http://localhost:3030/presenter/
```

Esta pantalla te muestra:

- 📺 **Slide actual** (grande)
- ⏭ **Próximo slide** (preview)
- 📝 **Notas del speaker** (todo lo que deberías decir + puntos críticos)
- ⏱ **Timer** (tiempo transcurrido)
- 🖱 **Controles** (navegación)

### Setup ideal para la ponencia en vivo

```
┌───────────────────────────┐   ┌───────────────────────────┐
│                           │   │                           │
│   Proyector / Pantalla    │   │    Tu laptop (speaker)    │
│       principal           │   │                           │
│                           │   │   ┌──────────────────┐    │
│   http://localhost:3030/  │   │   │  Slide actual    │    │
│                           │   │   ├──────────────────┤    │
│   [Slide visible para     │   │   │  Notas detalladas │    │
│    la audiencia]          │   │   │  + puntos clave   │    │
│                           │   │   │  + timer          │    │
│                           │   │   └──────────────────┘    │
│                           │   │                           │
└───────────────────────────┘   └───────────────────────────┘
```

**Cómo compartir solo el deck (no las notas) al proyector:**

- **Opción A — Mac + proyector externo:**
  1. Conectá el cable al proyector
  2. Configuración → Pantallas → "Usar como pantalla separada" (NO espejo)
  3. Arrastrá la ventana de Chrome con el deck al proyector
  4. En tu laptop, abrí otra pestaña con `/presenter/`
  5. Presentás con el presenter mode visible solo para vos

- **Opción B — Dos laptops:**
  - Un laptop con el deck proyectándose
  - Otro laptop (tuyo o del compañero) con `/presenter/` para leer notas

- **Opción C — Tablet + laptop:**
  - Laptop al proyector con el deck
  - Tablet con el presenter mode
  - Ideal si tenés un iPad o similar

---

## 📖 Contenido de las notas del speaker

Cada uno de los 33 slides tiene notas detalladas que incluyen:

- **Contexto** — qué momento de la ponencia es
- **Texto sugerido** — palabras casi literales (algunas marcadas como NO NEGOCIABLES)
- **Puntos críticos** — lo que SÍ O SÍ no puede faltar
- **Gestos escénicos** — cuándo pausar, cuándo mirar a la audiencia
- **Frases ancla** — las 6-7 frases textuales que deben decirse
- **Transiciones** — cómo pasar al siguiente slide
- **Plan B** — qué hacer si algo falla (especialmente el demo)

### Ejemplo de lo que ves en una nota:

```markdown
# SLIDE 11 · Agent Loop · 88 líneas (14-15 min)

## Texto sugerido
> "El corazón de Claude Code — el loop que hace toda la magia —
> son 88 líneas de código. Un while loop..."

## Punto clave
- "La simplicidad es la feature" — decir esta frase con énfasis

## Gesto
Señalar el código en pantalla. Leer una línea en voz alta.
```

---

## 🎨 Stack técnico

- **[Slidev](https://sli.dev)** — framework de presentaciones basado en Markdown + Vue
- **Tema oscuro custom** con paleta verde terminal (`#00ff88`) sobre negro (`#0a0a0a`)
- **Tipografía:** Instrument Serif (títulos) + Inter (body) + JetBrains Mono (código) + Caveat (hand-drawn labels)
- **SVGs estilo Excalidraw** con filtros `feTurbulence` para el look hand-drawn

---

## 🚀 Setup rápido

Requiere **Node.js 18+** y npm.

```bash
# Entrar al directorio
cd presentation

# Instalar dependencias (primera vez)
npm install

# Correr en modo desarrollo con hot reload
npm run dev
```

Abrirá automáticamente en `http://localhost:3030`.

**Primera vez puede tardar un par de minutos** descargando dependencias.

---

## ⌨️ Atajos de Slidev

### En el deck principal (`http://localhost:3030/`)

| Tecla | Acción |
|---|---|
| `Space` / `→` | Siguiente slide |
| `←` | Slide anterior |
| `O` | Overview (ver todas las slides en grid) |
| `F` | Pantalla completa |
| `P` | **Abrir presenter mode** (notas en otra ventana) |
| `G` | Ir a slide N (te deja elegir número) |
| `D` | Toggle dark mode |
| `E` | Editor embebido (editar sobre la marcha) |

### En el presenter mode (`http://localhost:3030/presenter/`)

| Tecla | Acción |
|---|---|
| `Space` / `→` | Avanzar ambas pantallas |
| `←` | Retroceder ambas pantallas |
| Click en timer | Iniciar/pausar cronómetro |

---

## 📄 Exportar a PDF / PPTX (respaldo para el día)

**Crítico:** tener PDF de respaldo por si Slidev falla el día de la ponencia.

```bash
# Export a PDF (requiere playwright-chromium, ya incluido)
npm run export-pdf

# Export a PPTX si lo necesitás para PowerPoint
npm run export-pptx
```

El archivo `slides-export.pdf` aparece en el directorio `presentation/`.

Si es la primera vez y playwright no está instalado:
```bash
npx playwright install chromium
```

---

## 📁 Estructura del proyecto

```
presentation/
├── README.md                # Este archivo — instrucciones completas
├── package.json             # Dependencias y scripts
├── slides.md                # EL DECK COMPLETO — 33 slides con notas
├── style.css                # Estilos globales (se cargan automático)
├── styles/
│   └── theme.css            # Backup del tema (legacy, usar style.css)
├── components/              # Componentes Vue custom (para extender)
└── public/
    └── diagrams/            # SVGs estilo Excalidraw
        ├── hero-portrait.svg
        ├── brain-vs-body.svg
        └── enemy-map.svg
```

---

## 🎨 Paleta de diseño

| Variable | Hex | Uso |
|---|---|---|
| `--bg-primary` | `#0a0a0a` | Fondo principal |
| `--bg-card` | `#141414` | Tarjetas |
| `--text-primary` | `#f5f5f5` | Títulos |
| `--text-body` | `#d4d4d4` | Cuerpo |
| `--accent` | `#00ff88` | Verde terminal — datos killer |
| `--danger` | `#ff3b5f` | Enemigos del Acto 3 |

### Tipografía

- **Títulos:** Instrument Serif (elegante, contrasta con lo técnico)
- **Body:** Inter
- **Código/datos:** JetBrains Mono + Space Grotesk
- **Hand-drawn labels:** Caveat (para los SVG Excalidraw-style)

---

## 🔧 Personalización

### Cambiar colores

Editá `style.css` (raíz del proyecto). Las variables CSS están al inicio.
Hot reload automático.

### Cambiar contenido de un slide

Editá `slides.md`. Cada slide empieza con `---`. Las notas del speaker
están dentro de `<!-- ... -->` después del contenido del slide.

### Cambiar las notas del speaker

Todas las notas están en bloques `<!-- -->` dentro de `slides.md`.
Cada slide tiene su bloque. Editalos directamente.

### Agregar diagramas Excalidraw reales

Si querés reemplazar los SVG hand-made por Excalidraw reales:

1. Ir a [excalidraw.com](https://excalidraw.com)
2. Dibujar el diagrama
3. Export → SVG (con opción "embed scene")
4. Guardar en `public/diagrams/`
5. Referenciar en `slides.md` con `<img src="/diagrams/nombre.svg" />`

### Generar el QR del cierre

El slide 31 tiene un placeholder `[QR CODE]`. Para generar el QR real:

1. Ir a [qr-code-generator.com](https://www.qr-code-generator.com/) o similar
2. URL: `https://github.com/enruana/simposio-uptc-abril-2026`
3. Descargar como SVG o PNG
4. Guardar en `public/qr-repo.svg`
5. En `slides.md`, reemplazar el bloque `[QR CODE]` con:
   ```html
   <img src="/qr-repo.svg" style="width: 240px; height: 240px;" />
   ```

---

## ✅ Checklist pre-ponencia (día de)

### Hardware
- [ ] MacBook al 100% cargado, con cargador enchufado
- [ ] Adaptador video funcional para el proyector
- [ ] Cable ethernet listo (si se va a mostrar gesto WiFi off físico)
- [ ] Segunda pantalla o tablet para presenter mode

### Software
- [ ] `npm run dev` corriendo sin errores
- [ ] Ambas pestañas abiertas: `/` y `/presenter/`
- [ ] Todos los SVGs renderean correctamente
- [ ] QR real generado y en su lugar
- [ ] `slides-export.pdf` guardado como respaldo
- [ ] Probado con el proyector que se va a usar

### Ollama + Claude Code (para el demo del slide 18)
- [ ] `ollama ps` muestra `gemma4:26b` cargado
- [ ] `curl http://localhost:11434/api/tags` responde
- [ ] Pre-calentamiento ejecutado (primer query no tarda en frío)
- [ ] Directorio `~/demo-ponencia-uptc` limpio
- [ ] WiFi desconectable rápidamente (saber dónde hacer click)
- [ ] Video backup del demo grabado por si falla

### Personales
- [ ] Ensayo completo cronometrado al menos 2 veces
- [ ] Botella de agua en el escenario
- [ ] Celular en silencio (pero accesible si se necesita alguna referencia)
- [ ] 10 minutos de respiración antes de entrar

---

## 🎬 Workflow típico del día

1. **2 horas antes:** setup técnico — proyector, laptop, presenter mode
2. **1 hora antes:** precalentamiento del modelo Ollama (prompts de prueba)
3. **30 minutos antes:** última revisión del deck, checklist final
4. **10 minutos antes:** respiración, agua, no revisar nada nuevo
5. **0 minutos:** subir al escenario, apagar WiFi visible, empezar el gesto

---

## 🐛 Problemas comunes

**"slidev: command not found"**
→ Correr `npm install` primero. Luego usar `npm run dev` (usa el binario local).

**Las fuentes no cargan / se ven distintas**
→ Slidev depende de Google Fonts. Si hay problemas de red, las fuentes fallback
son system UI. Probar con conexión estable.

**El presenter mode no abre / se ve feo**
→ Verificar que el puerto 3030 esté libre. Si no, cambiar puerto:
`PORT=3031 npm run dev`

**Los SVG se ven muy pequeños o muy grandes**
→ Ajustar `style="max-width: X%"` en el `<img>` correspondiente en `slides.md`.

**El export PDF falla**
→ Instalar playwright chromium:
```bash
npx playwright install chromium
```

**El hot reload no funciona**
→ Cerrar y volver a correr `npm run dev`. A veces se desincroniza el watcher.

**Animación del logo respirando no se ve**
→ Verificar que `style.css` se esté cargando. Debería estar en la raíz
del directorio `presentation/`. Slidev lo carga automáticamente.

---

## 📚 Recursos adicionales

- **Guion completo:** `../docs/guion-ponencia.md` — texto literal de la ponencia
- **Fundamentos técnicos:** `../docs/fundamentos-completos.md`
- **Guía del demo:** `../docs/guia-practica-mac-m5max.md`
- **Workflow de preparación:** `../WORKFLOW.md`

---

## 👥 Créditos

- Framework: [Slidev](https://sli.dev) por [Anthony Fu](https://antfu.me)
- Tema oscuro custom: Felipe Mantilla
- Ilustraciones Excalidraw-style: inspiradas en [Excalidraw](https://excalidraw.com)
- Fuentes: Google Fonts (Instrument Serif, Inter, JetBrains Mono, Caveat, Space Grotesk)
