Feature: Testing states

  @javascript
  Scenario: Without arguments, it prints a list of all its steps
    Given I have all the test data for state testing
    And I am on the home page
    Then I should see "Log in"
    When I fill in "user_email" with "admin@test.com"
    And I fill in "user_password" with "123456"
    And I press "Log in"
    Then I should see "Admin Testing" within ".menu"
    Then I should not see "designed" within ".panel"
    When I follow "States" within ".panel .tabs"
    Then I should see "designed" within ".panel"
