-- Cleared-dungeon camera zoom for Rance Quest (xsystem4 + vanilla AIN).
-- First-visit lock stays 35.0 with wheel/slider off. Does not allocate Tapir plugins.

local LOCK = 35.0
local DMIN = 17.5
local DMAX = 120.0
local FOG_FAR = 160.0
local SLIDER_STEPS = 25

rq.log(string.format(
  "camera-zoom: lock=%.1f cleared=%.1f-%.1f fog_far=%.1f steps=%d",
  LOCK, DMIN, DMAX, FOG_FAR, SLIDER_STEPS))

local ok = rq.dungeon_camera({
  lock = LOCK,
  min = DMIN,
  max = DMAX,
  fog_far = FOG_FAR,
  slider_steps = SLIDER_STEPS,
})

if not ok then
  error("camera-zoom: dungeon_camera patch failed (see mods/rqmod.log)")
end