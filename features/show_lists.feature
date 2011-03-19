Feature: Show List
  As a User
  In order to discover what I have to do
  I want to show what todo-list I have

  Scenario: Show 0 lists
    Given I have no lists
    When I show the lists
    Then I should see "There are no lists."

  Scenario: Show 1 list
    Given I have the "first" list
    When I show the lists
    Then I should see "1: first."

  Scenario: Show 2 list
    Given I have the "first" list
    And I have the "second" list
    When I show the lists
    Then I should see "1: first."
    And I should see "2: second."
