# Testing Camera Zoom

For people and agents who test the mod in the game. Read it before you use anything the mod adds.

It widens the cleared-dungeon camera range (by default lock 35, cleared 17.5–120, outdoors 17.5–150 with the 3D view cut at 400 in place of 200) and has a page in Config's Mods tab, **Camera Zoom** (`rq.config.show("camera-zoom")`). Its controls in `rqmod-ctl ui`:

| Control | What it is |
| --- | --- |
| `slider-min`, `slider-max`, `slider-out-max`, `slider-lock` | The nearest zoom, the farthest in caves and buildings, the farthest outdoors, the first-visit distance. `drag` the knob; the value is written at the release. |
| `stepper-steps`, `button-steps-dec`, `button-steps-inc` | The zoom steps. |
| `button-reset` | Puts back the defaults. |

A value outside a row's recommended range opens the game's Yes / No (`select` screen): `yes` keeps it, `no` puts the range's end. No other controls; the zoom itself is the game's HUD slider, not this mod's.

- **The range on a map:** `rq.ain.call("３Ｄマップ_カメラ距離設定", 999.0)` returns the far end of the map shown now (it also moves the camera there; call it again with the old distance after). `rq.ain.call("カメラ距離")` is the distance the game keeps for every map.
- **Outdoors** is the area's kind (`ctx.kind` in `rq.dungeon.on_map`): `FOREST`, `SNOW`, `FIELD`, `MOUNTAIN`, `BURNING_FOREST`, `ROAD`, `WATERSIDE`, `CAMP`.
- **The view's cut** on the map shown now: `rq.ain.global("g_sMapMode", "m_Projection", "fFar")` (400 outdoors, 200 elsewhere).
- `rq.mod.get("camera-zoom")` returns `numbers` (`min`, `max`, `out_max`, `fog_far`, `far`, `out_far`, `steps`, `lock`; the same table, kept up to date), `outdoors(kind)`, `set(key, value)` (as the page, with no question: keys `min`, `max`, `out_max`, `lock`, `steps`) and `reset()`.
- Test Lab: the scenario `camera` (an outdoor area, then a cave; the view's cut; the wheel's step; the first visit's lock; a changed setting on the next map). `config-pages`: the page, and the question past a recommended range.

The slider on the dungeon HUD is the vanilla camera scrollbar, not this mod. Do not press it as part of a camera-zoom test unless the walk asked for the vanilla slider.
