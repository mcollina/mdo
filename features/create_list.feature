Feature: Create List
  In order to organize my work
  As a User
  I want to create a todo list

  Scenario: Create a todo list
    Given I have no lists
    When I add the list "first"
    Then I should see "Created a new list named 'first'."

  Scenario: Impossible to create a duplicate list
    Given I have the "first" list
    When I add the list "first"
    Then I should see "There is already a list named 'first'."

  Scenario: Impossible to create an empty list
    Given I have no lists
    When I add the list ""
    Then I should see "Impossible to add a list with blank name."

  Scenario: Create two todo list
    Given I have the "first" list
    When I add the list "second"
    Then I should see "Created a new list named 'second'."
