# Definición de Alto Nivel — Ponencia UPTC 2026

Documento de trabajo para alinear la estructura, tesis, y decisiones de diseño
**antes** de entrar al detalle del guion minuto a minuto.

**Estado:** borrador para revisión
**Fecha:** 2026-04-23

---

## 1. Metadata de la entrega

| Campo | Valor |
|-------|-------|
| **Título** | IA Abierta: El Poder, la Arquitectura y el Precio de No Entender lo que Generas |
| **Evento** | Simposio Ingeniería de Sistemas — UPTC |
| **Fecha** | Abril 2026 (Tunja, Colombia) |
| **Duración** | 45 minutos (incluye demo en vivo; Q&A adicional si hay tiempo) |
| **Audiencia** | Profesores + estudiantes de últimos semestres de Ingeniería de Sistemas |
| **Modalidad** | Presencial, auditorio — proyección + laptop del ponente |
| **Ponente** | Felipe Mantilla (Moxiworks, Ingeniero de Software) |

---

## 2. Tesis central

> **La IA dejó de ser un servicio exclusivo. Cualquiera puede correr modelos competitivos en su laptop y usar agentes autónomos. Ese poder es inédito — pero peligroso si no se entiende. El rol del ingeniero es entender, validar, y responsabilizarse.**

**Frase de cierre** (la que tiene que quedar resonando):

> *"El poder es real. La responsabilidad también. Tu conocimiento vale más ahora, no menos."*

---

## 3. Objetivos de aprendizaje

Al final de los 45 minutos, la audiencia debería poder:

1. **Explicar** cómo funciona por dentro un agente de IA moderno (tool calling, context management, permisos). No solo "le pedís cosas y responde" — entender el harness.
2. **Reconocer** que la barrera de entrada a IA local es hoy **cero**: con una laptop decente podés correr modelos comparables a GPT-3.5.
3. **Identificar** los modos de falla específicos del código generado por IA: slop, vulnerabilidades, alucinación de APIs, pérdida de contexto.
4. **Decidir** cuándo aceptar y cuándo rechazar lo que genera una IA — no como "confiar/no confiar", sino como validación activa.

> 💡 Diseño: objetivos accionables, no abstractos. Si un estudiante sale pensando
> "yo también puedo correr esto en mi laptop esta noche", logramos algo.

---

## 4. Arco narrativo

La ponencia es un **viaje de 3 pasos**:

```
  De:   "La IA es una caja negra mágica"
  Por:  "La caja está abierta — aquí está adentro"
  A:    "Ahora que podés abrirla, es tu responsabilidad usarla bien"
```

Cada acto es una etapa del viaje:

| Acto | Estado mental de la audiencia al terminar |
|------|-------------------------------------------|
| Acto 1 | "Ya entiendo por qué Claude Code funciona — no es magia, es arquitectura" |
| Acto 2 | "Esto está corriendo **en su laptop sin internet**. Yo podría hacerlo igual" |
| Acto 3 | "Esto es poderoso, pero puede romperse mal. Yo tengo que poner el juicio" |

El arco no es "aquí hay 3 temas" — es una **progresión emocional**: fascinación → empoderamiento → responsabilidad.

---

## 5. Decisiones de diseño

### 5.1 ¿Por qué 3 actos y no un recorrido lineal?

Porque cada acto tiene su propio punchline emocional. Un recorrido lineal
("historia de la IA, modelos actuales, riesgos") sería un seminario. Tres
actos con arco propio es una charla.

### 5.2 ¿Por qué demo en vivo?

Porque la tesis del Acto 2 ("cualquiera puede correrlo") **no se cree por
diapositiva** — hay que **verlo**. El momento "apagar el WiFi y que Claude
Code siga funcionando con Gemma 4 local" es la única forma de transmitir
visceralmente que esto es real y accesible.

**Costo:** riesgo de que algo falle en vivo → mitigado con pre-carga, pre-calentamiento,
y video de backup.

### 5.3 ¿Por qué hablar de la filtración de Claude Code?

