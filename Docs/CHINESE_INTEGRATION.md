# Chinese Traditional Cultural Things Expanded: one object by patch

Source: Workshop 2877536640 (`Dajian.ChiTeaditional.Expanded`), authors Diamond.J, DaJian, Frolg, TangWan, XF and contributors. Its `About.xml` objects to unauthorized republication of its assets, so nothing of it is copied: no def, no texture, no code. This mod only patches its def `Chi_XiangLu` (decorative incense burner, `1.5/Defs/ThingDefs/Buildings_JiaJu/Oct_JiaJu.xml`) in place.

## What the patch does

`Mod/ChineseTraditional/Patches/Deco.xml`, loaded from `LoadFolders.xml` under `IfModActive="dajian.chiteaditional.expanded"`: layer `Item` to `BuildingOnTop`, `isEdifice false`, tags `SEX_Clutter`, `SEX_BedroomClutter`, `SEX_DiningRoomClutter` so Knick Knacks can place it on tables. Cost, quality, Beauty facility (+6, two links, radius 2), research, menu category and passability remain the source's own. Knick Knacks spawns the object with `GenSpawn` (240 ticks job), at no material cost.

## Why only this object

`Docs/CHINESE_MANIFEST.json` indexes every concrete ThingDef inspected in the source's furniture, art, work and structure files, with the selection decision. Floor stands (Chi_New_AiCao, WuCaiZong, YuMiChuan, LaJiaoChuan, Chi_BiangZiQi), lanterns, rugs, bonsai, large statues, tables, beds, recreation and functional furniture are excluded. The ceramic chain (Chi_QingHuaCiA, SZ_Un_QingCi) has no agreed owner and needs producer inputs that no patch can supply.

## Open point

The source's `LoadFolders.xml` has no v1.6 block (v1.2 to v1.5). Whether RimWorld 1.6 falls back to the v1.5 block, and so whether the def is present for the patch, is checked in game (`TESTING.md`, scenario 1).

## History

Until 2026-10-28 this repository owned a copy of the def and texture as a private build (licence `forbidden`, suffix `(prohibited)`); that branch and its incompatibility with the source were removed when the burner became a patch. See git history before that date.
