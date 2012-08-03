Feature: Hierarchical "topic" navigation

  So that feature organization is not lost, 
  Wally maintains the hierarchical structure of your features.
  
Background:
  Given project "foo" exists
  
Scenario: Navigate topic hierarchy
  Note: Topics are listed alphabetically by default
  
  Given I push the following features to project "foo"
    | Path          | Name              |
    | some_theme/a.feature | Feature A         |
    | some_theme/b.feature | Feature B         |
    | c.feature     | Feature C         |
  And I visit the project page for "foo"
  Then I see the following listed in order in the project sidebar
    | Feature C  |
    | Some theme |
  When I follow "Some theme" in the project sidebar
  Then I see the following sub-topics listed in order
    | Feature A |
    | Feature B |
  When I navigate into the "Feature A" sub-topic
  Then I see the feature page for "Feature A"

 
  
  
  




  