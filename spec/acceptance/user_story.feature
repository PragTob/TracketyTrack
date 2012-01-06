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

