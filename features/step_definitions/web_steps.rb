require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given(/^I am on (.+)$/) do |page_name|
  visit path_to(page_name)
end

Given(/^there are established login details$/) do
  User.create(name: "admin", password: "s3cr3t")
end

Given(/^I am logged in$/) do
  User.create(name: "admin", password: "s3cr3t")
  visit path_to('the login page')
  fill_in 'name', with: "admin"
  fill_in 'password', with: "s3cr3t"
  click_button 'Sign In'
end

Given(/^I am not logged in$/) do
  visit path_to('the homepage')
end

When(/^I enter the correct details$/) do
  fill_in 'name', with: "admin"
  fill_in 'password', with: "s3cr3t"
  click_button 'Sign In'
end

When(/^I click 'Sign Out'$/) do
  click_button 'Sign Out'
end

When(/^I click on 'Photos' in the menu$/) do
  click_link 'Photos'
end

When(/^I log in$/) do
  User.create(name: "admin", password: "s3cr3t")
  fill_in 'name', with: "admin"
  fill_in 'password', with: "s3cr3t"
  click_button 'Sign In'
end

Then(/^I should see the content for that page$/) do
  expect(page).to have_content("Welcome to the Stern family weekend website, where you’ll find information about this year’s family weekend, and pictures of previous years.
                                For any newcomers who might be interested we’ve included the story to date, and for those who consider themselves old-timers test yourselves by seeing if you can write out the list of where we were when before you check the history page (it took three of our finest minds for us to manage it).
                                Please send us any news and photos to add and we will put them up.")
end

Then(/^I should be signed in$/) do
  expect(page).to have_content('Signed in')
end

Then(/^I should be signed out$/) do
  expect(page).not_to have_content('Signed in')
  expect(page).to have_content('Stern Family Weekend')
end

Then(/^I should be on (.+)$/) do |page_name|
  current_path = URI.parse(current_url).path
  expect(current_path).to eq(path_to(page_name))
end