Porque es el ejemplo más potente, reciente, y documentado de que **la arquitectura
de un agente no es secreta**. El 31 de marzo de 2026 salieron las 512K líneas del
source map. Ya no hay excusa para decir "no sé cómo funciona por dentro". Si la
quieren estudiar, pueden.

### 5.4 Tono y registro

- **Técnico pero conversacional** — audiencia es Ing. Sistemas, no legos. No
  subestimamos su inteligencia, pero evitamos jerga gratuita.
- **Honesto sobre límites** — incluyendo contar que Gemma local con thinking
  mode tiene problemas de tool calling. No vendemos humo.
- **Colombiano, directo** — prompts y ejemplos con contexto local (Tunja-Bogotá
  en problemas matemáticos, etc.)
- **Cero marketing** — no estamos vendiendo Anthropic ni Google ni Apple. Estamos
  contando lo que pasó, con evidencia.

### 5.5 Qué NO va a estar

- Historia de la IA (muy usada, aporta poco)
- Comparativa exhaustiva de modelos (se pone viejo en meses)
- Ética abstracta ("la IA podría tomar el control del mundo") — hablamos de
  responsabilidad concreta en código que se va a producción
- "Aprende IA en 10 días" / promesas motivacionales

---

## 6. Acto por acto

### Acto 1 — Agentes de IA y la filtración de Claude Code

**Duración:** 15 minutos
**Propósito:** Descomponer la caja negra. Mostrar que un agente es arquitectura,
no magia.

**Idea central:**
> Un modelo de lenguaje solo genera texto. Lo que permite que "haga cosas"
> (leer archivos, ejecutar código, modificar sistemas) es un **harness**:
> herramientas, permisos, gestión de contexto, planificación. Esto es ingeniería
> normal, no magia.

**Momentos clave:**
1. **Arranque**: "¿Qué pasó el 31 de marzo de 2026?" (reveal: filtración del
   source map, 512K líneas)
2. **Desmontaje**: las 3 capas de Claude Code (tools, permisos, contexto)
3. **Insight**: "Opus solo es un científico brillante en una habitación vacía.
   Claude Code es el laboratorio que lo equipa."
4. **Cierre acto**: mostrar ejemplo de tool call en vivo, pasar al Acto 2

**Datos citables:**
- ~40 herramientas expuestas al modelo
- 3 tiers de permisos (auto, ask, never)
- 5 estrategias de compactación de contexto
- 512K líneas de source map filtrado
- Proyectos como **Claw-Code** replicándolo en Python

**Demo asociada:** sesión corta de Claude Code con API Anthropic resolviendo una
tarea. Propósito: mostrar baseline de qué es capaz un agente "completo".

### Acto 2 — Modelos abiertos en hardware local

**Duración:** 12 minutos (incluye 5-7 min de demo en vivo)
**Propósito:** Mostrar que el poder ya no está gated por una API de pago. La
audiencia puede correr esto mismo al salir del auditorio.

**Idea central:**
> Gemma 4 26B MoE, cuantizado a 4 bits, corre a ~85 tokens/segundo en una laptop
> con 36 GB de memoria unificada. El modelo ocupa 17 GB y solo activa 3.8B
> parámetros por token. Esto es calidad de GPT-3.5 en hardware consumer, **sin
> internet**.

**Momentos clave:**
1. **Setup**: explicar qué es un modelo abierto, qué significa "open weights",
   y por qué corre en una laptop (cuantización + MoE + memoria unificada)
2. **Demo en vivo** (el corazón del acto):
   - Abrir Claude Code apuntando a Gemma 4 26B local
   - Pedirle construir el formulario de feedback (o similar) para **esta misma
     ponencia**
   - **Momento dramático**: apagar el WiFi frente al auditorio
   - Seguir trabajando, mostrar que ollama ps tiene GPU al 100%
3. **Reflexión**: costo mensual de API Anthropic vs eléctrico de correr local
4. **Cierre**: "Todo lo que vieron corre offline. Esa barrera ya no existe."

