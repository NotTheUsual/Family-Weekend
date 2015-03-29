Feature: News Posts

  Scenario: Manually adding a new post
    Given I am logged in
    And I am on the new post page
    When I enter my new post
    And I press 'Accept'
    Then I should see my new post

  Scenario: Trying to add a new post when logged out
    Given I am not logged in
    When I visit the new post page
    Then I should be on the login page

  Scenario: Trying to add a new post as a non-admin user
    Given I am logged in as a regular user
    When I visit the new post page
    Then I should be on the login page

#  Scenario: Reviewing news posts
#    Given I am logged in
#    And there are news posts in the database
#    When I visit the manage posts page
#    Then I should see all the posts
#    And I should see links to view and edit all the posts