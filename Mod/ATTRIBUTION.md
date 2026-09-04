# Attribution

This mod contains **no file belonging to anyone else**: no texture, no sound, no def. Only xpath
operations placing markers on other mods' defs.

Every batch sits behind an `IfModActive` branch in `LoadFolders.xml`. Without the source mod its
patch never loads, does nothing and reports nothing. Nothing is copied, nothing is redistributed,
and the mod is useless without its sources — it brings them players rather than competing with
them.

## The two engines

- **Knick Knacks — Let your colonists decorate!** (VaguelySexual,
  [3595196942](https://steamcommunity.com/sharedfiles/filedetails/?id=3595196942)) — 330 surface objects.
  Its whole registry lives in `buildingTags`, which are plain strings: adding them cannot break
  anything when it is absent.
- **Colonists' Deco (Continued)** (Mlie, after the original,
  [3511154027](https://steamcommunity.com/sharedfiles/filedetails/?id=3511154027)) — 18 wall pieces.
  Its contract references its own assembly (`thingClass`, `CompProperties_Decoration`,
  `DecoModExtension`), so every patch sits under `PatchOperationFindMod`.

## The sources

Nothing is taken from any of them. The number is how many objects are handed to an engine.

### Surfaces

| Mod | Author | Workshop | Objects |
|---|---|---|---|
| Miniature Props and Decor | Leo39994 | [3579351912](https://steamcommunity.com/sharedfiles/filedetails/?id=3579351912) | 144 |
| Whaleys Props | Whaley | [3523190580](https://steamcommunity.com/sharedfiles/filedetails/?id=3523190580) | 55 |
| Office Supplies | LUNARTIKA | [3394085110](https://steamcommunity.com/sharedfiles/filedetails/?id=3394085110) | 24 |
| Alpha Props — Parks and Gardens | Sarg Bjornson | [3146268928](https://steamcommunity.com/sharedfiles/filedetails/?id=3146268928) | 21 |
| Victorian decorations | 小面包 | [2937276828](https://steamcommunity.com/sharedfiles/filedetails/?id=2937276828) | 18 |
| Ponpeco Furnitures : Kids' Room | ponpeco | [3367310887](https://steamcommunity.com/sharedfiles/filedetails/?id=3367310887) | 16 |
| Diner Supplies | LUNARTIKA | [3501336537](https://steamcommunity.com/sharedfiles/filedetails/?id=3501336537) | 13 |
| Decorations and dishes at Gorgeous banquet | mo | [3027639868](https://steamcommunity.com/sharedfiles/filedetails/?id=3027639868) | 10 |
| Gerrymon's Hotspring Expanded | brucethemoose | [3765052370](https://steamcommunity.com/sharedfiles/filedetails/?id=3765052370) | 6 |
| Magical Decor Compilation | Seti | [3726648335](https://steamcommunity.com/sharedfiles/filedetails/?id=3726648335) | 6 |
| Too Many Props (Continued) | Zaljerem | [3132069492](https://steamcommunity.com/sharedfiles/filedetails/?id=3132069492) | 6 |
| Tabletop Decorations | bazoka81 | [2535771403](https://steamcommunity.com/sharedfiles/filedetails/?id=2535771403) | 4 |
| Gerrymon's Misc Props: Graveyard | Gerrymon | [3780458386](https://steamcommunity.com/sharedfiles/filedetails/?id=3780458386) | 3 |
| [ATW] House Decor | MG_Atwood | [3535047810](https://steamcommunity.com/sharedfiles/filedetails/?id=3535047810) | 2 |
| Rabbie The Moonrabbit race | Runne Latki | [1837246563](https://steamcommunity.com/sharedfiles/filedetails/?id=1837246563) | 2 |

### Walls

| Mod | Author | Workshop | Objects |
|---|---|---|---|
| Wall Decorations | bazoka81 | [2546782400](https://steamcommunity.com/sharedfiles/filedetails/?id=2546782400) | 12 |
| UNAGI Decorative Furniture | UNAGI | [3379047800](https://steamcommunity.com/sharedfiles/filedetails/?id=3379047800) | 4 |
| Rabbie The Moonrabbit race | Runne Latki | [1837246563](https://steamcommunity.com/sharedfiles/filedetails/?id=1837246563) | 2 |

## Acknowledged debt

Knick Knacks' own patches served as the model: the use of `PatchOperationFindMod` to gate a batch
on a mod being present comes from its `SurfaceBlacklist.xml`.

Not a line is copied from any of these mods; it is the methods that are borrowed.

