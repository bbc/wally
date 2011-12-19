Feature: Home Page
  In order to simply view a project's complete story set
  As a stakeholder
  I want a home page that displays all features

  Scenario: Links to features in alphabetical order
    Given a feature file named "kate_moss.feature" with the contents:
    """
    Feature: Kate Moss
    """
    Given a feature file named "katie_price.feature" with the contents:
    """
    Feature: Katie Price
    """
    Given a feature file named "jessica_jane_clement.feature" with the contents:
    """
    Feature: Jessica-Jane Clement
    """
    Given a feature file named "elle_macpherson.feature" with the contents:
    """
    Feature: Elle Macpherson
    """
    When I visit the home page
    Then I should see a link to my sample features
    And the features are ordered alphabetically

  Scenario: Display feature tags
    Given a feature file named "sample.feature" with the contents:
    """
    @sample_tag
    Feature: Sample Feature
    """
    When I visit the sample feature page
    Then I should see "sample_tag"
