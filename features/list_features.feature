Feature: List Features
  In order to view and navigate to Features
  As a project stakeholder
  I want a list of Cucumber feature files

  Scenario: Link to Features
    Given a feature file with the contents: 
    """
    Feature: Sample Feature
    """
    When I visit the features page
    Then I should see a link to my sample feature

