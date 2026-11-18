#!/usr/bin/env bash

# Symlink configs from this repo into $HOME.
# Format: <source>:<destination>:<name>

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dots-backups"

echo "Using dotfiles from: $DOTFILES_DIR"
echo "Backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

configs=(
  "$DOTFILES_DIR/tmux/tmux.conf:$HOME/.tmux.conf:tmux.conf"
  "$DOTFILES_DIR/git/gitconfig:$HOME/.gitconfig:gitconfig"
  "$DOTFILES_DIR/zsh/zshrc:$HOME/.zshrc:zshrc"
  "$DOTFILES_DIR/zsh/zshenv:$HOME/.zshenv:zshenv"
  "$DOTFILES_DIR/nvim:$HOME/.config/nvim:nvim"
  "$DOTFILES_DIR/wezterm:$HOME/.config/wezterm:wezterm"
  "$DOTFILES_DIR/helix:$HOME/.config/helix:helix"
  "$DOTFILES_DIR/ai/opencode/cli.json:$HOME/.config/opencode/cli.json:cli.json"
  "$DOTFILES_DIR/ai/Agents/AGENTS.md:$HOME/.config/opencode/AGENTS.md:AGENTS.md"
  "$DOTFILES_DIR/ai/opencode/opencode.json:$HOME/.config/opencode/opencode.json:opencode.json"
  "$DOTFILES_DIR/ai/Skills:$HOME/.config/opencode/skills:skills"
)

FAILED=()
LINKED=()
SKIPPED=()

backup() {
  local src="$1"
  local name="$2"
  local count next_num
  count=$(ls "$BACKUP_DIR"/"$name".backup.* 2>/dev/null | wc -l | tr -d ' ')
  next_num=$(printf "%02d" $((count + 1)))
  mv "$src" "$BACKUP_DIR/$name.backup.$next_num"
  echo "Backed up $src → $name.backup.$next_num"
}

link() {
  local src="$1"
  local dest="$2"
  local name="$3"

  if [ ! -e "$src" ]; then
    echo "Warning: source $src does not exist, skipping $name"
    SKIPPED+=("$name (missing source: $src)")
    return
  fi

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "Already linked: $dest"
    LINKED+=("$name")
    return
  fi

  mkdir -p "$(dirname "$dest")"

  if [ -L "$dest" ]; then
    rm "$dest"
    echo "Removed old symlink: $dest"
  elif [ -e "$dest" ]; then
    backup "$dest" "$name"
  fi

  if ln -sf "$src" "$dest"; then
    echo "Linked $dest → $src"
    LINKED+=("$name")
  else
    echo "Error: failed to link $dest"
    FAILED+=("$name")
  fi
}

already_linked=true
for entry in "${configs[@]}"; do
  IFS=: read -r src dest _ <<< "$entry"
  if ! [ -L "$dest" ] || [ "$(readlink "$dest")" != "$src" ]; then
    already_linked=false
    break
  fi
done

if $already_linked; then
  read -r -p "Everything is already linked. Run again anyway? [y/N] " reply
  if [[ "$reply" != "y" && "$reply" != "Y" ]]; then
    echo "Nothing to do."
    exit 0
  fi
fi

echo ""

for entry in "${configs[@]}"; do
  IFS=: read -r src dest name <<< "$entry"
  link "$src" "$dest" "$name"
done

echo ""
echo "-- Summary --"
echo "Linked (${#LINKED[@]}): ${LINKED[*]:-none}"
echo "Skipped (${#SKIPPED[@]}): ${SKIPPED[*]:-none}"
echo "Failed (${#FAILED[@]}): ${FAILED[*]:-none}"

if [ ${#FAILED[@]} -gt 0 ] || [ ${#SKIPPED[@]} -gt 0 ]; then
  echo ""
  echo "Some items need attention, check the warnings above."
  exit 1
fi

echo ""
echo "Done."
