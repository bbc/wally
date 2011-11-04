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

     Background: 
      Given I have a background

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


  Scenario: Feature Content
    Then I should see the feature file content






