# Tuti's — Sitio web

Sitio web oficial de **Tuti's Frozen Yogurt** (Honduras). Rediseño premium, self-serve, +40 sabores.

🔗 Producción: _(pendiente de asignar subdominio en Cloudflare)_

---

## 🗂 Estructura del proyecto

```
.
├── index.html          ← Sitio compilado y autónomo. ESTO es lo que se publica.
├── dist/
│   └── index.html      ← Copia de la build (misma que la raíz).
├── src/                ← Código fuente editable (Design Component).
│   ├── Tutis Home.dc.html
│   └── support.js
├── _headers            ← Reglas de caché y seguridad para Cloudflare.
├── .gitignore
└── README.md
```

`index.html` es un único archivo **sin dependencias** (HTML + CSS + JS embebidos). Se puede abrir directo en el navegador y se publica tal cual.

---

## 🚀 Publicar en Cloudflare Pages

### Opción A — Conectar el repositorio (recomendado)

1. Subí este proyecto a GitHub (ver más abajo).
2. En el panel de Cloudflare → **Workers & Pages** → **Create application** → **Pages** → **Connect to Git**.
3. Elegí el repositorio `tutis-web`.
4. Configuración de build:
   - **Framework preset:** `None`
   - **Build command:** _(dejar vacío)_
   - **Build output directory:** `/`  (la raíz, donde está `index.html`)
5. **Save and Deploy**. En ~1 minuto el sitio queda online en `https://tutis-web.pages.dev`.

### Conectar tu dominio / subdominio

1. Dentro del proyecto en Pages → pestaña **Custom domains** → **Set up a custom domain**.
2. Escribí el subdominio que quieras usar, por ejemplo `www.tudominio.com` o `tienda.tudominio.com`.
3. Como el dominio ya está en Cloudflare, el registro **CNAME** se crea automáticamente. Confirmá y esperá a que diga *Active* (suele ser inmediato).

> Repetí el paso de *Custom domains* por cada subdominio que quieras apuntar a este mismo sitio.

### Opción B — Subida directa (sin Git)

```bash
npm install -g wrangler
wrangler pages deploy . --project-name=tutis-web
```

---

## 💻 Subir a GitHub

```bash
git init
git add .
git commit -m "Sitio Tuti's — primera versión"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/tutis-web.git
git push -u origin main
```

---

## ✏️ Editar el sitio

El sitio se edita desde la fuente en `src/`. Tras cambiar el contenido hay que **recompilar** el `index.html` autónomo (se hace desde el entorno de diseño). No edites `index.html` a mano: es código generado.

### Imágenes y video
Por defecto las fotos de sabores, toppings, logo y el video del self-serve se cargan desde el sitio WordPress actual (`tutisfranquicia.com`). Funcionan mientras ese sitio siga activo.

**Para independencia total**, corré una sola vez (necesita `curl`, ya viene en Mac/Linux/Git Bash):

```bash
bash scripts/migrar-assets.sh
```

Descarga todos los archivos a `assets/` y reescribe automáticamente las rutas en `index.html`, `dist/` y `src/`. Después: `git add . && git commit -m "Migrar assets" && git push`.

---

© 2024 Tuti's Franquicia. Todos los derechos reservados.
