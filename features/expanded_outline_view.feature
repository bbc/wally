Feature: Expanded outline view
  
  The expanded outline view shows all features and scenarios
  at once so stakeholders can get a overview of all features.

Background:
    Given project "foo" exists

Scenario: View expanded outline
  Given a feature file "theme/first.feature" in project "foo" with the contents:
    """
    Feature: Feature one 
    Scenario: Feature one scenario one
    Scenario: Feature one scenario two
    """
  And a feature file "theme/second.feature" in project "foo" with the contents:
    """
    Feature: Feature two
    Scenario: Feature two scenario one
    """
  And a feature file "another_theme/third.feature" in project "foo" with the contents:
    """
    Feature: Feature three
    Scenario: Feature three scenario one
    """   
  When I visit the project page for "foo"
  And I follow "Expanded outline" 
  Then I see the following outline:
    """
    * Theme
    ** Feature one
    *** Feature one scenario one
    *** Feature one scenario two
    ** Feature two
    *** Feature two scenario one
    * Another theme
    ** Feature three
    *** Feature three scenario one
    """
    