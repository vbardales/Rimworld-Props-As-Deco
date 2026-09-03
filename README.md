# Props as Deco

*Hands decorative props over to the two mods that let colonists decorate by themselves.*

This mod contains **no def**. It is nothing but `buildingTags` and xpath operations placed on
other mods' defs, so that a colonist picks the prop up and puts it somewhere — instead of you
placing it from a build menu.

Nothing new to build, nothing new in the architect tabs, no new recreation type.

---

## The two engines

**[Knick Knacks](https://steamcommunity.com/sharedfiles/filedetails/?id=3595196942)** handles
surfaces. Its whole registry lives in `buildingTags`, which are plain strings:

| Tag | Role |
|---|---|
| `SEX_ClutterableSurface` | a surface that receives clutter — the mod puts it on `TableBase` itself, so on every table in the game |
| `SEX_InvalidSurfaceForClutter` | surface blacklist |
| `SEX_Clutter` | a placeable object |
| `SEX_BedroomClutter` / `SEX_DiningRoomClutter` | which room it belongs in |

**[Colonists' Deco](https://steamcommunity.com/sharedfiles/filedetails/?id=3511154027)** handles
walls. Knick Knacks does not: it does not contain a single occurrence of the word "wall".

The C# is already written in both cases and is not touched.

## What it covers

**330 objects on surfaces**, from fifteen source mods. **18 on walls**, from three.

Three structural conditions decide whether an object can sit on a surface: a 1x1 footprint,
`altitudeLayer BuildingOnTop`, `isEdifice false`. Across the seventeen sources, 476 defs meet
them — either directly, or after conversion for the twenty-one laid out in `BuildingBelowTop` or
on the `Item` layer.

But "passes the test" is not "makes sense on a bedside table". After reading the labels, **328**
were kept.

| Source mod | Eligible | Kept | Why the cut |
|---|---|---|---|
| Miniature Props and Decor | 158 | **144** | sorted by the mod's own per-room def files |
| Whaleys Props | 66 | **55** | paving tiles, trail posts, a power strip, tools |
| Office Supplies | 24 | **24** | none |
| Alpha Props — Parks and Gardens | 82 | **21** | park furniture: water lilies, topiaries, trellises |
| Victorian decorations | 20 | **18** | the chess board is already a recreation building; one oil painting is a wall piece |
| Ponpeco Furnitures: Kids' Room | 22 | **16** | buntings, curtains, fairy lights are wall pieces |
| Diner Supplies | 13 | **13** | none |
| Decorations and dishes at Gorgeous banquet | 12 | **10** | the dishes yes, the signage and the guardrail no |
| Gerrymon's Hotspring | 13 | **6** | towel, ladle, ring float: pool furniture |
| Magical Decor Compilation | 6 | **6** | none |
| Too Many Props | 6 | **6** | its `TableDefs.xml` is the whole eligible set |
| Tabletop Decorations | 23 | **4** | it is **workshop** clutter, and there is no workshop category |
| Gerrymon's Graveyard | 25 | **3** | **the other twenty-two are headstones** |
| [ATW] House Decor | 6 | **2** | window, curtains, two aquariums |
| Rabbie The Moonrabbit race | 4 | **2** | its laptop is a `Building_WorkTable` and its printer that bench's facility |
| Wall Decorations | 22 | **12** | eight 2x1 ivy patterns, a `Building_PowerSwitch`, a wall socket |
| UNAGI Decorative Furniture | 7 | **4** | a 3x3 and a 2x2 stained glass are too large |

## The limit that XML cannot get around

Knick Knacks has only two room categories, bedroom and dining room, and they are carried by two
C# `JoyGiver` classes. **A "workshop" category cannot be added by patch.** That is what sinks
Tabletop Decorations, whose vise, hammer, wrench, screwdriver, tape measure and robot arm have
nowhere to go.

## Three altitude layers, not one

The first pass only accepted `BuildingOnTop`. Two other layers carry placeable objects and need
converting: `BuildingBelowTop` (Ponpeco, 19 objects) and `Item` (Gerrymon, [ATW], 21 in total).
Conversion goes through `PatchOperationConditional`, so it works whether the field is declared on
the def or inherited from its base.

Accepted side effect: converting the layer changes the rendering **for everyone**, not just for
colonists. An object moved to `BuildingOnTop` draws over furniture, including when you place it
yourself. That is what you want for a toy meant to sit on a dresser; it is not what you want for
floor decor, which is why the 139 defs of the Gerrymon Misc Props sets are not converted wholesale.

## Hiding from the architect menu: two mods only

Diner Supplies and Office Supplies are the **only two sources covered in full**: their 13 and 24
defs are all handed over. Their entries are therefore removed from the vanilla Furniture tab,
where they now only add clutter — the objects still appear, placed by colonists.

One operation per mod: neither declares `designationCategory` on its defs, both put it on their
single abstract base. Removing it from the base is enough.

**Do not generalise.** Miniature Props is covered 144 out of 216, Alpha Props 21 out of 190: the
same operation there would permanently erase everything not integrated. Hiding is only justified
when coverage is total.

## What this mod does not do

- **`CompProperties_NoFloatingKnickKnacks`.** That component handles a knick-knack whose table is
  removed. It is deliberately **not** added: these props remain placeable on the floor by the
  player, and I could not verify whether the component merely prevents placement or destroys an
  unsupported object. Accepted consequence: a knick-knack a colonist set on a table that is later
  deconstructed will stay floating.
- **Outer Rim — Furniture & Decor** is not covered and will not be. Of its 258 defs, about 204 are
  **floor decals** — Aurebesh, corporate and faction logos — and the remaining ~54 are functional
  furniture. Nothing in it has the shape of a tabletop knick-knack. It is, however, the best
  candidate for the style system, which is what *Props as Style* is for.

## License and attribution

MIT. The mod contains no file belonging to anyone else; see [ATTRIBUTION.md](ATTRIBUTION.md).
