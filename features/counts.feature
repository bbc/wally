Feature: Counts
  In order to understand the size of the project
  As a stakeholder
  I want a visual indication of the number of tags, scenarios and features

  Background:
    Given a feature file named "sample.feature" with the contents:
    """
    @tag1
    Feature: Tag Feature

    @tag2 @multiple
    Scenario: Tag Foo 1

    @tag3 @multiple
    Scenario: Tag Bar 2
    """

  Scenario: Features
    When I visit the project page
    Then I should see "Features (1)"

  Scenario: Tags
    When I visit the project page
    Then I should see "Tags (5)"
