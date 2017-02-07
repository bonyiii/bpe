Feature: Testing states

  @javascript
  Scenario: Without arguments, it prints a list of all its steps
    Given I am on the home page
    Then I should see "Log in"
