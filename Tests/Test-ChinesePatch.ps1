param([string]$ModPath=(Join-Path $PSScriptRoot '../Mod'))
$ErrorActionPreference='Stop'
$count=0
function Assert($ok,$message){if(-not $ok){throw $message};$script:count++}
foreach($f in @(Get-ChildItem $ModPath -Recurse -Filter '*.xml')){[xml]$x=Get-Content $f.FullName;Assert ($null -ne $x.DocumentElement) "Invalid XML: $f"}
$sourceId='dajian.chiteaditional.expanded'
# Nothing of the Chinese source is copied: no def, no texture, no assembly under the patch folder or elsewhere in Mod.
Assert (-not (Test-Path (Join-Path $ModPath 'ChinesePrivate'))) 'Owned Chinese branch still present'
Assert (@(Get-ChildItem (Join-Path $ModPath 'ChineseTraditional') -Recurse -File | Where-Object Extension -ne '.xml').Count -eq 0) 'Non-XML file in the patch folder'
Assert (@(Get-ChildItem $ModPath -Recurse -Filter '*.dll').Count -eq 0) 'Unexpected assembly'
Assert (@(Get-ChildItem (Join-Path $ModPath 'ChineseTraditional') -Recurse -Filter '*.xml' | Where-Object {$_.FullName -match '[\/]Defs[\/]'}).Count -eq 0) 'Def under the patch folder'
# The patch folder is guarded by the source mod and touches Chi_XiangLu only.
[xml]$lf=Get-Content (Join-Path $ModPath 'LoadFolders.xml')
$branch=@($lf.SelectNodes('/loadFolders/v1.6/li[text()="ChineseTraditional"]'))
Assert ($branch.Count -eq 1 -and $branch[0].GetAttribute('IfModActive') -eq $sourceId) 'Patch folder not guarded by the source mod'
[xml]$p=Get-Content (Join-Path $ModPath 'ChineseTraditional/Patches/Deco.xml')
$xpaths=@($p.SelectNodes('//xpath') | ForEach-Object {$_.InnerText})
Assert ($xpaths.Count -gt 0) 'Patch has no operation'
foreach($xp in $xpaths){Assert ($xp -match 'defName="Chi_XiangLu"') "xpath outside Chi_XiangLu: $xp"}
$tags=@($p.SelectNodes('//buildingTags/li') | ForEach-Object {$_.InnerText})
Assert ($tags.Count -eq 3 -and ($tags -contains 'SEX_Clutter') -and ($tags -contains 'SEX_BedroomClutter') -and ($tags -contains 'SEX_DiningRoomClutter')) 'Clutter tags wrong'
Assert ($p.OuterXml -match '<altitudeLayer>BuildingOnTop</altitudeLayer>') 'Layer conversion missing'
Assert ($p.OuterXml -match '<isEdifice>false</isEdifice>') 'Non-edifice missing'
# Metadata: optional dependency, no duplicate-def incompatibility left, no private notice.
[xml]$about=Get-Content (Join-Path $ModPath 'About/About.xml')
$m=$about.ModMetaData
Assert (@($m.loadAfter.li) -contains 'Dajian.ChiTeaditional.Expanded') 'Source mod missing from loadAfter'
Assert ($null -eq $m.modDependencies) 'Source mod must stay optional'
Assert ($null -eq $m.incompatibleWith) 'Stale incompatibility with the source mod'
Assert ($m.name -eq 'Props as Deco' -and $m.author -eq 'Nelim') 'Name or author changed'
# Every IfModActive id of LoadFolders is declared in loadAfter (case-insensitive), so load order and activation use the same ids.
$declared=@($m.loadAfter.li | ForEach-Object {$_.ToLower()})
foreach($li in @($lf.SelectNodes('/loadFolders/v1.6/li[@IfModActive]'))){foreach($id in $li.GetAttribute('IfModActive').Split(',')){Assert ($declared -contains $id.Trim().ToLower()) "IfModActive id not in loadAfter: $id"}}
# Patches run before inheritance: an xpath through /building matches nothing on a def that only inherits it, so each such def first gets its own <building/>.
foreach($pf in @(Get-ChildItem (Join-Path $ModPath '*/Patches/Deco.xml'))){
  [xml]$px=Get-Content $pf.FullName
  $ops=@($px.SelectNodes('//Operation[xpath]'))
  $names=@(); foreach($o in $ops){ if($o.xpath -match 'defName="([^"]+)"\]/building'){ $names+=$Matches[1] } }
  foreach($d in ($names | Select-Object -Unique)){
    $key='defName="'+$d+'"]/building'
    $first=$null; foreach($o in $ops){ if($o.xpath.Contains($key)){ $first=$o; break } }
    Assert ($null -ne $first -and $first.OuterXml.Contains('ensure-own-building')) "$($pf.Directory.Parent.Name): $d has no ensure-own-building before its building operations"
  }
}
Write-Output "PASS: $count assertions; XML, no copied asset, guarded patch folder, Chi_XiangLu-only xpath, tags, optional dependency, IfModActive ids in loadAfter. No in-game execution."
