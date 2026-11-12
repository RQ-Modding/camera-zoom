# Changelog

Each section is a version of the mod, the `version` in `mod.json`. The release workflow copies the
section of a tagged version into the release notes.

## 1.2.0

- The numbers are on a page in Config's **Mods** tab, **Camera Zoom**: the nearest zoom, the farthest
  indoors (caves and buildings), the farthest outdoors, the first-visit distance and the zoom steps. Each
  row says what it changes, the game's own number and the range we recommend.
- Setting a number outside its recommended range asks first, with what goes wrong there: **Yes**
  keeps it, **No** puts the range's end.
- Where the 3D view is cut follows the farthest zoom: the game's 200 up to 120, at least 400 past it.
  The fog stays at 160.
- A change holds from the next map the game builds. Needs loader 2.44.0.

## 1.1.0

- Outdoors, a farther zoom: the far end is 150 in forests, snow, fields, mountains, the burning
  forest, roads, the waterside and the camp (the area's kind, `rq.ids.map_kind`), and the 3D view is
  cut at 400 in place of 200, so the far rows of ground stay on screen. Other areas keep 17.5 to 120
  and the game's cut.
- Sets the range in `rq.dungeon.on_map` for each map; needs loader 2.30.0, where `rq.dungeon.camera`
  can be called again and has `far`.

## 1.0.0

First version.

- Cleared dungeons zoom from 17.5 to 120 in 25 steps, with the fog at 160. A first visit stays
  locked at 35.
- Uses `rq.dungeon.camera` and needs loader 1.0.0.
