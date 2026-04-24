# Presentación Simposio UPTC 2026

Deck HTML/CSS de la ponencia **"IA Abierta: El Poder, la Arquitectura y el Precio de No Entender lo que Generas"**.

**Ponentes:** Felipe Mantilla y Zabdiel Blanco

---

## Stack técnico

- **[Slidev](https://sli.dev)** — framework de presentaciones basado en Markdown + Vue
- **HTML + CSS + Vue** para componentes custom
- **SVG con estilo Excalidraw** (filtros `feTurbulence` para el look hand-drawn)
- **Tema oscuro custom** con paleta verde terminal

---

## Correr la presentación (modo desarrollo)

Requiere Node.js 18+ y npm.

```bash
# Entrar al directorio
cd presentation

# Instalar dependencias (primera vez)
npm install

# Correr en modo desarrollo con hot reload
npm run dev
```

Abrirá automáticamente en `http://localhost:3030`.

### Controles de Slidev

- `Space` / `→` → siguiente slide
- `←` → slide anterior
- `O` → overview (ver todas las slides)
- `D` → modo oscuro (ya está en oscuro, pero toggleable)
- `F` → pantalla completa
- `P` → modo presentador (abre segunda ventana con notas)
- `E` → editor embebido (editar en vivo)
- `G` → ir a slide N

---

## Exportar a PDF (respaldo para el día)

**Crítico:** tener PDF de respaldo por si Slidev falla el día de la ponencia.

```bash
# Opción 1: export directo (requiere playwright)
npm run export-pdf
# Genera slides-export.pdf en el directorio actual

# Opción 2: export a PPTX si lo necesitás
npm run export-pptx
```

---

## Estructura

```
presentation/
├── README.md                 # Este archivo
├── package.json              # Dependencias y scripts
├── slides.md                 # EL DECK COMPLETO — 30+ slides
├── styles/
│   └── theme.css             # Tema custom oscuro + tipografía + componentes
├── components/               # Componentes Vue custom (para extender)
├── public/
│   └── diagrams/             # SVGs estilo Excalidraw
│       ├── hero-portrait.svg
│       ├── brain-vs-body.svg
│       └── enemy-map.svg
└── snippets/                 # Fragmentos reutilizables (futuro)
```

---

## Paleta de diseño

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

## Personalización

### Cambiar colores

Editá `styles/theme.css`. Las variables CSS están al inicio del archivo.

### Cambiar contenido de un slide

Editá `slides.md`. Cada slide empieza con `---`. Hot reload automático.

### Agregar diagramas Excalidraw reales

Si querés reemplazar los SVG hand-made por Excalidraw reales:

1. Ir a [excalidraw.com](https://excalidraw.com)
2. Dibujar el diagrama
3. Export → SVG (con opción "embed scene")
4. Guardar en `presentation/public/diagrams/`
5. Referenciar en `slides.md` con `<img src="/diagrams/nombre.svg" />`

### Cambiar el QR del cierre

El slide del QR tiene un placeholder. Para generar el QR real:

1. Ir a [qr-code-generator.com](https://www.qr-code-generator.com/) o similar
2. URL: `https://github.com/enruana/simposio-uptc-abril-2026`
3. Descargar como SVG
4. Guardar en `public/qr-repo.svg`
5. En `slides.md`, reemplazar `[QR CODE]` con `<img src="/qr-repo.svg" />`

---

## Checklist pre-ponencia

- [ ] `npm install` ejecutado sin errores
- [ ] `npm run dev` corre correctamente
- [ ] Todos los slides renderean
- [ ] Diagramas SVG se ven bien
- [ ] QR real generado y en su lugar
- [ ] PDF exportado como respaldo (`npm run export-pdf`)
- [ ] Probado en el proyector/pantalla que se usará
- [ ] Modo presentador probado con notas de `<!-- -->` visibles
- [ ] Fuentes cargadas correctamente (verificar en slide 1)
- [ ] Animación del logo respirando funciona en el slide final

---

## Flujo de trabajo con el guion

El guion detallado está en `../docs/guion-ponencia.md`.

Cada slide tiene **notas del ponente** en HTML comments (`<!-- -->`) que aparecen en el modo presentador. Contienen las direcciones escénicas y el texto exacto a decir.

---

## Para iterar rápido

1. `npm run dev` en una terminal
2. Editar `slides.md` en el editor
3. Los cambios se reflejan instantáneamente en el browser
4. Para cambiar estilos: editar `styles/theme.css`
5. Para nuevos componentes: agregar en `components/` y usar `<MyComponent />`

---

## Problemas comunes

**"slidev command not found"**
→ Correr `npm install` primero. Luego `npm run dev` (usa el binario local).

**Las fuentes no cargan**
→ Slidev usa Google Fonts por defecto. Si hay problemas de red, las fuentes fallback son system UI.

**Los SVG se ven pequeños**
→ Ajustar `style="max-width: X%"` en el `<img>` correspondiente en `slides.md`.

**El export PDF falla**
→ Instalar playwright: `npx playwright install chromium`

---

## Créditos

- Framework: [Slidev](https://sli.dev) por [Anthony Fu](https://antfu.me)
- Tema oscuro custom: Felipe Mantilla
- Ilustraciones Excalidraw-style: inspiradas en [Excalidraw](https://excalidraw.com)
- Fuentes: Google Fonts (Instrument Serif, Inter, JetBrains Mono, Caveat, Space Grotesk)
