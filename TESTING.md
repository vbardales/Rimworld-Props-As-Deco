# Testing

No C#, no def of its own: every integration is an xpath patch on a source mod's defs. Proof is def-level (Pickle) plus static; game-engine behaviour is n/a with reasons below.

## Static

`pwsh -File Tests/Rule-OwnValues.ps1` (run by the generated Tests/Test-Mod.ps1 after the shared checks): nothing copied from the Chinese source (no def, texture or assembly), patch folder guarded by the source mod in `LoadFolders.xml`, xpath limited to `Chi_XiangLu`, three clutter tags, layer and non-edifice set, source mod optional in `loadAfter`, no stale incompatibility. 64 assertions, last run 2026-10-28.

Shared validators (protocols root `scripts/`): `Check-ModBasics.ps1`, `Check-Translations.ps1` (nothing to translate, no def of ours), `Check-Status.ps1`.

## Scenarios: def-level proof or n/a with reason (AUDIT 8.g, 8.k; Audit ruling 2026-11-11)

No scenario is played by hand. Each one is split in two: the MOD's value (a def field, tag, comp or extension) is asserted at def level in `Tests/Pickle/Mod/Pickle/Features/02-manual-checks.feature`; the GAME's own behaviour (placement engine, Knick Knacks job, drawing order, facility maths, hanging job) is not tested by us ("On ne teste pas le jeu") and is n/a, reason below.

| # | Subject | Mod value, proved at def level | Game engine part, n/a (reason) |
|---|---------|-------------------------------|--------------------------------|
| 1 | Chinese burner found on 1.6 | pass `chinese` green (a missed xpath writes a red error); `Chi_XiangLu` asserted in 02 | none |
| 2 | Burner appears on a table | `Chi_XiangLu` has `SEX_Clutter`, `SEX_BedroomClutter`, `SEX_DiningRoomClutter` (02) | n/a: the decoration job and its random pick are Knick Knacks code; the mod only adds tags |
| 3 | Manual build, draw order | `altitudeLayer` is `BuildingOnTop`, `building.isEdifice` false (02); cost, research, menu untouched (static `Rule-OwnValues.ps1`) | n/a: draw order and build menu are engine behaviour; the patch changes no other field |
| 4 | Beauty facility, two links | none: the facility comp is the source mod's, never patched here (static: xpath limited to the three fields) | n/a: facility maths is the game's, the def is not ours |
| 5 | Without the Chinese mod or Knick Knacks | LoadFolders guard asserted by `Rule-OwnValues.ps1` (64 assertions) | n/a: a missing mod is loader behaviour; the guard is the mod's value and is static-checked |
| 6 | Save and reload | 02: save and reload, no error since the mark (done for the Kids' Room batch) | none |
| 7 | Surfaces, tags on a diner object | `DS_BurgerA` tags (02), office and Kids' Room tags (02) | n/a: a colonist putting the object on a table is the Knick Knacks job |
| 8 | Layer conversion `PFK_Ball` | `altitudeLayer` and `isEdifice` (02) | n/a: hand placement and draw over furniture is the accepted side effect of the README, engine behaviour |
| 9 | Walls, corkboard | comp and extension with `decoLocationType` `Wall` (02); per-def guard shown by the `walls` pass green | n/a: a colonist hanging it is the Colonists' Deco job |
| 10 | Architect hiding | `DS_BurgerA` absent from the Furniture tab (02) | none |
| 11 | Batches off | see 5; no red patch error is read in any pass | n/a: loader behaviour, guard static-checked |

Scenario 2 note: forcing the pick with a fixture would test Knick Knacks, not this mod.

## Passes (Pickle)

Run green on 2d263fe (def-level scenarios; 02 extended 2026-11-11, to rerun). Suite: `Tests/Pickle/Mod/Pickle/Features/01-patches-apply.feature`, companion mod `Tests/Pickle/Mod` (packageId nelim.propsasdeco.pickletests, development only), core steps only (`the save "test-colony" is loaded`, `I wait 120 ticks`, `no errors were logged`). What it proves: the patches find their defs in a running game, since a patch whose xpath matches nothing writes a red error per operation. It does not prove placement, drawing order or the colonist decorating a table: the engine parts of scenarios 2 to 4 and 7 to 9 are n/a (table above).

Three passes, each its own dependency map (all stage Knick Knacks or Colonists Deco first):

- `chinese` (`wsl-deps.chinese.map`): the Chinese source, scenario 1; red means RimWorld 1.6 does not use that mod v1.5 folder.
- `surfaces` (`wsl-deps.surfaces.map`): Diner Supplies, Ponpeco Kids Room, Office Supplies; covers layer conversion and the architect hiding at load.
- `walls` (`wsl-deps.walls.map`): Colonists Deco, Wall Decorations, UNAGI; covers the per-def guards.

No pass without optional mods: nothing of this mod runs without its sources (that case, scenario 11, is read in the log of any pass). No incompatibility declared, so no incompatibility pass. Hard dependencies of the staged sources are not listed yet: the first run names any that is missing, the maps are then completed. Non-regression (full suite on the published revision) belongs to followUp, not before.
