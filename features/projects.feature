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
