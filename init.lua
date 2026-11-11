-- Camera zoom for Rance Quest (xsystem4 + vanilla AIN): a wider zoom range in cleared dungeons, and
-- wider still in the areas with open ground (forests, fields, mountains, roads...).
-- First-visit lock stays 35.0 with wheel/slider off. Does not allocate Tapir plugins.
-- API reference: https://rq-modding.github.io/rq-modding-docs/reference/
--
-- The range is patched at load with rq.dungeon.camera, and set again in rq.dungeon.on_map for each
-- map the game builds, by the area's kind (rq.ids.map_kind). Loader 2.30.0 lets the call be made
-- again, and moves the 3D view's cut (`far`). The game keeps one zoom distance for every map and
-- clamps it to the range when a map opens, so after a cave the camera starts at the cave's far end.

local LOCK = 35.0
local DMIN = 17.5
local DMAX = 120.0
local FOG_FAR = 160.0
local SLIDER_STEPS = 25

-- Outdoors: the area kinds with open ground, their far end and where the 3D view is cut. With the
-- game's cut at 200, a far end past 120 shows black at the top of the view; at 400 the ground stays
-- whole (notes/plans/plan-morurun-camera.md 8.2, Moru's pick). Elsewhere the cut is the game's.
local OUT_MAX = 150.0
local OUT_FAR = 400.0
local FAR = 200.0
local K = rq.ids.map_kind
local OUTDOORS = {
  [K.FOREST] = true,
  [K.SNOW] = true,
  [K.FIELD] = true,
  [K.MOUNTAIN] = true,
  [K.BURNING_FOREST] = true,
  [K.ROAD] = true,
  [K.WATERSIDE] = true,
  [K.CAMP] = true,
}

rq.log(string.format(
  "camera-zoom: lock=%.1f cleared=%.1f-%.1f fog_far=%.1f outdoors max=%.1f far=%.1f steps=%d",
  LOCK, DMIN, DMAX, FOG_FAR, OUT_MAX, OUT_FAR, SLIDER_STEPS))

local function range(out)
  return {
    lock = LOCK,
    min = DMIN,
    max = out and OUT_MAX or DMAX,
    fog_far = FOG_FAR,
    far = out and OUT_FAR or FAR,
    slider_steps = SLIDER_STEPS,
  }
end

if not rq.dungeon.camera(range(false)) then
  error("camera-zoom: dungeon.camera patch failed (see logs/rqmod.log)")
end

local now_out = false
rq.dungeon.on_map(function(ctx)
  local out = OUTDOORS[ctx.kind] == true
  if out ~= now_out then
    rq.dungeon.camera(range(out))
    now_out = out
  end
  -- Returns nothing: whether the zoom is free on a first visit is the game's (or Binoculars').
end)

-- For tests (rq.mod.get("camera-zoom")): the numbers, and whether a map kind counts as outdoors.
return {
  numbers = { lock = LOCK, min = DMIN, max = DMAX, fog_far = FOG_FAR, far = FAR, out_max = OUT_MAX,
    out_far = OUT_FAR, steps = SLIDER_STEPS },
  outdoors = function(kind) return OUTDOORS[kind] == true end,
}
