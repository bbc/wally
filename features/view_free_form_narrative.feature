Feature: View Free-form Narrative
  In order to quickly view a Feature's intent
  As a stakeholder
  I want to view the Feature free-form narrative

  Background:
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature
      In order to get some value
      As a person
      I want to create value
     """
    When I visit the sample feature page

  Scenario: Feature Content
    Then I should see the feature free-form narrative






