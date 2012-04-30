Feature: Progress Bar
  In order to see the state of the project
  As a stakeholder
  I want a visual representation of counted tags

  Scenario: Progress Bar
    Given a feature file on the project "project_name" with the contents:
    """
    Feature: Mixed

    @wip
    Scenario: WiP

    @notstarted
    Scenario: Not Started
    """
    When I visit the project page for "project_name" 
    And I select "Progress"
    Then I see "This project has 2 scenarios"
    And I see "@wip (50%)"
    And I see "@notstarted (50%)"
