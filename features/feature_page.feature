Feature: Feature Page
  In order to view a feature and its intent
  As a stakeholder
  I want a page that displays the feature's name,
       free-form narrative and scenario titles

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

  Scenario: View Scenario Tags - Feature Page
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature

    @tag1 @tag2
    Scenario: Sample Aidy
     """
    When I visit the sample feature page
    Then I should see "tag1"
    And I should see "tag2"

