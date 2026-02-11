# 🏗️ 2D Builder Game

A lightweight, extensible 2D construction/simulation game project.

## 🚀 Getting Started
- Engine: **Godot 4.x**
- Open: Import this folder as a Godot project (`project.godot`)
- Run: Press `F5` (main scene: `src/scenes/main.tscn`)

### Controls (Day 2 prototype)
- `W/A/S/D`: Move camera
- Arrow keys: Pan camera
- Mouse wheel: Zoom in/out
- Left click: Place tile on snapped grid

### CLI Validation
- Godot 4 headless smoke test:
  - `/tmp/godot4/Godot_v4.2.2-stable_linux.x86_64 --headless --path . --quit-after 1`
- Python unit test discovery:
  - `python -m unittest discover -v`

> Note: `godot3-server` is installed for compatibility checks, but this project targets **Godot 4** and should be run with a 4.x binary.

## 📁 Structure
- `docs/`: Design notes, TODOs, planning logs
- `assets/`: Art, sound, fonts, UI assets
- `src/scenes/`: Godot scenes (`.tscn`)
- `src/scripts/`: GDScript gameplay/system scripts
- `saves/`: Local save files (ignored by Git)

> 💡 Tip: Start with `docs/DESIGN_NOTES.md` to sketch your first building mechanic!
