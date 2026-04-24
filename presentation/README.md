# 🎬 Presentación — IA Abierta UPTC 2026

Deck HTML/CSS de la ponencia **"IA Abierta: El Poder, la Arquitectura y el Precio de No Entender lo que Generas"**.

**Ponentes:** Felipe Mantilla y Zabdiel Blanco · **Duración:** 45 minutos · **31 slides**

---

## 🚀 Dos formas de correr la presentación

### Opción 1 — HTML vanilla (recomendada para la ponencia)

**Doble-click en `index.html`**. Sin dependencias, sin servidor, sin internet.

```bash
# macOS
open index.html

# Linux
xdg-open index.html
```

### Opción 2 — Slidev con hot reload (para desarrollo)

```bash
npm install
npm run dev         # abre http://localhost:3030
```

Cambios en `slides.md` o `style.css` se reflejan al instante.

---

## 🎤 Modo presentador — notas en ventana separada

Este es el **flujo recomendado para el día de la ponencia**:

### Con HTML vanilla (`index.html`)

1. Abrí `index.html` (doble-click)
2. Apretá la tecla **`P`** (o click en el botón **📺 Notas**)
3. Se abre una **ventana nueva** con las notas del speaker
4. Arrastrá la ventana principal al proyector
5. Dejá la ventana de notas en tu laptop

Las dos ventanas se sincronizan automáticamente — cuando avanzás slide en una, avanza la otra.

### Con Slidev (`npm run dev`)

Abre dos pestañas:
- `http://localhost:3030/` — deck principal (al proyector)
- `http://localhost:3030/presenter/` — vista de presentador (en tu laptop)

---

## ⌨️ Atajos de teclado (HTML vanilla)

| Tecla | Acción |
|-------|--------|
| **`→`** / **`Espacio`** | Siguiente slide |
| **`←`** | Slide anterior |
| **`Home`** / **`End`** | Primer / último slide |
| **`P`** | **Abrir notas en ventana separada** |
| **`N`** | Mostrar/ocultar notas inline (panel inferior) |
| **`F`** | Pantalla completa |
| **`?`** | Ayuda |
| **`Esc`** | Cerrar paneles |

---

## 📁 Estructura

```
presentation/
├── README.md                Este archivo
├── index.html               🌟 Deck vanilla — doble-click para abrir
├── presenter.html           Modo presentador (notas)
├── slides.md                Fuente para Slidev (opcional)
├── style.css                Estilos globales
├── styles/
│   └── theme.css            Tema oscuro custom
├── package.json             Dependencias Slidev
│
└── public/                  Assets
    ├── qr-repo.svg          QR al repositorio
    ├── diagrams/            SVGs estilo Excalidraw (hand-drawn)
    │   ├── agent-loop-circular.svg
    │   ├── brain-vs-body.svg
    │   ├── breathing-logo.svg
    │   ├── enemy-map.svg
    │   ├── hero-portrait.svg
    │   ├── opensource-constellation.svg
    │   ├── quantization-visual.svg
    │   └── seven-layers-stack.svg
    ├── images/              Imágenes del deck
    │   ├── cientifico-jaula.png
    │   └── cientifico-libre.png
    ├── logos/               Logos oficiales
    │   ├── claude.png
    │   ├── claw-code.png
    │   ├── gemma-4.png
    │   ├── ollama.webp
    │   └── uptc.png
    └── screenshots/
        └── x-filtracion.png Tweet de la filtración
```

---

## 🎨 Sistema de diseño

### Paleta

| Variable CSS | Hex | Uso |
|--------------|-----|-----|
| `--bg-primary` | `#0a0a0a` | Fondo principal |
| `--bg-card` | `#141414` | Tarjetas |
| `--text-primary` | `#f5f5f5` | Títulos |
| `--text-body` | `#d4d4d4` | Cuerpo |
| `--accent` | `#00ff88` | **Verde terminal — datos killer** |
| `--danger` | `#ff3b5f` | Enemigos del Acto 3 |

### Tipografía

- **Títulos:** Instrument Serif — elegante, contrasta con lo técnico
- **Body:** Inter — clean, legible a distancia
- **Código / datos:** JetBrains Mono + Space Grotesk
- **Hand-drawn labels:** Caveat (para SVGs estilo Excalidraw)

### Componentes custom disponibles

