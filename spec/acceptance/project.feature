Feature: Project

  @user
  Scenario: Creating a project
    Given I am on the root page
    When I enter the project data
    Then I see a success notification
    When I enter my user data
    And I log in
    Then I should see the text "There is no current sprint"

