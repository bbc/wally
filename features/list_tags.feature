Feature: List Tags
  In order to be informed of all tags
  As a stakeholder
  I want a list of tags to be displayed

  Scenario: Multiple tags
    Given a feature file named "sample.feature" with the contents:
    """
    @tag1
    Feature: Tag Feature
    @tag2 @multiple
    Scenario: Tag Scenario 1
    @tag3 @multiple
    Scenario: Tag Scenario 2
    """
    When I visit the home page
    Then I should see a link to "@tag1 (1)" with the url "/project/search?q=@tag1"
    And I should see a link to "@tag2 (1)" with the url "/project/search?q=@tag2"
    And I should see a link to "@tag3 (1)" with the url "/project/search?q=@tag3"
    And I should see a link to "@multiple (2)" with the url "/project/search?q=@multiple"
