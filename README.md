# grok-skills

Curated Agent Skills for Grok Build. Selected by GitHub stars and recent maintenance, then installed into `~/.grok/skills`.

Grok discovers skills from `~/.grok/skills/` and `./.grok/skills/`. There is no cloud account installer.

## Sources

- anthropics/skills (official; docx/pdf/pptx/xlsx/skill-creator skipped because Grok already bundles them)
- obra/superpowers
- addyosmani/agent-skills (`test-driven-development` is renamed to `agent-test-driven-development` if the superpowers skill is already present)
- DietrichGebert/ponytail

## Install on your machine

```bash
bash install.sh
```

Then start a new Grok Build session. Skills show up as `/<skill-name>`.
