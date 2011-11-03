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
     Scenario: Sample Scenario 2
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
    Then I should see "Scenario: Sample Scenario 2"
