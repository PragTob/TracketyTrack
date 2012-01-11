Feature: User stories
  Background:
    Given I am logged in
    And there is a project

  Scenario: User story list
    Given there is a user story
    When I am on the current sprint page
    And I click on "User Stories"
    Then I should see the name of the user story

  Scenario: Creating a user story
    Given I create a new user story
    Then I see a success notification
    And I see this user story in the user story overview

  Scenario: Adding a comment
    Given there is a user story
    And I am on the page of the user story
    When I add a comment
    Then the comment is displayed on the user story page

  @javascript
  Scenario: Deleting a comment
    Given there is a commented user story
    And I am on the page of the user story
    When I delete the comment
    Then the comment is not displayed on the user story page

  Scenario: Editing a user story
    Given there is a user story
    When I edit the name of the user story
    Then I see the changed name

