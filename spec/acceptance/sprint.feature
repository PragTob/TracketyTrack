Feature: Sprint
  Background:
    Given I am logged in
    And there is a project

  Scenario: Start a sprint
    When I start a sprint on the current sprint page
    Then I see a success notification

