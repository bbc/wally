Feature: Welcome Page
  As a stakeholder
  I want a welcome page

  Scenario: No projects
    Given there aren't any projects
    When I view the welcome page
    Then I see the wally README

  @javascript
  Scenario: Project links on home page
    Given a feature file on the project "sample1" with the contents:
    """
    Feature: Sample1
    """
    And a feature file on the project "sample2" with the contents:
    """
    Feature: Sample2
    """
    When I view the welcome page
    And I select the project "sample2"
    Then I am redirected to the "sample2" project page

  Scenario: Redirect to first project
    Given a feature file on the project "sample1" with the contents:
    """
    Feature: Sample1
    """
    When I view the welcome page
    Then I am redirected to the "sample1" project page
