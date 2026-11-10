# Def-level part of the manual scenarios of TESTING.md (6 to 10). Placement, drawing order and the colonist
# decorating a table stay manual.

Feature: Props as Deco defs after patching

  @requires:ponpeco.PFKidsRoom
  Scenario: the ball is converted to the top layer and is no edifice (TESTING.md 8)
    Given the save "test-colony" is loaded
    Then Nelim's Pickle Tools: def "PFK_Ball" of type "ThingDef" field "altitudeLayer" is "BuildingOnTop"
    And Nelim's Pickle Tools: def "PFK_Ball" of type "ThingDef" field "building.isEdifice" is "false"

  @requires:ucp.WallDecorations
  Scenario: the corkboard carries the Colonists' Deco extension for a wall (TESTING.md 9)
    Given the save "test-colony" is loaded
    Then Nelim's Pickle Tools: the def "ucp_corkboard" of type "ThingDef" has the extension "ColonistsDeco.DecoModExtension" with field "decoLocationType" "Wall"

  @requires:ponpeco.PFKidsRoom
  Scenario: patched defs survive a save and reload without error (TESTING.md 6)
    Given the save "test-colony" is loaded
    And Nelim's Pickle Tools: the error log is marked
    And I save and reload
    And I wait 120 ticks
    Then Nelim's Pickle Tools: no error was logged since the error log was marked

  @requires:DSP.LUN
  Scenario: a diner object carries the clutter tags (TESTING.md 7)
    Given the save "test-colony" is loaded
    Then Nelim's Pickle Tools: the def "DS_BurgerA" of type "ThingDef" has "SEX_Clutter" in the list "building.buildingTags"
    And Nelim's Pickle Tools: the def "DS_BurgerA" of type "ThingDef" has "SEX_DiningRoomClutter" in the list "building.buildingTags"

  @requires:DSP.LUN
  Scenario: the diner objects are gone from the Furniture tab (TESTING.md 10)
    Given the save "test-colony" is loaded
    Then Nelim's Pickle Tools: the architect tab "Furniture" does not list the def "DS_BurgerA"

  @requires:ucp.WallDecorations
  Scenario: the corkboard carries the decoration comp (TESTING.md 9)
    Given the save "test-colony" is loaded
    Then Nelim's Pickle Tools: the def "ucp_corkboard" of type "ThingDef" has the comp "ColonistsDeco.CompProperties_Decoration"

  @requires:ponpeco.PFKidsRoom
  Scenario: the ball carries the clutter tag (diagnostic for TESTING.md 8)
    Given the save "test-colony" is loaded
    Then Nelim's Pickle Tools: the def "PFK_Ball" of type "ThingDef" has "SEX_Clutter" in the list "building.buildingTags"

  @requires:ponpeco.PFKidsRoom
  Scenario: the cushion carries the clutter tag (diagnostic for TESTING.md 8)
    Given the save "test-colony" is loaded
    Then Nelim's Pickle Tools: the def "PFK_Cushion" of type "ThingDef" has "SEX_Clutter" in the list "building.buildingTags"

  @requires:lunartika.OS
  Scenario: an office object carries the clutter tag (diagnostic)
    Given the save "test-colony" is loaded
    Then Nelim's Pickle Tools: the def "OS_Magnifier" of type "ThingDef" has "SEX_Clutter" in the list "building.buildingTags"

  @requires:ponpeco.PFKidsRoom
  Scenario: where the ball def comes from (diagnostic)
    Given the save "test-colony" is loaded
    Then Nelim's Pickle Tools: def "PFK_Ball" of type "ThingDef" field "modContentPack.PackageId" is "x"
    And Nelim's Pickle Tools: def "PFK_Ball" of type "ThingDef" field "building.isEdifice" is "x"
    And Nelim's Pickle Tools: def "PFK_Ball" of type "ThingDef" field "label" is "x"
    And Nelim's Pickle Tools: def "PFK_Ball" of type "ThingDef" field "description" is "x"

  @requires:ponpeco.PFKidsRoom
  Scenario: probe label of PFK_Ball
    Given the save "test-colony" is loaded
    Then Nelim's Pickle Tools: def "PFK_Ball" of type "ThingDef" field "label" is "PROBE"

  @requires:lunartika.OS
  Scenario: probe label of OS_Magnifier
    Given the save "test-colony" is loaded
    Then Nelim's Pickle Tools: def "OS_Magnifier" of type "ThingDef" field "label" is "PROBE"

  @requires:ucp.WallDecorations
  Scenario: probe label of ucp_corkboard
    Given the save "test-colony" is loaded
    Then Nelim's Pickle Tools: def "ucp_corkboard" of type "ThingDef" field "label" is "PROBE"
