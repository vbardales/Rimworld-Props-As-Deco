# What only this mod asserts: nothing of the Chinese source is copied, the Chi_XiangLu patch folder is guarded by its
# source mod and touches that def only, the clutter tags and layer conversion, the About identity with the optional
# source mods, every IfModActive id declared in loadAfter, and the own-building operation every inheriting def needs.
# Generic checks (XML well-formedness, About.xml shape, def references, patch guards, translations) are the shared scripts', run by Test-Mod.ps1.
# Takes -ModRoot (repository root) and -SharedDir (unused, kept for the Test-Mod.ps1 contract); prints findings, exits 1 on any.
param([string]$ModRoot = (Join-Path $PSScriptRoot '..'), [string]$SharedDir)
$ErrorActionPreference = 'Stop'
$ModRoot = (Resolve-Path -LiteralPath $ModRoot).Path
$mod = Join-Path $ModRoot 'Mod'
$script:findings = New-Object System.Collections.Generic.List[string]
function Assert-True($Condition, [string]$Message) { if (-not $Condition) { $script:findings.Add("FAIL: $Message") } }

$sourceId = 'dajian.chiteaditional.expanded'
$chineseDir = Join-Path $mod 'ChineseTraditional'

# Nothing of the Chinese source is copied: no def, texture or assembly in the patch folder or elsewhere in Mod.
Assert-True (-not (Test-Path (Join-Path $mod 'ChinesePrivate'))) 'Owned Chinese branch still present'
Assert-True (@(Get-ChildItem $chineseDir -Recurse -File | Where-Object Extension -ne '.xml').Count -eq 0) 'Non-XML file in the patch folder'
Assert-True (@(Get-ChildItem $mod -Recurse -Filter '*.dll').Count -eq 0) 'Unexpected assembly'
Assert-True (@(Get-ChildItem $chineseDir -Recurse -Filter '*.xml' | Where-Object { $_.FullName -match '[\\/]Defs[\\/]' }).Count -eq 0) 'Def under the patch folder'

# The patch folder is guarded by the source mod and touches Chi_XiangLu only.
[xml]$lf = Get-Content (Join-Path $mod 'LoadFolders.xml')
$branch = @($lf.SelectNodes('/loadFolders/v1.6/li[text()="ChineseTraditional"]'))
Assert-True ($branch.Count -eq 1 -and $branch[0].GetAttribute('IfModActive') -eq $sourceId) 'Patch folder not guarded by the source mod'
[xml]$p = Get-Content (Join-Path $chineseDir 'Patches/ChineseTraditional-Deco.xml')
$xpaths = @($p.SelectNodes('//xpath') | ForEach-Object { $_.InnerText })
Assert-True ($xpaths.Count -gt 0) 'Patch has no operation'
foreach ($xp in $xpaths) { Assert-True ($xp -match 'defName="Chi_XiangLu"') "xpath outside Chi_XiangLu: $xp" }
$tags = @($p.SelectNodes('//buildingTags/li') | ForEach-Object { $_.InnerText })
Assert-True ($tags.Count -eq 3 -and ($tags -contains 'SEX_Clutter') -and ($tags -contains 'SEX_BedroomClutter') -and ($tags -contains 'SEX_DiningRoomClutter')) 'Clutter tags wrong'
Assert-True ($p.OuterXml -match '<altitudeLayer>BuildingOnTop</altitudeLayer>') 'Layer conversion missing'
Assert-True ($p.OuterXml -match '<isEdifice>false</isEdifice>') 'Non-edifice missing'

# Metadata: source mod optional, no duplicate-def incompatibility left, identity kept.
[xml]$about = Get-Content (Join-Path $mod 'About/About.xml')
$m = $about.ModMetaData
Assert-True (@($m.loadAfter.li) -contains 'Dajian.ChiTeaditional.Expanded') 'Source mod missing from loadAfter'
Assert-True ($null -eq $m.modDependencies) 'Source mod must stay optional'
Assert-True ($null -eq $m.incompatibleWith) 'Stale incompatibility with the source mod'
Assert-True ($m.name -ceq 'Props as Deco' -and $m.author -ceq 'Nelim' -and $m.packageId -ceq 'nelim.propsasdeco') 'Name, author or packageId changed'

# Every IfModActive id of LoadFolders is declared in loadAfter (case-insensitive), so load order and activation use the same ids.
$declared = @($m.loadAfter.li | ForEach-Object { $_.ToLower() })
foreach ($li in @($lf.SelectNodes('/loadFolders/v1.6/li[@IfModActive]'))) {
    foreach ($id in $li.GetAttribute('IfModActive').Split(',')) { Assert-True ($declared -contains $id.Trim().ToLower()) "IfModActive id not in loadAfter: $id" }
}

# Patches run before inheritance: an xpath through /building matches nothing on a def that only inherits it, so each such def first gets its own <building/>.
foreach ($pf in @(Get-ChildItem (Join-Path $mod '*/Patches/ChineseTraditional-Deco.xml'))) {
    [xml]$px = Get-Content $pf.FullName
    $ops = @($px.SelectNodes('//Operation[xpath]'))
    $names = @(); foreach ($o in $ops) { if ($o.xpath -match 'defName="([^"]+)"\]/building') { $names += $Matches[1] } }
    foreach ($d in ($names | Select-Object -Unique)) {
        $key = 'defName="' + $d + '"]/building'
        $first = $null; foreach ($o in $ops) { if ($o.xpath.Contains($key)) { $first = $o; break } }
        Assert-True ($null -ne $first -and $first.OuterXml.Contains('ensure-own-building')) "$($pf.Directory.Parent.Name): $d has no ensure-own-building before its building operations"
    }
}

# RimWorld keys patch files by their path inside the load folder: two files named Patches/Deco.xml in different load
# folders replace each other, and only the last active one runs (found 2026-11-10: most patches never applied).
$dupe = @(Get-ChildItem $mod -Recurse -File -Filter '*.xml' | Where-Object { $_.FullName -match '[\/]Patches[\/]' } |
    Group-Object Name | Where-Object Count -gt 1)
Assert-True ($dupe.Count -eq 0) ("Patch file name used in several load folders: " + ($dupe.Name -join ', '))

if ($script:findings.Count) { $script:findings; exit 1 }
Write-Output 'PASS: Rule-OwnValues'
