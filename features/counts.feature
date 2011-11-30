Feature: Counts
  In order to understand the size of the project
  As a stakeholder
  I want a visual indication of the number of tags, scenarios and features

  Scenario: Tags, scenarios, and features count
    Given a feature file named "sample.feature" with the contents:
    """
    @tag1
    Feature: Tag Feature
    @tag2 @multiple
    Scenario: Tag Foo 1
    @tag3 @multiple
    Scenario: Tag Bar 2
    """
    When I visit the home page
    Then I should see a heading "Features (1)"
    And I should see a heading "Tags (5)"