- `.stat-block` — números grandes con glow
- `.big-number` — números aún más grandes (datos killer)
- `.quote-ancla` — frases citables con borde verde
- `.enemy-card` — tarjetas del Acto 3
- `.code-card` — bloques de terminal con dots rojo/amarillo/verde
- `.transition-slide` — slides de separación entre actos
- `.breathing-logo` — animación de pulso para el cierre
- `.handwritten` — texto en font Caveat estilo notas a mano

---

## 📄 Exportar a PDF (respaldo para el día)

**Crítico:** tener PDF de respaldo por si algo falla el día de la ponencia.

```bash
npm run export-pdf
# Genera slides-export.pdf

# Si es la primera vez:
npx playwright install chromium
```

---

## 🔧 Personalización

### Cambiar el contenido de un slide

- **HTML vanilla:** editá `index.html` directamente (cada slide es un `<section class="slide">`)
- **Slidev:** editá `slides.md` (cada slide separado por `---`)

### Cambiar las notas del speaker

En `index.html`, el objeto `SPEAKER_NOTES` contiene todas las notas con sus keys `slide-N`.
En `presenter.html` tenés la misma estructura en formato compacto.

### Cambiar los logos/imágenes

Reemplazá los archivos en `public/logos/`, `public/images/` o `public/screenshots/`.
Las referencias son relativas (`public/logos/uptc.png`).

### Cambiar el QR

1. Generá un nuevo QR en [qr-code-generator.com](https://www.qr-code-generator.com/)
2. O con Python: `python3 -c "import qrcode; img = qrcode.make('URL_AQUI'); img.save('public/qr-repo.svg')"`
3. Reemplazá `public/qr-repo.svg`

---

## ✅ Checklist pre-ponencia

### Hardware
- [ ] Laptop cargado al 100% + cargador conectado
- [ ] Adaptador de video para el proyector
- [ ] Cable ethernet listo (para el gesto WiFi off físico)

### Software
- [ ] `index.html` abre correctamente
- [ ] Los 31 slides renderean bien
- [ ] Las notas del speaker se abren con `P`
- [ ] SVGs cargan correctamente
- [ ] QR cargan correctamente
- [ ] Ambas ventanas se sincronizan

### Demo del Slide 17
- [ ] Ollama corriendo (`ollama ps` muestra gemma4:26b)
- [ ] Pre-calentamiento ejecutado (primer query no tarda en frío)
- [ ] Claude Code autenticado
- [ ] Directorio demo preparado
- [ ] Video backup grabado por si falla

### Personales
- [ ] Ensayo cronometrado al menos 2 veces
- [ ] Agua en el escenario
- [ ] Celular en silencio

---

## 🔗 Documentación relacionada

- **Guion completo:** [`../docs/03-guion-ponencia.md`](../docs/03-guion-ponencia.md)
- **Fundamentos técnicos:** [`../docs/04-fundamentos-tecnicos.md`](../docs/04-fundamentos-tecnicos.md)
- **Guía del demo Mac:** [`../docs/guias/mac-m5max.md`](../docs/guias/mac-m5max.md)
- **Workflow de preparación:** [`../docs/99-historial-desarrollo.md`](../docs/99-historial-desarrollo.md)

---

## 🐛 Problemas comunes

### "Los SVG no cargan"
Verificá que las rutas en `index.html` sean `public/diagrams/...` (relativas), no `/public/...` (absolutas).

### "Las fuentes se ven raras"
`index.html` carga Google Fonts al inicio. Si estás offline, usás la fuente fallback del sistema. Para el día de la ponencia, abrí el archivo una vez con internet para cachear las fuentes.

### "El presenter no sincroniza"
Ambas ventanas deben ser del mismo navegador (no Chrome + Safari). Usan `localStorage` que es same-origin.

### "Slidev: slidev: command not found"
Ejecutá `npm install` primero. Luego `npm run dev` usa el binario local.

---

## 🎓 Framework narrativo

La presentación sigue la estructura del **Hero's Journey**:

- **Acto 1 (0-18 min):** El héroe (estudiante) descubre el mundo (arquitectura Claude Code, filtración)
- **Acto 2 (18-28 min):** El héroe recibe las herramientas (Gemma local + demo)
- **Acto 3 (28-45 min):** Los enemigos del viaje (AI slop, slopsquatting, prompt injection) + la tesis

Ver [`../docs/06-definicion-alto-nivel.md`](../docs/06-definicion-alto-nivel.md) para el desarrollo completo de la narrativa.
