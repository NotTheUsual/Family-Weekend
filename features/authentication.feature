Feature: Authentication
  
  Scenario: From the login page
    Given there are established login details
    When I am on the login page
    And I enter the correct details
    Then I should be signed in