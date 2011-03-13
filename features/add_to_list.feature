Feature: Add to list
  In order to organize my work
  As a User
  I want to add elements to todo lists

  Scenario: Add an element to a todo list
    Given I have the "first" list
    When I add the "hello" element to the "first" list
    Then I should see "Added the 'hello' element to the 'first' list in position 1."

  Scenario: Impossible to add an empty element to a todo list
    Given I have the "first" list
    When I add the "" element to the "first" list
    Then I should see "Impossible to add a blank element to the 'first' list."

  Scenario: Add three elements in a todo list
    Given I have the "three-elements-list" list
    When I add the "first" element to the "three-elements-list" list
    When I add the "second" element to the "three-elements-list" list
    When I add the "third" element to the "three-elements-list" list
    Then I should see "Added the 'first' element to the 'three-elements-list' list in position 1."
    Then I should see "Added the 'second' element to the 'three-elements-list' list in position 2."
    Then I should see "Added the 'third' element to the 'three-elements-list' list in position 3."

  Scenario: Impossible to add an element to an empty list
    Given I have no lists
    When I add the "first" element to the "" list
    Then I should see "There is no '' list."

  Scenario: Impossible to add an element to a non-existent list
    Given I have no lists
    When I add the "first" element to the "what-a-list" list
    Then I should see "There is no 'what-a-list' list."
