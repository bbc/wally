Feature: Search features
  In order to have fast access to features and scenarios
  As a stakeholder
  I want to be able to search features

  Scenario Outline: Search feature name
    Given a feature file named "sample.feature" with the contents:
    """
    @QA
    Feature: Sample Feature
    """
    And I am on the search page
    When I search for "<query>"
    Then I should see a search result link to "<feature name>" with the url "<url>"

    Examples:
      | query        | feature name   | url                      |
      | Sample       | Sample Feature |/features/sample-feature  |
      | sAmPlE       | Sample Feature |/features/sample-feature  |
      | @QA          | Sample Feature |/features/sample-feature  |

  Scenario: Search feature narrative
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature
      In order to bla bla bla
      As donkey
      I want ermm I dunno.
    """
    And I am on the search page
    When I search for "donkey"
    Then I should see a search result link to "Sample Feature" with the url "/features/sample-feature"

  Scenario: Search scenario name
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature
    Scenario: Sample Scenario
    """
    And I am on the search page
    When I search for "Sample Scenario"
    Then I should see a search result link to "Sample Scenario" with the url "/features/sample-feature/scenario/sample-scenario"

  Scenario: Search scenario steps
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature
    Scenario: Sample Scenario
      Given I do something
    """
    And I am on the search page
    When I search for "I do something"
    Then I should see a search result link to "Sample Scenario" with the url "/features/sample-feature/scenario/sample-scenario"

  Scenario: Search suggests other searches
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Batman
    """
    And I am on the search page
    When I search for "btman"
    Then I should see "Did you mean"
    And I should see a search result link to "Batman" with the url "/search?q=Batman"
