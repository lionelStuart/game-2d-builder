# Progress Log

## Day 1 (Scaffold)
- [x] Lock engine choice to Godot 4.x
- [x] Add runnable project bootstrap (`project.godot` + main scene)
- [x] Add baseline folder for UI assets (`assets/ui/`)
- [x] Create `src/scenes/main.tscn` scene skeleton (ground + camera + UI label)
- [x] Add camera movement and zoom controls in `src/scripts/main.gd` (direct key polling for compatibility)
- [x] Update README with engine-specific launch instructions

## Day 2 (Grid Placement Prototype)
- [x] Grid coordinate snapping utility
- [x] Click-to-place building tile prototype
- [x] Placement occupancy check

## Next (Day 3)
- [ ] Add ghost preview validity styling refinement
- [ ] Add rotate hotkeys (R)
- [ ] Keep placement preview aligned while camera moves

## Validation Notes
- Unit tests are executed after each implementation task (`python -m unittest discover -v`).
- App startup is verified with Godot 4 headless CLI (`/tmp/godot4/Godot_v4.2.2-stable_linux.x86_64 --headless --path . --quit-after 1`).

- `godot3-server` is installed for comparison only; it cannot run this Godot 4 project due to config version mismatch.
