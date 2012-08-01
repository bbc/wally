Feature: Creating projects
  
Background:
  Given wally-client is configured with the url of an accessible Wally server

@announce
Scenario: Successfully add a new project
  Given there is no project named "foo"
  When I successfully run `bundle exec wally-client add_project foo`
  Then there should be an empty project named "foo"

Scenario: Attempt to create project that already exists
  Given project "foo" exists
  When I attempt to add a project named "foo" using wally-client
  Then it should fail with:
  """
  "foo" already exists
  """