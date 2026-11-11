# Changelog

Each section is a version of the mod, the `version` in `mod.json`. The release workflow copies the
section of a tagged version into the release notes.

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
