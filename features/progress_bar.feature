@wip
Feature: Progress Bar
  In order to gauge the state of the project
  As a stakeholder
  I want a visual representation of counted tags

  Scenario: Progress bar
    Given a feature file on the project "project_name" with the contents:
    """
    @wip
    Feature: Wip feature

    @wip
    Scenario: Wip scenario 

    """
    And a feature file named "not_started.feature" with the contents:
    """
    @notstarted
    Feature: Not started feature
    
    @notstarted
    Scenario: Not started scenario
    """
    And a feature file named "qa.feature" with the contents:
    """
    @qa
    Feature: QA feature
    """
    When I visit the project page
    And I select "Progress"
    Then a total tag count is displayed


