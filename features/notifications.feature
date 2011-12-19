Feature: Notifications
  In order to be great developers
  As a developer
  I want to be told off when I have too many bad tags

  Scenario: Ten @wip tags
    Given a feature file with 10 @wip tags
    When I visit the project page
    Then I should see a notification that says "You have 10 @wip tags :("
