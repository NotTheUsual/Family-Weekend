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

  Scenario: Reviewing news posts
    Given I am logged in
    And there are news posts in the database
    When I visit the manage posts page
    Then I should see all the posts
    And I should see links to view and edit all the posts

  Scenario: Editing a news post
    Given I am logged in
    And there are news posts in the database
    And I visit the manage posts page
    When I click on a post
    Then I should be able to edit that post

  Scenario: Actually editing a post
    Given I am logged in
    And there are news posts in the database
    And I am on the edit post page
    When I edit the post
    Then I should see my edited post

  Scenario: Trying to edit a post when logged out
    Given I am not logged in
    When I visit the edit post page
    Then I should be on the login page

  Scenario: Trying to add a new post as a non-admin user
    Given I am logged in as a regular user
    When I visit the edit post page
    Then I should be on the login page

  Scenario: Viewing posts
    Given I am logged in
    And there are news posts in the database
    When I click on the news menu link
    Then I should be on the news page
    And I should see all the news items

