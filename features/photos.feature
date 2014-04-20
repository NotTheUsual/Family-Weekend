Feature: Photos

  Scenario: When not logged in
    Given I am not logged in
    When I click on 'Photos' in the menu
    Then I should be on the login page

  Scenario: When logged in
    Given I am logged in
    When I click on 'Photos' in the menu
    Then I should be on the photos page