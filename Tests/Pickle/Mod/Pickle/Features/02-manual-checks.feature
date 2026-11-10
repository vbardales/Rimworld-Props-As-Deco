# Def-level part of the manual scenarios of TESTING.md (8, 9, 6). Placement, drawing order and the colonist
# decorating a table stay manual. Scenarios 7 (tags in a list), 9 (comp) and 10 (architect tab) wait for the
# NPT steps announced 2026-11-10 (tag in a list, comp, architect tab lists the def).

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
    When the error log is marked
    And I save and reload
    And I wait 120 ticks
    Then no error was logged since the error log was marked
