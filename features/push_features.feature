Feature: Push Features To Server
  In order to easily get features on the server
  As a developer
  I want to be able to push features to an endpoint

  Scenario: Push features without authentication
    Given I don't have a .wally authorisation file
    When I put data to /project/features with the authentication code
    Then I should get a 403 http status

  Scenario: Push features with authentication
    Given I have a .wally authentication file
    When I put data to /project/features with the authentication code
    Then I should get a 201 http status

  Scenario: Pushed features show up on home page
    Given I have a .wally authentication file
    When I put data to /project/features with the authentication code
    And I visit the home page
    Then I should see the uploaded feature
