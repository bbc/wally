Feature: Welcome Page
  In order view a list of projects
  I want a welcome page

  Scenario: No projects
    Given there aren't any projects
    When I view the welcome page
    Then I see: "Welcome to Wally. Please upload some features"

  Scenario: No projects
    Given a feature file on the project "sample1" with the contents:
    """
    Feature: Sample1
    """
    And a feature file on the project "sample2" with the contents:
    """
    Feature: Sample2
    """
    When I view the welcome page
    Then I see a link to the "sample1" project
    And I see a link to the "sample2" project
    And should not see "Welcome to Wally"
