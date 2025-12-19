#!/usr/bin/env bash
# evil-tools.sh
# Minimal pentest tool installer for Arch / BlackArch
# Installs only selected, core tools using the safest method available

set -e

echo "[*] Updating system"
sudo pacman -Syu --needed

echo "[*] Installing base utilities (pacman)"
sudo pacman -S --needed \
    nmap \
    curl \
    jq \
    netcat \
    socat \
    smbclient \
    hashcat

echo "[*] Installing Python tools (pipx)"
sudo pacman -S --needed python python-pip python-pipx base-devel
pipx ensurepath

echo "[*] Installing Go-based tools"
sudo pacman -S --needed go

GO_BIN="$HOME/go/bin"
mkdir -p "$GO_BIN"

go install github.com/ffuf/ffuf/v2@latest
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install github.com/owasp-amass/amass/v4/...@latest

echo "[*] Persisting Go PATH configuration"

PATH_FILE="$HOME/.path.zsh"

if ! grep -q 'go/bin' "$PATH_FILE" 2>/dev/null; then
  echo 'export PATH="$HOME/go/bin:$PATH"' >> "$PATH_FILE"
fi

ZSHRC="$HOME/.zshrc"

if ! grep -q '.path.zsh' "$ZSHRC" 2>/dev/null; then
  echo '' >> "$ZSHRC"
  echo '# Load custom PATH entries' >> "$ZSHRC"
  echo '[ -f "$HOME/.path.zsh" ] && source "$HOME/.path.zsh"' >> "$ZSHRC"
fi

echo "[*] Installing AD / network tooling"
sudo pacman -S --needed impacket crackmapexec

echo "[*] Manual tools (not auto-installed):"
echo "  - burpsuite (download from PortSwigger)"
echo "  - pspy (download static binary when needed)"

echo "[+] Done. Open a new terminal or source ~/.zshrc to use Go tools."
