# Camera Zoom

A wider camera zoom range in dungeons you have already cleared, wider still outdoors.

## Showcase

<img width="1264" height="756" alt="20261118-1501-34 2840135" src="https://github.com/user-attachments/assets/21e54b53-e004-40b6-bccf-3738548fd16f" />

## Mod Options

<img width="1267" height="915" alt="image" src="https://github.com/user-attachments/assets/a7366dfa-52cd-42af-97f7-e9c313c3a1e2" />

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

**Config → Mods → Camera Zoom** has the numbers, each with what it changes, the game's own number
and the range we recommend (drawn lighter on the slider):

| Setting | Default | Recommended | The game's own |
| --- | --- | --- | --- |
| Nearest zoom | 17.5 | 15 to 35 | 35 |
| Farthest indoors (caves, buildings) | 120 | 60 to 120 | 60 |
| Farthest outdoors | 150 | 60 to 150 | 60 |
| First-visit distance | 35 | 30 to 45 | 35 |
| Zoom steps | 25 | 15 to 40 | 25 |

- Setting a number outside its recommended range asks first and says what goes wrong there: nearer
  than 15 the camera goes into walls; past 120 in caves more black shows past the walls; past 150
  outdoors the edge of the sky shows as black corners, and past 180 the far ground is cut. **Yes**
  keeps your number; **No** puts the end of the range.
- A change holds from the next map the game builds: walk into the next area, or take a quest.
- **Reset** puts back the defaults.
- Where the game cuts the 3D view follows the farthest zoom by itself (the game's 200 up to 120, at
  least 400 past it), and the fog stays at 160.

## Saves

Nothing in the game's save. The settings are kept for every save (`rq.store.global`).

## Works with

Binoculars uses this mod's range on a first visit when both are installed.

## Install

Needs [RQ MOD](https://github.com/RQ-Modding/RQ-Mod) with loader **2.44.0** or newer. Extract the
release zip into the game's `mods` folder, so that you have `mods/camera-zoom/mod.json`.

## License

MIT, see [LICENSE](LICENSE).
