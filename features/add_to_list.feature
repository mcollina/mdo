Feature: Add to list
  In order to organize my work
  As a User
  I want to add elements to todo lists

  Scenario: Add an element to a todo list
    Given I have the "first" list
    When I add the "hello" element to the "first" list
    Then I should see "1: hello."

  Scenario: Impossible to add an empty element to a todo list
    Given I have the "first" list
    When I add the "" element to the "first" list
    Then I should see "Impossible to add a blank element to the 'first' list."

  Scenario: Add three elements in a todo list
    Given I have the "three-elements-list" list
    When I add the "first" element to the "three-elements-list" list
    And I add the "second" element to the "three-elements-list" list
    And I add the "third" element to the "three-elements-list" list
    Then I should see "1: first."
    And I should see "2: second."
    And I should see "3: third."

  Scenario: Automatically create the list if doesn't exists
    Given I have no lists
    When I add the "first" element to the "new-list" list
    Then I should see "Created a new list named 'new-list'."
    And I should see "1: first."

  Scenario: Impossible to automatically create the list if doesn't exists 
    Given I have no lists
    When I add the "first" element to the "" list
    Then I should see "Impossible to add a list with blank name."

  Scenario: Add a multi word element
    Given I have the "first" list
    When I add the "hello world" element to the "first" list
    Then I should see "1: hello world."
