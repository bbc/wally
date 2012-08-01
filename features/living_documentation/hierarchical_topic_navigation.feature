Feature: Hierarchical "topic" navigation

Wally aggregates features and markdown documentation and lets
you navigate them hierarchically.
  
Background:
  Given wally-client is configured with the url of an accessible Wally server
  And project "foo" exists
  
Scenario: Navigate topic hierarchy
  Note: Topics are listed alphabetically by default
  
  Given I push the following features to project "foo"
    | Path          | Name              |
    | foo/a.feature | Feature A         |
    | foo/b.feature | Feature B         |
    | c.feature     | Feature C         |
  And I visit the project page for "foo"
  Then I see the following listed in order in the project sidebar
    | Feature C |
    | Foo       |
  When I follow "Foo" in the project sidebar
  Then I see the topic page for "Foo"
  And I see the following sub-topics listed in order
    | Feature A |
    | Feature B |
  When I navigate into the "Feature A" sub-topic
  Then I see the feature page for "Feature A"

@comming-soon
Scenario: Topic order can be changed using a .nav file

@comming-soon
Scenario: Topic names can be customized using a .nav file
  
 
  
  
  




  