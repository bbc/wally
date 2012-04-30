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
    When I visit the project page
    Then I see a link to "@tag1 (1)" with the url "/projects/project/search?q=@tag1"
    And I see a link to "@tag2 (1)" with the url "/projects/project/search?q=@tag2"
    And I see a link to "@tag3 (1)" with the url "/projects/project/search?q=@tag3"
    And I see a link to "@multiple (2)" with the url "/projects/project/search?q=@multiple"

    Scenario: Coloured tags
      Given a feature file named "sample.feature" with the contents:
      """
      @tag1
      Feature: Tag Feature
      @tag2 @tag3
      Scenario: Tag Scenario 1
      """
      When I visit the project page
      Then I see each tag has an individual colour
