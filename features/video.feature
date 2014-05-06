Feature: FW Video
  
  Scenario: When logged out
    Given I am not logged in
    When I visit the video page
    Then I should be on the login page

  Scenario: When logged in
    Given I am logged in
    When I visit the video page
    Then I should be on the video page
    And I should see the video and its description