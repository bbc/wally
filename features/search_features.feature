Feature: Search Features
  In order to quickly find features
  As a stakeholder
  I want search functionality

  Scenario: Search Feature
    Given I am on the search page
    And a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature
    """ 
    When I search for "Sample"
    Then I should see a link to "Sample Feature" with the url "/features/sample.feature"