**Datos citables (verificados empíricamente):**
- Gemma 4 26B MoE: 85-87 tok/s en M5 Max 36GB
- Mismo modelo cuantizado a Q4_K_M: 17 GB en disco / RAM
- E4B (9 GB) corre igual de rápido que 26B MoE — confirma hipótesis MoE
- Cold start: 4 segundos, idle: 0
- Prompt eval: 500-800 tok/s

**Demo asociada:** construir **en vivo** el form de feedback que va a usar la
audiencia al final de la charla (meta-momento).

**Plan B:** si el demo falla → video grabado + comentario honesto sobre por qué
falla (context truncation, thinking mode, lo que sea — se convierte en material
del Acto 3).

### Acto 3 — El precio de no entender

**Duración:** 12 minutos
**Propósito:** No dejar a la audiencia eufórica. Mostrarles que el mismo poder
que acaban de ver **puede romper sistemas reales** si no entienden lo que
aceptan.

**Idea central:**
> Cuando una IA genera código, el que lo firma sos vos. Si pusiste un SQL
> injection, una credencial hardcodeada, o llamaste a una API que no existe,
> **es tu responsabilidad**. El modelo no tiene skin in the game; vos sí.

**Momentos clave:**
1. **Arranque**: "AI slop" — definición y ejemplo real (código que compila y se
   ve bien pero está mal)
2. **Modos de falla específicos**:
   - Alucinación de APIs inexistentes
   - Copy-paste de patterns obsoletos
   - Vulnerabilidades conocidas sin flaggear (SQL injection, XSS, secretos
     hardcoded)
   - Tool calling degradado en modelos locales con thinking mode (**nuestra
     anécdota vivida**)
3. **El principio de verificación activa**:
   - No es "confiar vs no confiar"
   - Es "entender lo suficiente para detectar fallas"
   - Tu conocimiento técnico **vale más, no menos**, con IA
4. **Cierre total**: volver a la frase de la tesis.

**Datos citables:**
- [Buscar 2-3 incidentes públicos de código AI-generated con vulnerabilidades]
- [Buscar estudios de Stanford/MIT sobre tasas de vulnerabilidad en código IA]
- [Anécdota propia de tool calling degradado con Gemma 4]

**Demo asociada (corta):**
- Mostrar código con SQL injection generado por un modelo (no es real-time —
  ya se sabe cuál sale)
- Mostrar que Claude Code / Gemma lo sugieren sin warning si no preguntás

---

## 7. Apertura y cierre

### 7.1 Apertura (3 min)

**Hook propuesto:**

> "Levanten la mano los que hoy pueden explicarme cómo funciona por dentro una
> herramienta como Claude Code o Cursor. [pause corta, poca gente lo hace]
> Está bien — hasta el 31 de marzo de este año, tampoco yo. Hoy les voy a
> mostrar por qué eso cambió."

Alternativa si el hook no funciona con el mood del auditorio:

> "¿Cuánto costaría tener un modelo tan bueno como GPT-3.5 corriendo en su
> propio computador sin pagarle a nadie? [pause] $0. Vamos a verlo."

### 7.2 Cierre (3-5 min)

Tres elementos:
1. **Recap de los 3 actos en una frase cada uno** (anclas memoriales)
2. **La frase fuerte**: *"El poder es real. La responsabilidad también. Tu
   conocimiento vale más ahora, no menos."*
3. **Llamado concreto**:
   - Escanear QR del repo con todo el material
   - Llenar el formulario de feedback (**que Gemma construyó en vivo hace 10 minutos**)
   - Invitación a contactarme si quieren reproducir algo

---

## 8. Assets a producir

| Asset | Para qué | Estado |
|-------|----------|--------|
| Slides (30-40) | Apoyo visual | Pendiente #19 |
| Guion minuto a minuto | Referencia en vivo | Pendiente #17 |
| Demo dir `~/demo-ponencia-uptc/` | Archivos para el demo | Parcial #16 |
| ~~Video backup del demo~~ | (descartado) | — |
| Feedback form web | Recoger feedback post-charla | ✅ parcial (Gemma lo construye en vivo) |
| QR con link al repo | Para compartir material | Pendiente |
| Checklist día-de | Evitar olvidos | Pendiente #20 |

