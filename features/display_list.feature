Feature: Display a List
  
  In order to organize my work
  As a User
  I want to add elements to todo lists

  Scenario: Display an empty list
    Given I have the "first" list
    When I ask for the "first" list elements
    Then I should see "There are no elements."

  Scenario: Display a list with 1 element
    Given I have the "first" list
    And I add the "hello" element to the "first" list
    When I ask for the "first" list elements
    Then I should see "1: hello."

  Scenario: Display a list with 2 element
    Given I have the "first" list
    And I add the "hello" element to the "first" list
    And I add the "hello2" element to the "first" list
    When I ask for the "first" list elements
    Then I should see "2: hello2."

  Scenario: Display a non-existent list
    Given I have no lists
    When I ask for the "first" list elements
    Then I should see "Created a new list named 'first'."
    And I should see "There are no elements."
