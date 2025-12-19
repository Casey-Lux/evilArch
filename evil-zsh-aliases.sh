#!/usr/bin/env bash

set -e

# --- Config ---
ZSHRC="$HOME/.zshrc"
BA_DIR="$HOME/.config/blackarch"
BA_FILE="$BA_DIR/blackarch.zsh"
SOURCE_LINE='source ~/.config/blackarch/blackarch.zsh'

# --- Checks ---
if ! command -v zsh >/dev/null 2>&1; then
  echo "[!] Zsh no está instalado. Abortando."
  exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
  echo "[!] pacman no encontrado. Esto no es Arch."
  exit 1
fi

# --- Create dirs ---
mkdir -p "$BA_DIR"

# --- Write logic ---
cat > "$BA_FILE" << 'EOF'
# BlackArch helper functions (NO installs, NO groups)
# Carga manual y control total

# Listar herramientas por área
ba() {
  if [[ -z "$1" ]]; then
    echo "Uso: ba <area>"
    return 1
  fi
  pacman -Sg "blackarch-$1" | awk '{print $2}'
}

# Buscar herramientas BlackArch por nombre
ba-search() {
  if [[ -z "$1" ]]; then
    echo "Uso: ba-search <patrón>"
    return 1
  fi
  pacman -Ss blackarch | grep -i --color=auto "$1"
}

# Listar TODAS las herramientas BlackArch (sin duplicados)
ba-all() {
  sudo pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u
}

# Ver a qué áreas pertenece una herramienta
ba-where() {
  if [[ -z "$1" ]]; then
    echo "Uso: ba-where <herramienta>"
    return 1
  fi
  pacman -Qi "$1" | grep Groups
}

# Listar todas las categorías
ba-cat(){
	sudo pacman -S blackarch-<category>
}

# Wrapper explícito para instalar (no automático)
ba-install() {
  echo "[*] Instalación explícita:"
  sudo pacman -S "$@"
}
EOF

# --- Inject source line safely ---
if ! grep -Fxq "$SOURCE_LINE" "$ZSHRC"; then
  echo "" >> "$ZSHRC"
  echo "# BlackArch helpers" >> "$ZSHRC"
  echo "$SOURCE_LINE" >> "$ZSHRC"
fi

# --- Done ---
echo "[+] BlackArch helpers instalados."
echo "[+] Archivo: $BA_FILE"
echo "[+] Reinicia la shell o ejecuta: source ~/.zshrc"
