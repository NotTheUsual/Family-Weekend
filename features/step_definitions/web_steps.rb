require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given(/^I (?:am on|visit) (.+)$/) do |page_name|
  visit path_to(page_name)
end

Given(/^there are established login details$/) do
  User.create(name: "admin", password: "s3cr3t", admin: true)
end

Given(/^I am logged in$/) do
  User.create(name: "admin", password: "s3cr3t", admin: true)
  visit path_to('the login page')
  fill_in 'name', with: "admin"
  fill_in 'password', with: "s3cr3t"
  click_button 'Sign In'
end

Given(/^I am logged in as a regular user$/) do
  User.create(name: "user", password: "s3cr3t", admin: false)
  visit path_to('the login page')
  fill_in 'name', with: "user"
  fill_in 'password', with: "s3cr3t"
  click_button 'Sign In'
end

Given(/^I am not logged in$/) do
  visit path_to('the homepage')
end

Given(/^there are photos uploaded$/) do
  User.create(name: "admin", password: "s3cr3t", admin: true)
  visit path_to('the login page')
  fill_in 'name', with: "admin"
  fill_in 'password', with: "s3cr3t"
  click_button 'Sign In'
  visit '/photos/new'
  attach_file('photo', "#{Dir.pwd}/features/fixtures/2011.jpg")
  fill_in 'year', with: "2011"
  click_button "Upload"
  visit '/photos/new'
  attach_file('photo', "#{Dir.pwd}/features/fixtures/2011.jpg")
  fill_in 'year', with: "2012"
  click_button "Upload"
  click_button 'Sign Out'
end

When(/^I enter the correct details$/) do
  fill_in 'name', with: "admin"
  fill_in 'password', with: "s3cr3t"
  click_button 'Sign In'
end

When(/^I click 'Sign Out'$/) do
  click_button 'Sign Out'
end

When(/^I click "(.*?)"$/) do |link|
  click_link link
end

When(/^I click on 'Photos' in the menu$/) do
  click_link 'Photos'
end

When(/^I log in$/) do
  User.create(name: "admin", password: "s3cr3t", admin: true)
  fill_in 'name', with: "admin"
  fill_in 'password', with: "s3cr3t"
  click_button 'Sign In'
end

When(/^I upload a photo$/) do
  attach_file('photo', "#{Dir.pwd}/features/fixtures/2011.jpg")
  fill_in 'year', with: "2011"
  click_button "Upload"
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

Then(/^I should see that photo$/) do
  expect(page).to have_content('2011')
  expect(page).to have_xpath("//img[contains(@src, '2011.jpg')]")
end

Then(/^I should be on (.+)$/) do |page_name|
  current_path = URI.parse(current_url).path
  expect(current_path).to eq(path_to(page_name))
end

Then(/^I should not be able to upload photos$/) do
  expect(page).not_to have_content("Upload Photo")
end

# From https://github.com/makandra/spreewald
Then(/^I should see in the following order:?$/) do |text|
  if text.is_a?(String)
    lines = text.split(/\n/)
  else
    lines = text.raw.flatten
  end
  lines = lines.collect { |line| line.gsub(/\s+/, ' ')}.collect(&:strip).reject(&:empty?)
  pattern = lines.collect(&Regexp.method(:quote)).join('.*?')
  pattern = Regexp.compile(pattern)
  page.text.gsub(/\s+/, ' ').should =~ pattern
end
