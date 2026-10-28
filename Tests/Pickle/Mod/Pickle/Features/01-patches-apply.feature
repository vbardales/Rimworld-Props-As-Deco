# Props as Deco is patch-only: these scenarios prove the patches find their defs in a running game, with each family
# of source mods staged by its own pass (wsl-deps.chinese.map, wsl-deps.surfaces.map, wsl-deps.walls.map).
# Core steps only. A patch whose xpath matches nothing writes one red error per operation, so "no errors were logged"
# after the load is the assertion. The scenarios of TESTING.md that need a person (placement, drawing order, the
# colonist decorating a table) stay manual.

Feature: Props as Deco patches apply

  @requires:Dajian.ChiTeaditional.Expanded
  Scenario: the Chinese incense burner is found on this game version
    # The source mod declares RimWorld versions up to 1.5 only: red here means the v1.5 folder is not used on 1.6
    # and Chi_XiangLu does not exist for the patch (TESTING.md scenario 1).
    Given the save "test-colony" is loaded
    When I wait 120 ticks
    Then no errors were logged

  @requires:DSP.LUN
  Scenario: the surface batches of Diner Supplies and Ponpeco Kids' Room apply
    Given the save "test-colony" is loaded
    When I wait 120 ticks
    Then no errors were logged

  @requires:Mlie.ColonistsDeco
  Scenario: the wall batches guarded by Colonists' Deco apply
    Given the save "test-colony" is loaded
    When I wait 120 ticks
    Then no errors were logged
