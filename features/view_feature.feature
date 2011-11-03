Feature: View Feature
  In order to better understand a feature
  As a stakeholder
  I want to view feature file content

  Background:
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature
      In order to get some value
      As a person
      I want to create value

     Scenario: Sample Scenario 1
     Given I am Aidy
     When I go for a drink
     Then I go nuts
     Scenario: Sample Scenario 2
     Given I am Andrew
     When I go for a drink
     Then I go more nuts
     """
    When I visit the sample feature page

  Scenario: Feature Name
    Then I should see "Feature: Sample Feature"

  Scenario: Feature Description
    Then I should see "In order to get some value"
    And I should see "As a person"
    And I should see "I want to create value"

  Scenario: Feature Scenario Names
    Then I should see "Scenario: Sample Scenario 1"
    And I should see "Scenario: Sample Scenario 2"

  Scenario: Feature Steps
    Then I should see "Given I am Aidy"
    And I should see "When I go for a drink"
    And I should see "Then I go nuts"
