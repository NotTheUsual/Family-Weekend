Feature: Photos

  Scenario: When not logged in
    Given I am not logged in
    When I click on 'Photos' in the menu
    Then I should be on the login page

  Scenario: When logged in
    Given I am logged in
    When I click on 'Photos' in the menu
    Then I should be on the photos page

  Scenario: When logging in
    Given I am not logged in
    And I click on 'Photos' in the menu
    When I log in
    Then I should be on the photos page

  Scenario: Viewing photos in order
    Given there are photos uploaded
    And I am logged in
    When I visit the photos page
    Then I should see in the following order:
      | 2012 |
      | 2011 |

  Scenario: Starting the upload process
    Given I am logged in
    And I am on the photos page
    When I click "Upload Photo"
    Then I should be on the new photo page

  Scenario: Uploading a photo
    Given I am logged in
    And I am on the new photo page
    When I upload a photo
    Then I should be on the photos page
    And I should see that photo

  Scenario: Looking for the upload button when not an admin
    Given I am logged in as a regular user
    When I am on the photos page
    Then I should not be able to upload photos

  Scenario: Trying to upload a photo as a non-admin user
    Given I am logged in as a regular user
    When I visit the new photo page
    Then I should be on the login page

  Scenario: Trying to upload a photo when not logged in
    Given I am not logged in
    When I visit the new photo page
    Then I should be on the login page

  Scenario: Trying to view a photo when not logged in
    Given there are photos uploaded
    When I visit a photo page
    Then I should be on the login page