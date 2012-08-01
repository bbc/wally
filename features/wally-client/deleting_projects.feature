Feature: Deleting projects

Background:
  Given wally-client is configured with the url of an accessible Wally server

Scenario: Successfully delete a project
  Given project "foo" exists
  When I successfully run `bundle exec wally-client remove_project foo`
  Then there is no project named "foo"
