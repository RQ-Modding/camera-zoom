# Testing Camera Zoom

For people and agents who test the mod in the game. Read it before you use anything the mod adds.

This mod has no buttons and no `rq.agent.control` ids. It only widens the cleared-dungeon camera range (lock 35, cleared 17.5–120, outdoors 17.5–150 with the 3D view cut at 400 in place of 200). Do not invent zoom controls for it.

- **The range on a map:** `rq.ain.call("３Ｄマップ_カメラ距離設定", 999.0)` returns the far end of the map shown now (it also moves the camera there; call it again with the old distance after). `rq.ain.call("カメラ距離")` is the distance the game keeps for every map.
- **Outdoors** is the area's kind (`ctx.kind` in `rq.dungeon.on_map`): `FOREST`, `SNOW`, `FIELD`, `MOUNTAIN`, `BURNING_FOREST`, `ROAD`, `WATERSIDE`, `CAMP`.
- **The view's cut** on the map shown now: `rq.ain.global("g_sMapMode", "m_Projection", "fFar")` (400 outdoors, 200 elsewhere).
- `rq.mod.get("camera-zoom")` returns `numbers` (`min`, `max`, `out_max`, `fog_far`, `far`, `out_far`, `steps`, `lock`) and `outdoors(kind)`.
- Test Lab: `test-lab/scenarios/camera.lua` (an outdoor area, then a cave; the view's cut; the wheel's step; the first visit's lock).

The slider on the dungeon HUD is the vanilla camera scrollbar, not this mod. Do not press it as part of a camera-zoom test unless the walk asked for the vanilla slider.
