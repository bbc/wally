Feature: Scenario Page
  In order to view a scenario's intent
  As a stakeholder
  I want a page that displays each scenario and its steps

  Scenario: Content
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature

    @tag1 @tag2
    Scenario: Sample Aidy
      Given my name is "Aidy"
      When I drink alcohol
      Then I go nuts
     """
    When I visit the sample feature page
    And click on a scenario header link
    Then a page appears with the scenario content
    And I should see "tag1"
    And I should see "tag2"

  Scenario: Background
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature

    Background:
      Given some things

    Scenario: Sample Aidy
     """
    When I visit the sample feature page
    And click on a scenario header link
    Then the background is visible

  Scenario: Tags
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature

    Background:
      Given some things

    @work_in_progress
    Scenario: Sample Aidy
     """
    When I visit the sample feature page
    And click on a scenario header link
    Then I should see "work_in_progress"
