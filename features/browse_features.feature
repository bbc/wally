Feature: Temp
  In order ....
  As a ...
  I want to ...

  Scenario: View Scenario Content
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature

    @tag1 @tag2
    Scenario: Sample Aidy
      Given my name is "Aidy"
      When I drink alcohol
      Then I go nuts
     """
    When I visit the sample feature page
    And click on a scenario header link
    Then a page appears with the scenario content
    And I should see "tag1"
    And I should see "tag2"

  Scenario: View Scenario Tags On Scenario Page
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature

    @tag1 @tag2
    Scenario: Sample Aidy
     """
    When I visit the sample feature page
    Then I should see "tag1"
    And I should see "tag2"

  Scenario: View Scenario Background
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature

    Background:
      Given some things

    Scenario: Sample Aidy
     """
    When I visit the sample feature page
    And click on a scenario header link
    Then the background is visible

  Scenario: View Scenario Tags
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature

    Background:
      Given some things

    @work_in_progress
    Scenario: Sample Aidy
     """
    When I visit the sample feature page
    And click on a scenario header link
    Then I should see "work_in_progress"

  Scenario: Sort Scenario Links in Alphabetical Order
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature
      Scenario: V
      Scenario: C
      Scenario: I
      Scenario: N
     """
    When I visit the sample feature page
    Then the scenario links are sorted


  Scenario: View Scenario Links
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature
      In order to get some value
      As a person
      I want to create value

    Scenario: Sample Aidy
      Given my name is "Aidy"
      When I drink alcohol
      Then I go nuts

    Scenario: Sample Andrew
      Given my name is 'Andrew'
      When I drink alcohol
      Then I go happy
     """
    When I visit the sample feature page
    Then I should see Scenario headers as links

