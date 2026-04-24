# 🤝 Contribuir

¡Gracias por querer contribuir! Este repositorio es material educativo abierto sobre IA, agentes de código y open source. Se diseñó para ser **forkeable, adaptable y remixable**.

---

## 🎯 Formas de contribuir

### 1. Reportar errores o imprecisiones

Si encontrás:
- Un dato técnico desactualizado (los modelos, precios y métricas cambian rápido)
- Un enlace roto
- Un error en el guion o las notas del speaker
- Una afirmación sin respaldo

Abrí un **[Issue](https://github.com/enruana/simposio-uptc-abril-2026/issues)** con:
- Dónde está el error (archivo + línea si podés)
- Qué debería decir en su lugar
- Fuente o referencia que lo respalde

### 2. Mejorar el contenido

Pull requests bienvenidos para:
- **Slides nuevos** que complementen la narrativa
- **Diagramas Excalidraw** mejorados (los actuales son SVG hand-coded)
- **Traducciones** (a inglés, portugués, etc.)
- **Nuevos scripts o guías técnicas**
- **Adaptaciones** para otras universidades (crea tu fork y linkéalo en el Issues)

### 3. Adaptar la ponencia para otro evento

La forma más fácil:
1. **Fork** este repo
2. Editá `docs/01-propuesta.md` con tus datos (ponentes, universidad, fecha)
3. Ajustá `docs/03-guion-ponencia.md` al tono y contexto de tu audiencia
4. Modificá `presentation/slides.md` y/o `presentation/index.html`
5. Reemplazá los logos en `presentation/public/logos/`
6. Ejecutá/proyectá

Si tu adaptación sale bien, **mencionalo en Issues**: nos encanta saber a quién sirvió.

---

## 🛠️ Setup de desarrollo

### Para la presentación HTML

Editá directamente `presentation/index.html` o `presentation/style.css`. Ninguna dependencia.

```bash
# Abrir en el browser
open presentation/index.html
```

### Para la versión Slidev (con hot reload)

```bash
cd presentation
npm install
npm run dev
# abre http://localhost:3030
```

Cambios en `slides.md` o `style.css` se reflejan automáticamente.

### Para los scripts

```bash
# Probar el benchmark (requiere Ollama y modelos descargados)
./scripts/benchmark.sh

# Usar claude-local (requiere Claude Code instalado + Ollama)
./scripts/claude-local gemma4:26b
```

Ver [`scripts/README.md`](scripts/README.md) para detalles.

---

## 📝 Estándares

### Commits

Seguimos un formato simple y descriptivo:

```
Qué cambió (imperativo, en español, sin punto final)

Por qué. Detalles relevantes.

Co-Authored-By: Tu Nombre <email@ejemplo.com>
```

Ejemplo real del historial:
```
Slide 17: agregar tabla completa de formatos de cuantización

Antes: solo el SVG. Ahora: grid con SVG + tabla con 8 formatos (FP32 a Q2_K).
Q4_K_M destacado como sweet spot.
```

### Markdown

- Español conversacional, no formal
- Títulos con `##` (raramente `###`)
- Código con backticks para referencias y ``` ``` ``` para bloques
- Sin emojis en el cuerpo de los documentos (solo en READMEs y títulos)
- Enlaces descriptivos, no "click aquí"

### HTML/CSS de la presentación

- Todo en el tema oscuro existente (`--bg-primary`, `--accent`, etc.)
- Evitar dependencias externas (CDNs, frameworks)
- Comentarios tipo `<!-- SLIDE N · Título -->` para cada sección
- Usar `data-notes="slide-N"` consistentemente con el objeto `SPEAKER_NOTES`

---

## 🚫 Qué no hacer

- **No mover archivos** sin actualizar referencias en otros `.md`
- **No borrar las notas del speaker** — aunque creas que no sirven, son el guion del ponente
- **No subir PDFs/videos pesados** al repo — usar Git LFS o links externos
- **No cambiar el tono** a algo más corporativo — la ponencia está hecha con voz de "colega, no profesor"
- **No borrar los datos de METR/Veracode/Postmark sin reemplazo** — son el corazón del Acto 3

---

## 📬 Contacto

- **Issues:** para bugs, preguntas, propuestas
- **GitHub Discussions** (si está habilitado): para conversaciones más libres
- **Directo a los ponentes:**
  - Felipe Mantilla — [@enruana](https://github.com/enruana)
  - Zabdiel Blanco

---

## 📜 Código de conducta

Sé amable. Asumí buenas intenciones. No toleramos ataques personales, lenguaje discriminatorio, ni comportamiento excluyente.

Este proyecto se guía por los valores que defiende la ponencia:
- **Acceso abierto** — la IA y el conocimiento no son para unos pocos
- **Respeto al criterio ajeno** — todos están en algún punto del viaje
- **Construir, no destruir** — las críticas vienen acompañadas de propuestas

---

<p align="center">
  <em>"No necesitás permiso para entrar.<br>
  Necesitás curiosidad y el criterio que te dieron estos años."</em>
</p>
