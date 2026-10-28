# Changelog

Format inspired by [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This file serves the repository and the drafting of the Steam release notes; RimWorld does not show it in game.

## [Unreleased]

First version. RimWorld 1.6. No code, no def, no file of anyone else's: only xpath patches.

### Surfaces: 330 objects handed to Knick Knacks

Fifteen source mods. The objects receive `SEX_Clutter` plus `SEX_BedroomClutter` or
`SEX_DiningRoomClutter` depending on the room. A colonist on recreation fetches them and puts them down.

Three structural conditions decide eligibility: 1x1 footprint,
`altitudeLayer BuildingOnTop`, `isEdifice false`. Twenty-one objects laid out in `BuildingBelowTop`
or on the `Item` layer are converted by a conditional.

### Walls: 18 objects handed to Colonists' Deco

Three source mods. Heavier contract: `thingClass`, `CompProperties_Decoration` and
`modExtensions`, two of which reference the mod's assembly. Everything sits under
`PatchOperationFindMod`, with **one guard per def** and not one for the whole file, because a
`PatchOperationSequence` stops at the first operation that fails.

### One object from Chinese Traditional Cultural Things Expanded

The decorative incense burner `Chi_XiangLu` is registered with Knick Knacks by a patch on the source's own def (layer, non-edifice, three clutter tags). Nothing is copied from that mod. Its `LoadFolders.xml` declares versions up to 1.5 only: presence on 1.6 is to be confirmed in game.

### Architect menu hiding

Diner Supplies and Office Supplies are the only two sources covered at 100 %. Their entries
are removed from the vanilla Furniture tab: one operation per mod, the category being carried by
their single abstract base. Not generalisable: elsewhere coverage is partial and hiding
would amount to deleting.

### What was deliberately left out

Semantic sorting cut far more than structural sorting. The 204 Outer Rim decals and
the 43 Miniature Props logos are on the floor layer; the fourteen "conforming" defs of Gerrymon's
Graveyard are headstones; Marketable Craftsmanship art is crafted and giving it away
would break the economy; `ucp_wallswitch` is a `Building_PowerSwitch` and
`LSK_RB_Laptop` a `Building_WorkTable`. The detail sits at the top of each patch file.
