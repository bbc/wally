Feature: Search Features
  In order to quickly find features
  As a stakeholder
  I want search functionality

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
 
