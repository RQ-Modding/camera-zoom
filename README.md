# Camera Zoom

A wider camera zoom range in dungeons you have already cleared.

## What it changes

- In a cleared dungeon, the mouse wheel and the zoom slider go from **17.5** (close) to **120**
  (far), in **25** steps, and the fog starts farther away (**160**) so the far view is not hidden.
- On a first visit the camera stays locked at **35**, as in the game. (The Binoculars mod unlocks it
  there.)

## Keys and settings

None in the game. The numbers are at the top of `init.lua`: `LOCK`, `DMIN`, `DMAX`, `FOG_FAR` and
`SLIDER_STEPS`.

## Saves

Nothing.

## Works with

Binoculars uses this mod's range on a first visit when both are installed.

## Install

Needs [RQ MOD](https://github.com/RQ-Modding/RQ-Mod) with loader **1.0.0** or newer. Extract the
release zip into the game's `mods` folder, so that you have `mods/camera-zoom/mod.json`.

## License

MIT, see [LICENSE](LICENSE).
