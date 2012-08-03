Feature: Customizing topic navigation with .nav file

  So that features can serve as good documentation,
  ordering can be customized by including a .nav file
  at the top of your features directory. Display names
  can be customized as well.
 
Background:
  Given wally-client is configured with the url of an accessible Wally server
  And project "foo" exists
    
Scenario: Customize order and topic names
  Given a directory named "features" with the following feature files
    | Path                                                  | Name                        |
    | wizard_submission/starting_a_submission.feature       | Starting a new submission   |
    | wizard_submission/entering_author_information.feature | Entering author information |
    | wizard_submission/manage_files.feature                | Manage submission files     |
    | wizard_submission/confirm_entered_information.feature | Confirm entered information |
  And a file "features/.nav" with the following content:
  """
  - wizard_submission (Wizard submission process):
    - starting_a_submission.feature
    - entering_author_information.feature
    - manage_files.feature
    - confirm_entered_information.feature
  """
  When I push features from "features" to project "foo"
  And I visit the project page for "foo"
  Then I see a "Wizard submission process" link
  When I follow "Wizard submission process"
  Then I see the following sub-topics listed in order
    | Starting a new submission   |
    | Entering author information |
    | Manage submission files     |
    | Confirm entered information |
    
    