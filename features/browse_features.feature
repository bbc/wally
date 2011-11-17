Feature: Browse Features
  In order to simply view project requirements
  As a stakeholder
  I want a web based feature viewer and navigator
  
  Scenario: Link to Features
    Given a feature file with the contents:
    """
    Feature: Sample Feature
    """
    When I visit the features page
    Then I should see a link to my sample feature

  Scenario: Feature Content
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature
      In order to get some value
      As a person
      I want to create value
     """
    When I visit the sample feature page
    Then I should see the feature free-form narrative
   

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

  Scenario: View Scenario Content and Background
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature

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
    And click on a scenario header link
    Then a page appears with the scenario content


  Scenario: View Scenario Content and Background
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature

    Background:
      Given some things

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
    And click on a scenario header link
    Then a page appears with the scenario content
    And the background is also visible


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


  Scenario Outline: Search Feature
    Given I am on the search page
    And a feature file named "sample.feature" with the contents:
    """
    @QA
    Feature: Sample Feature
    """
    When I search for "<query>"
    Then I should see a link to "<feature name>" with the url "<url>"

    Examples:
      | query        | feature name   | url                      |
      | Sample       | Sample Feature |/features/sample.feature  |
      | sAmPlE       | Sample Feature |/features/sample.feature  |
      | @QA          | Sample Feature |/features/sample.feature  |
