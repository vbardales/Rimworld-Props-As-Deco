# Testing

No C#, no def of its own: every integration is an xpath patch on a source mod's defs. Nothing here is executed in game yet.

## Static

`pwsh -File Tests/Test-ChinesePatch.ps1`: XML well-formed, nothing copied from the Chinese source (no def, texture or assembly), patch folder guarded by the source mod in `LoadFolders.xml`, xpath limited to `Chi_XiangLu`, three clutter tags, layer and non-edifice set, source mod optional in `loadAfter`, no stale incompatibility. 64 assertions, last run 2026-10-28.

Shared validators (protocols root `scripts/`): `Check-ModBasics.ps1`, `Check-Translations.ps1` (nothing to translate, no def of ours), `Check-Status.ps1`.

## Manual scenarios (not executed): 1 to 6 the Chinese burner, 7 to 11 the surface and wall batches

Record RimWorld version, mod versions, language, revision, result and log per case.

1. Chinese Traditional Cultural Things Expanded + Knick Knacks + Props as Deco, fresh map: no red error at load; `Chi_XiangLu` found by the patch (the source declares RimWorld versions up to 1.5 only, so confirm the v1.5 folder is used on 1.6 and the def exists).
2. Bedroom and dining room with free tables: let a colonist complete the decoration job until the burner appears. Selection is random; force it with an isolated fixture if needed and label that artificial. Knick Knacks creates the object at no cost.
3. Manual construction of the burner under the source's own rules (research, menu) still works and is not blocked by the new layer. Check draw order against a table.
4. Facility: build near one then two burners (radius 2): Beauty +6 per link, two links at most. ChiTableE of the source mod links to this def natively.
5. Without the Chinese mod: no error, no log line. Without Knick Knacks: tags inert.
6. Save and reload with auto-created and hand-built burners.
7. Surfaces, one source at a time (Knick Knacks + Props as Deco + Diner Supplies, then Ponpeco Kids' Room): no red error at load; `DS_BurgerA` carries `SEX_Clutter` and a room tag in the loaded def (dev mode, Inspect or Defs); a colonist on recreation puts a diner object on a table of the matching room. Selection is random, force it with an isolated fixture if needed and label that artificial. Expect: the object is created on the table, no cost, no exception.
8. Layer conversion (Ponpeco Kids' Room, `PFK_Ball`, converted from `BuildingBelowTop`): the def reads `BuildingOnTop` and `isEdifice false`; placed by hand on the floor it still builds and draws over furniture (the accepted side effect of the README); placed by the colonist on a table it sits on the surface.
9. Walls (Colonists' Deco + Wall Decorations, `ucp_corkboard`): the def carries the decoration comp and extension, no error at load; a colonist hangs it on a free wall; the guard is per def, so one failing def must not stop the others (check the log for the patch of that mod only).
10. Architect hiding (Diner Supplies, Office Supplies): the entries are gone from the Furniture tab; the objects still appear through colonists; no other mod's entries are removed from the tab.
11. Batches off: without Knick Knacks the tags are inert (no error, no log line); without a source mod its batch does not load (no red patch error); without Colonists' Deco the wall patches do not run.

## Passes (Pickle)

Written, not run (writeTests). Suite: `Tests/Pickle/Mod/Pickle/Features/01-patches-apply.feature`, companion mod `Tests/Pickle/Mod` (packageId nelim.propsasdeco.pickletests, development only), core steps only (`the save "test-colony" is loaded`, `I wait 120 ticks`, `no errors were logged`). What it proves: the patches find their defs in a running game, since a patch whose xpath matches nothing writes a red error per operation. It does not prove placement, drawing order or the colonist decorating a table: scenarios 2 to 4, 6 to 10 stay manual and need a person or a capture.

Three passes, each its own dependency map (all stage Knick Knacks or Colonists Deco first):

- `chinese` (`wsl-deps.chinese.map`): the Chinese source, scenario 1; red means RimWorld 1.6 does not use that mod v1.5 folder.
- `surfaces` (`wsl-deps.surfaces.map`): Diner Supplies, Ponpeco Kids Room, Office Supplies; covers layer conversion and the architect hiding at load.
- `walls` (`wsl-deps.walls.map`): Colonists Deco, Wall Decorations, UNAGI; covers the per-def guards.

No pass without optional mods: nothing of this mod runs without its sources (that case, scenario 11, is read in the log of any pass). No incompatibility declared, so no incompatibility pass. Hard dependencies of the staged sources are not listed yet: the first run names any that is missing, the maps are then completed. Non-regression (full suite on the published revision) belongs to followUp, not before.
