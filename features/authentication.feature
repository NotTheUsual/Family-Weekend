Feature: Authentication
  
  Scenario: From the login page
    Given there are established login details
    When I am on the login page
    And I enter the correct details
    Then I should be signed in

  Scenario: Signing Out
    Given I am logged in
    And I am on the homepage
    When I click 'Sign Out'
    Then I should be signed out