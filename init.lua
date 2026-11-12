-- Camera zoom for Rance Quest (xsystem4 + vanilla AIN): a wider zoom range in cleared dungeons, and
-- wider still in the areas with open ground (forests, fields, mountains, roads...).
-- First-visit lock stays 35.0 with wheel/slider off. Does not allocate Tapir plugins.
-- API reference: https://rq-modding.github.io/rq-modding-docs/reference/
--
-- The range is patched at load with rq.dungeon.camera, and set again in rq.dungeon.on_map for each
-- map the game builds, by the area's kind (rq.ids.map_kind). Loader 2.30.0 lets the call be made
-- again, and moves the 3D view's cut (`far`). The game keeps one zoom distance for every map and
-- clamps it to the range when a map opens, so after a cave the camera starts at the cave's far end.
--
-- 1.2.0: the numbers are on the mod's page in Config's Mods tab (rq.config.settings, loader 2.44.0),
-- each with the range we found good, and the game's Yes / No when the player leaves it. The view's
-- cut follows the far end, and the fog stays at 160 (the survey saw no change past it).

local FOG_FAR = 160.0
local FAR = 200.0     -- the game's cut
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

-- The settings. The defaults are 1.1's numbers; the recommended ranges come from the survey shots of
-- notes/plans/plan-morurun-camera.md (4.2 and 8.2) and plan-mod-review.md (3.2).
local settings = rq.config.settings{
  id = "camera-zoom",
  title = "Camera Zoom",
  rows = {
    { kind = "slider", key = "min", label = "Nearest zoom", min = 5, max = 35, step = 0.5, default = 17.5,
      format = "%.1f", recommend = { 15, 35 }, w = 240,
      warn = "Nearer than 15 the camera goes into walls and into the party.",
      tip = "How close the wheel and the zoom slider bring the camera, in caves and outdoors. The game's own is 35.",
      note = "How close the camera can come. The game's own is 35." },
    { kind = "slider", key = "max", label = "Farthest indoors", min = 35, max = 200, step = 1,
      default = 120, format = "%.0f", recommend = { 60, 120 }, w = 240,
      warn = "Past 120 you see more black past the walls, and the far rooms appear in view.",
      tip = "How far the camera goes in caves, buildings, castles, ruins, towers and the Malgrid Dungeon. The game's own is 60.",
      note = "Caves, buildings, castles, ruins, towers, the Malgrid Dungeon. The game's own is 60." },
    { kind = "slider", key = "out_max", label = "Farthest outdoors", min = 35, max = 250, step = 1,
      default = 150, format = "%.0f", recommend = { 60, 150 }, w = 240,
      warn = "Past 150 the edge of the sky shows as black corners, and past 180 the far ground is cut.",
      tip = "How far the camera goes in forests, snow, fields, mountains, the burning forest, roads, the waterside and the camp. The game's own is 60.",
      note = "Forests, snow, fields, mountains, roads, the waterside, the camp. The game's own is 60." },
    { kind = "slider", key = "lock", label = "First-visit distance", min = 15, max = 80, step = 0.5,
      default = 35, format = "%.1f", recommend = { 30, 45 }, w = 240,
      warn = "Nearer, the locked view shows little of the map; farther, more than the game means to show on a first visit.",
      tip = "Where the camera is locked on a dungeon's first visit, when the zoom is locked (without Binoculars). The game's own is 35.",
      note = "Where the camera stays on a first visit, when the zoom is locked. The game's own is 35." },
    { kind = "stepper", key = "steps", label = "Zoom steps", min = 5, max = 60, default = 25,
      recommend = { 15, 40 },
      warn = "Few steps make the zoom jump; many make the wheel slow.",
      tip = "How many steps the zoom slider and the mouse wheel take from the nearest to the farthest. The game's own is 25.",
      note = "Steps of the zoom slider and the wheel, nearest to farthest. The game's own is 25." },
    { kind = "space", h = 6 },
    { kind = "label", dim = true, size = 15,
      text = "A change holds from the next map the game builds: walk into the next area, or take a quest." },
  },
}

-- The 3D view's cut for a far end: the game's 200 up to 120; past it, at least 400, the cut that kept
-- the ground whole at 180 in the survey, and farther for a farther end.
local function cut_for(far_end)
  if far_end <= 120 then return FAR end
  return math.max(400.0, far_end * 8 / 3)
end

-- The numbers in use, the same table for as long as the game runs (the Lab reads it).
local numbers = {}
local function read_numbers()
  numbers.lock = settings.get("lock")
  numbers.min = settings.get("min")
  numbers.max = settings.get("max")
  numbers.out_max = settings.get("out_max")
  numbers.steps = math.tointeger(settings.get("steps"))
  numbers.fog_far = FOG_FAR
  numbers.far = cut_for(numbers.max)
  numbers.out_far = cut_for(numbers.out_max)
end
read_numbers()

local function log_numbers(why)
  rq.log(string.format(
    "camera-zoom%s: lock=%.1f cleared=%.1f-%.1f fog_far=%.1f outdoors max=%.1f far=%.1f steps=%d",
    why or "", numbers.lock, numbers.min, numbers.max, numbers.fog_far, numbers.out_max, numbers.out_far,
    numbers.steps))
end
log_numbers()

local function range(out)
  return {
    lock = numbers.lock,
    min = numbers.min,
    max = out and numbers.out_max or numbers.max,
    fog_far = numbers.fog_far,
    far = out and numbers.out_far or numbers.far,
    slider_steps = numbers.steps,
  }
end

if not rq.dungeon.camera(range(false)) then
  error("camera-zoom: dungeon.camera patch failed (see logs/rqmod.log)")
end

local now_out = false
rq.dungeon.on_map(function(ctx)
  local out = OUTDOORS[ctx.kind] == true
  -- Each map gets the range of its kind; a changed setting is picked up here too.
  rq.dungeon.camera(range(out))
  now_out = out
  -- Returns nothing: whether the zoom is free on a first visit is the game's (or Binoculars').
end)

-- A change on the page: the next map the game builds takes it (rq.dungeon.camera outside on_map).
settings.on_change(function()
  read_numbers()
  rq.dungeon.camera(range(now_out))
  log_numbers(" (changed)")
end)

-- For tests (rq.mod.get("camera-zoom")): the numbers, whether a map kind counts as outdoors, and the
-- page's set (which asks nothing).
return {
  numbers = numbers,
  outdoors = function(kind) return OUTDOORS[kind] == true end,
  set = function(key, value) settings.set(key, value) end,
  reset = function() settings.reset() end,
}
