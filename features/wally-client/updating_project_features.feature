Feature: Upload/push project features and documentation

Background:
  Given wally-client is configured with the url of an accessible Wally server

  Scenario: Push features to an existing project
  Given project "foo" exists
  And a directory "features" containing features
  When I successfully run `bundle exec wally-client push foo features`
  Then there should be features in project "foo"

Scenario: Attempt to push features to a non-existent project
  Given there is no project named "foo"
  When I attempt to push features to project "foo" using wally-client
  Then it should fail with:
  """
  Unknown project "foo"
  """
    
  
  