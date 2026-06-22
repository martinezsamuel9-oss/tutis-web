# Tuti's — Sitio web · Guía para Claude Code

## Qué es esto
Sitio web de **Tuti's Frozen Yogurt** (Honduras). Una sola página (home) con todas las secciones:
hero, self-serve (con video), +40 sabores con filtro Normales/Sugar Free/Veganos, toppings, menú,
tiendas (con WhatsApp), franquicia, #TutisFam/gift cards/eventos, reseñas y footer.

Marca: magenta `#ED1C8E`, tinta oscura `#2B1622`. Tipografías: **Outfit** (títulos) + **DM Sans** (texto).

## Estructura
```
index.html        ← SITIO COMPILADO Y AUTÓNOMO (HTML+CSS+JS en un archivo). Esto se publica.
dist/index.html   ← Copia de la build.
src/
  Tutis Home.dc.html  ← CÓDIGO FUENTE editable (Design Component).
  support.js          ← Runtime del Design Component.
_headers          ← Caché y seguridad de Cloudflare Pages.
```

## Cómo está hecho (importante)
El sitio fuente es un **Design Component** (`src/Tutis Home.dc.html`): un `<x-dc>` con:
- **Template** (markup con estilos inline y holes `{{ }}`).
- **Logic class** `class Component extends DCLogic { renderVals() {...} }` dentro del `<script data-dc-script>`.

Los datos (sabores, toppings, tiendas, reseñas, pasos del self-serve) viven en `renderVals()` del logic class.
Las imágenes y el video se cargan por URL desde `tutisfranquicia.com` (WordPress actual).

## Editar contenido
- **Sabores / toppings / tiendas / reseñas:** editar los arrays en `renderVals()` dentro de `src/Tutis Home.dc.html`.
- **Textos / secciones:** editar el template del mismo archivo.
- Para previsualizar el `.dc.html` directo en el navegador necesita `support.js` al lado (ya está en `src/`).

## Recompilar el index.html
`index.html` es **generado** — no editarlo a mano. Tras cambiar `src/`, hay que volver a "inline" todo
en un solo archivo. La build original se hizo en el entorno de diseño de Claude. Para reconstruir manualmente:
abrí el `.dc.html`, resolvé el runtime e incrustá CSS/JS en un único HTML. (Si seguís en el entorno de
Claude, pedí recompilar y se regenera `dist/index.html`.)

## Desplegar (Cloudflare Pages)
Build command vacío · Output dir `/` · se publica `index.html`. Custom domain desde la pestaña *Custom domains*.

## Migrar imágenes/video al repo
Hoy los assets se cargan desde tutisfranquicia.com. Para hacerlos locales corré una vez:
`bash scripts/migrar-assets.sh` (descarga todo a `assets/` y reescribe las rutas en index.html/dist/src).

## Pendientes sugeridos
- [ ] Subpáginas: Menú completo, Franquicia, Tiendas, Eventos.
- [ ] Logo y fotos en alta resolución.
