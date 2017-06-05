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
    And I see "tag1"
    And I see "tag2"

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
    Then I see "work_in_progress"

  Scenario: Data Table
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature

      Scenario: Data Table
        Given the following people exist:
          | name   | email            |
          | Aidy   | aidy@example.com |
          | Andrew | vos@example.com  |
    """
    When I visit the sample feature page
    And click on a scenario header link
    Then I see the data table

  Scenario: Single cell data table
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature

      Scenario: Data Table
        Given the following names:
          | Aidy   |
          | Andrew |
    """
    When I visit the sample feature page
    And click on a scenario header link
    Then I see the data table as a list
    
  Scenario: Scenario Outline
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature

      Scenario Outline: Outline with examples
        Given there are <start> cucumbers
        When I eat <eat> cucumbers
        Then I have <left> cucumbers

        Examples:
          | start | eat | left |
          |  12   |  5  |  7   |
          |  20   |  5  |  15  |
    """
    When I visit the sample feature page
    And click on a scenario header link
    Then I see the examples table

  Scenario: Scenario description
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample feature

      Scenario: Scenario with description
         Note: Something special
         
         Given something
     """
    When I visit the "Scenario with description" from "Sample feature"
    Then I see "Note: Something special"
 
  Scenario: Doc strings
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample feature

      Scenario: Doc string
        Given the following:
        \"\"\"
        contents of scenario docstring
        \"\"\"
    """
    When I visit the "Doc string" from "Sample feature"
    Then I see "contents of scenario docstring"
    