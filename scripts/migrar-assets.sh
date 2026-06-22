#!/usr/bin/env bash
# ----------------------------------------------------------------------
# Tuti's — Migrar imágenes y video al repo
#
# Descarga todos los assets que hoy se cargan desde tutisfranquicia.com
# hacia la carpeta assets/ y reescribe las rutas en index.html, dist/ y src/
# para que el sitio quede 100% autónomo (sin depender de WordPress).
#
# Uso:   bash scripts/migrar-assets.sh
# Requisitos: curl y sed (vienen por defecto en Mac/Linux y en Git Bash).
# ----------------------------------------------------------------------
set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
mkdir -p assets

BASE="https://tutisfranquicia.com/wp-content/uploads"

# Lista de assets: "subcarpeta-wp/archivo"
ASSETS=(
  # Logo
  "2024/06/15._Logo_Tuti_s-removebg-preview.png"

  # Sabores normales
  "2024/07/Fresa.png" "2024/07/Chocolate.png" "2024/07/Cookies-and-Cream.png"
  "2024/07/Cookie-Dough.png" "2024/07/Nutella.png" "2024/07/Dulce-de-Leche.png"
  "2024/07/Red-Velvet.png" "2024/07/Mango.png" "2024/07/Pistacho.png"
  "2024/07/Salted-Caramel.png" "2024/07/Tiramisu.png" "2024/07/Birthday-Cake.png"
  "2024/07/Cheesecake-de-Fresa.png" "2024/07/Snickers.png" "2024/07/Taro.png"
  "2024/07/Vainilla.png" "2024/07/Key-Lime-Pie.png" "2024/07/Smores.png"

  # Sabores sugar free
  "2024/07/Fresa-1.png" "2024/07/Blueberry-1.png" "2024/07/Cappuccino-1.png"
  "2024/07/Red-Velvet-1.png" "2024/07/Dulce-de-Leche-1.png" "2024/07/Pistacho-1.png"
  "2024/07/Taro-1.png" "2024/07/Tiramisu-1.png" "2024/07/Birthday-Cake-1.png"
  "2024/07/Black-Cherry-1.png" "2024/07/Chicle-1.png" "2024/07/Salted-Caramel-1.png"

  # Sorbetes veganos
  "2024/07/Sorbete-de-Fresa.png" "2024/07/Sorbete-de-Mandarina.jpeg"
  "2024/07/Sorbete-de-Maracuya.png" "2024/07/Sorbete-de-Mora.png"
  "2024/07/Sorbete-de-Naranja.png" "2024/07/Sorbete-de-Sandia-Limon.jpeg"
  "2024/07/Sorbete-de-Toronja.png"

  # Toppings
  "2024/08/Frutas.png" "2024/08/Gummies.png" "2024/08/Galletas.png"
  "2024/08/Chocolates.png" "2024/08/Dulces.png" "2024/08/Salsas.png"
  "2024/08/Jaleas.png" "2024/08/Nueces-y-Cereales.png"
  "2024/08/Toppings-Especiales.png" "2024/08/Toppings-Premium.png"

  # Franquicia
  "2024/08/Image-5-Home.png"

  # Self-serve: video + poster
  "2024/07/Video-Self-Serve-1.mp4" "2024/07/Screenshot_22.png"
)

echo "⬇️  Descargando ${#ASSETS[@]} archivos a assets/ ..."
fail=0
for path in "${ASSETS[@]}"; do
  file="$(basename "$path")"
  if curl -fsSL "$BASE/$path" -o "assets/$file"; then
    echo "   ✓ $file"
  else
    echo "   ✗ NO se pudo descargar: $file"
    fail=$((fail+1))
  fi
done

echo "🔗 Reescribiendo rutas a assets/ ..."
# Reemplaza las tres bases de WordPress por assets/ en todos los archivos del sitio
TARGETS=("index.html" "dist/index.html" "src/Tutis Home.dc.html")
for f in "${TARGETS[@]}"; do
  [ -f "$f" ] || continue
  sed -i.bak \
    -e "s#$BASE/2024/06/#assets/#g" \
    -e "s#$BASE/2024/07/#assets/#g" \
    -e "s#$BASE/2024/08/#assets/#g" \
    "$f"
  rm -f "$f.bak"
  echo "   ✓ $f"
done

echo ""
if [ "$fail" -eq 0 ]; then
  echo "✅ Listo. Todos los assets están en assets/ y el sitio ya es autónomo."
else
  echo "⚠️  Terminó con $fail archivo(s) que no se pudieron descargar (revisá las URLs arriba)."
fi
echo "   Revisá el sitio, luego: git add . && git commit -m 'Migrar assets al repo' && git push"
