Feature: View Feature
  In order to better understand a feature
  As a stakeholder
  I want to view feature file content

  Scenario: Feature Name
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature
    """
    When I visit the sample feature page
    Then I should see "Sample Feature"