---

## 9. Riesgos y mitigaciones

| Riesgo | Impacto | Mitigación |
|--------|---------|------------|
| Demo en vivo falla (modelo se cuelga, tool calling roto) | Alto | Pre-calentar modelo, tener prompt alternativo simple, ser honesto si falla y usarlo como material del Acto 3 |
| Proyector/conexión HDMI da problemas | Medio | Llegar 30 min antes, probar cable propio + adaptador |
| Se va la luz o internet del auditorio | Medio | Laptop al 100%, demo no depende de internet (ese es el punto) |
| Preguntas muy técnicas que no sé responder | Bajo | Tengo las 5 preguntas pedagógicas ya validadas (ver WORKFLOW.md §2); para el resto, "no sé, vamos a investigarlo" es respuesta aceptable |
| La charla se pasa de 45 min | Medio | Ensayos cronometrados (#21), markers de tiempo en el guion |
| Audiencia está menos técnica de lo esperado | Medio | Tener 2-3 "saltos" en el guion para ajustar profundidad en vivo |

---

## 10. Criterios de éxito

Cómo sabemos, después de la ponencia, si fue una charla lograda o no:

**Mínimo aceptable:**
- Se entregó el contenido completo sin pasarse de 50 min
- El demo en vivo funcionó al menos una vez
- La audiencia hizo al menos 3 preguntas en el Q&A

**Bueno:**
- Llenaron el formulario de feedback al menos 10 personas
- Al menos 3 comentarios en el feedback mencionan que "van a probar correrlo
  en su laptop"
- Hubo un momento en el que el auditorio se rió / hizo una expresión colectiva
  (señal de que la narrativa conectó)

**Excelente:**
- Un profesor o estudiante me buscó después para hablar de un proyecto donde
  quieren aplicar esto
- El repo del proyecto tuvo al menos 10 clones en la semana posterior
- Alguien compartió clip/foto en redes con cita correcta de la tesis

---

## 11. Preguntas abiertas para resolver antes del guion

Cosas que quiero decidir junto con Felipe antes de detallar el minuto-a-minuto:

- [ ] **¿La demo "apagar WiFi" se hace o no?** Pro: visceral, memorable. Contra: depende del layout del auditorio, puede verse como truco
- [ ] **¿Contamos la anécdota de thinking mode / tool calling fallando?** Es honesto y alinea con el Acto 3, pero alarga el Acto 2
- [ ] **¿Mostramos los 5 tiers de compactación de contexto?** Técnicamente interesante pero quizás demasiado detalle para 45 min
- [ ] **¿Acto 3 incluye ejemplo de incidente público** (ej: algún CVE conocido de código IA-generated) o solo teoría + nuestro caso?
- [ ] **Ratio de demo vs slide**: ¿cuánto tiempo en pantalla terminal vs keynote?
- [ ] **¿El feedback form se abre en pantalla durante el Q&A** o solo al final?

---

## 12. Material de referencia

Documentos ya existentes en el repo con contenido listo para usar:

- `propuesta-ponencia.md` — propuesta ejecutiva original
- `ideas-ponencia.md` — reporte completo de investigación
- `docs/fundamentos-completos.md` — estudio profundo con anexo sobre MCP
- `docs/deep-dive-agent-architecture.md` — arquitectura de Claude Code con detalles
- `docs/guia-modelos-locales.md` — guía práctica de modelos locales
- `docs/guia-practica-mac-m5max.md` — específico para M5 Max
- `scripts/benchmark-results.md` — números empíricos citables (85-87 tok/s)
- `WORKFLOW.md` — estado y tareas

---

## 13. Próximos pasos

1. **Revisar este documento con Felipe** — alinear en estructura, tono, apertura/cierre, y resolver las preguntas abiertas de §11
2. Actualizar este doc con decisiones
3. Escribir **#17 guion minuto a minuto** tomando este doc como contrato
4. Producir assets según §8

---

*Documento vivo — actualizar cuando haya decisiones nuevas.*
