Feature: Projects
  In order to allow multiple projects
  As a user
  I want to be able to switch between projects

  Scenario: Single project
    Given a feature file on the project "project_name" with the contents:
    """
    Feature: Projects
    """
    And I visit the project page for "project_name"
    Then I see a link to the feature "Projects"

  @javascript
  Scenario: Switch between projects
    Given 2 projects exist
    When I view the welcome page
    Then I can switch to the 2nd project
    And I can switch to the 1st project
