#!/usr/bin/env bash
# Install curated skills into Grok Build's user skill directory.
set -euo pipefail
DEST="${GROK_SKILLS_DIR:-$HOME/.grok/skills}"
mkdir -p "$DEST" /tmp/grok-skill-src
cd /tmp/grok-skill-src

clone_skills() {
  local url="$1" name="$2"
  rm -rf "$name"
  git clone --depth 1 --filter=blob:none --sparse "$url" "$name"
  git -C "$name" sparse-checkout set skills
}

clone_skills https://github.com/anthropics/skills.git anthropics-skills
clone_skills https://github.com/obra/superpowers.git superpowers
clone_skills https://github.com/addyosmani/agent-skills.git agent-skills
clone_skills https://github.com/DietrichGebert/ponytail.git ponytail

SKIP="docx pdf pptx xlsx skill-creator"
copy_skill() {
  local src="$1" name="$2"
  [ -f "$src/SKILL.md" ] || return 0
  for s in $SKIP; do
    [ "$name" = "$s" ] && return 0
  done
  rm -rf "$DEST/$name"
  cp -a "$src" "$DEST/$name"
  echo "installed $name"
}

for d in anthropics-skills/skills/* superpowers/skills/* ponytail/skills/*; do
  [ -d "$d" ] || continue
  copy_skill "$d" "$(basename "$d")"
done
for d in agent-skills/skills/*; do
  name="$(basename "$d")"
  if [ -d "$DEST/$name" ]; then
    name="agent-$name"
  fi
  copy_skill "$d" "$name"
done
echo "Done. Skills are in $DEST"
echo "Restart Grok Build so it reloads ~/.grok/skills."
