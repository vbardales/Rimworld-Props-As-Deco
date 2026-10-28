# Testing

No C#, no def of its own: every integration is an xpath patch on a source mod's defs. Nothing here is executed in game yet.

## Static

`pwsh -File Tests/Test-ChinesePatch.ps1`: XML well-formed, nothing copied from the Chinese source (no def, texture or assembly), patch folder guarded by the source mod in `LoadFolders.xml`, xpath limited to `Chi_XiangLu`, three clutter tags, layer and non-edifice set, source mod optional in `loadAfter`, no stale incompatibility. 64 assertions, last run 2026-10-28.

Shared validators (protocols root `scripts/`): `Check-ModBasics.ps1`, `Check-Translations.ps1` (nothing to translate, no def of ours), `Check-Status.ps1`.

## Manual scenarios (not executed)

Record RimWorld version, mod versions, language, revision, result and log per case.

1. Chinese Traditional Cultural Things Expanded + Knick Knacks + Props as Deco, fresh map: no red error at load; `Chi_XiangLu` found by the patch (the source declares RimWorld versions up to 1.5 only, so confirm the v1.5 folder is used on 1.6 and the def exists).
2. Bedroom and dining room with free tables: let a colonist complete the decoration job until the burner appears. Selection is random; force it with an isolated fixture if needed and label that artificial. Knick Knacks creates the object at no cost.
3. Manual construction of the burner under the source's own rules (research, menu) still works and is not blocked by the new layer. Check draw order against a table.
4. Facility: build near one then two burners (radius 2): Beauty +6 per link, two links at most. ChiTableE of the source mod links to this def natively.
5. Without the Chinese mod: no error, no log line. Without Knick Knacks: tags inert.
6. Save and reload with auto-created and hand-built burners.

## Passes (Pickle)

Not written. One pass without optional mods is not meaningful: the patch needs its source. Planned families: with the Chinese source and Knick Knacks (scenarios 1, 2, 4); without optional mods (scenario 5). No declared incompatibility.
