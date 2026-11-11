# Camera Zoom

A wider camera zoom range in dungeons you have already cleared, wider still outdoors.

## What it changes

- In a cleared dungeon, the mouse wheel and the zoom slider go from **17.5** (close) to **120**
  (far), in **25** steps, and the fog starts farther away (**160**) so the far view is not hidden.
- **Outdoors** (forests, snow, fields, mountains, the burning forest, roads, the waterside and the
  camp), the far end is **150**, and the game draws ground up to **400** from the camera in place of
  200, so the far rows stay on screen. Caves, buildings, castles, ruins, towers and the Malgrid
  Dungeon keep 120.
- Zoomed far out, some outdoor areas show black at a corner of the screen: that is where the sky
  under the map ends, as at 120 in some areas already.
- The game keeps one zoom distance for every map. After a cave the camera starts at the cave's far
  end; zoom out again outdoors.
- On a first visit the camera stays locked at **35**, as in the game. (The Binoculars mod unlocks it
  there.)

## Keys and settings

None in the game. The numbers are at the top of `init.lua`: `LOCK`, `DMIN`, `DMAX`, `FOG_FAR`,
`SLIDER_STEPS`, and for outdoors `OUT_MAX`, `OUT_FAR` (where the view is cut) and the list of area
kinds. With the cut at the game's 200, a far end past 120 shows black at the top of the view.

## Saves

Nothing.

## Works with

Binoculars uses this mod's range on a first visit when both are installed.

## Install

Needs [RQ MOD](https://github.com/RQ-Modding/RQ-Mod) with loader **2.30.0** or newer. Extract the
release zip into the game's `mods` folder, so that you have `mods/camera-zoom/mod.json`.

## License

MIT, see [LICENSE](LICENSE).
