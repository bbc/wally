Feature: Push Features To Server
  In order to easily get features on the server
  As a developer
  I want to be able to push features to an endpoint

  Scenario: Push features without authentication
    Given I don't have a .wally authorisation file
    When I put data to /my_project_name/features with the authentication code
    Then I get a 403 http status

  Scenario: Push features with authentication
    Given I have a .wally authentication file
    When I put data to /my_project_name/features with the authentication code
    Then I get a 201 http status

  Scenario: Pushed features show up on home page
    Given I have a .wally authentication file
    When I put data to /my_project_name/features with the authentication code
    And I visit "my_project_name" page
    Then I see the uploaded feature

  Scenario: Delete projects without authorisation
    Given I don't have a .wally authorisation file
    And I create a project called "project1"
    When I send DELETE to "/projects/project1"
    Then "project1" should exist
    And I get a 403 http status

  Scenario: Delete projects with authorisation
    Given I have a .wally authentication file
    And I create a project called "project1"
    When I send DELETE to "/projects/project1"
    Then "project1" should not exist
    And I get a 201 http status
