Feature: Readme pages
  
  Documentation at the theme/directory level
  
  Markdown readme files are rendered as HTML 
 
  Background:
    Given wally-client is configured with the url of an accessible Wally server
    And project "foo" exists
 
  Scenario: Topic with readme.md
    Given a directory named "features" with the following feature files
      | Path                                     | Name                        |
      | wally-client/push_features.feature       | Push project features       |
    And a file "features/wally-client/readme.md" with the following content:
    """
    # The wally-client gem
    """
    When I push features from "features" to project "foo"
    And I visit the project page for "foo"
    And I follow "Wally-client"
    Then I see a HTML page heading with "The wally-client gem"
  