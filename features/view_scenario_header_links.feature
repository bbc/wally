Feature: View Scenario Header Links
  In order to qicklkly view the Scenario intent
  As a stakeholder
  I want to view Scenario headers as hyperlinks

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
