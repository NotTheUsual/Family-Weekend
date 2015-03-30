require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))

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
  User.create(name: 'admin', password: 's3cr3t', admin: true)
end

Given(/^I am logged in$/) do
  User.create(name: 'admin', password: 's3cr3t', admin: true)
  visit path_to('the login page')
  fill_in 'name', with: 'admin'
  fill_in 'password', with: 's3cr3t'
  click_button 'Sign In'
end

Given(/^I am logged in as a regular user$/) do
  User.create(name: 'user', password: 's3cr3t', admin: false)
  visit path_to('the login page')
  fill_in 'name', with: 'user'
  fill_in 'password', with: 's3cr3t'
  click_button 'Sign In'
end

Given(/^I am not logged in$/) do
  visit path_to('the homepage')
end

Given(/^there are photos uploaded$/) do
  User.create(name: 'admin', password: 's3cr3t', admin: true)
  visit path_to('the login page')
  fill_in 'name', with: 'admin'
  fill_in 'password', with: 's3cr3t'
  click_button 'Sign In'
  visit '/photos/new'
  attach_file('photo', "#{Dir.pwd}/features/fixtures/2011.png")
  fill_in 'year', with: '2011'
  click_button 'Upload'
  visit '/photos/new'
  attach_file('photo', "#{Dir.pwd}/features/fixtures/2011.png")
  fill_in 'year', with: '2012'
  click_button 'Upload'
  click_button 'Sign Out'
end

Given(/^there are news posts in the database$/) do
  visit path_to('the new post page')
  fill_in 'post[title]', with: 'Blog Post 1'
  fill_in 'post[body]', with: 'This is really important, everyone. _Really_ important.'
  click_button 'Accept'
  visit path_to('the new post page')
  fill_in 'post[title]', with: 'Blog Post 2'
  fill_in 'post[body]', with: 'This is less important.'
  click_button 'Accept'
  visit path_to('the new post page')
  fill_in 'post[title]', with: 'Blog Post 3'
  fill_in 'post[body]', with: 'At this point, I\'m just wasting time'
  click_button 'Accept'
end

When(/^I enter the correct details$/) do
  fill_in 'name', with: 'admin'
  fill_in 'password', with: 's3cr3t'
  click_button 'Sign In'
end

When(/^I click 'Sign Out'$/) do
  click_button 'Sign Out'
end

When(/^I press '(.*?)'$/) do |button|
  click_button button
end

When(/^I click "(.*?)"$/) do |link|
  click_link link
end

When(/^I click on 'Photos' in the menu$/) do
  expect(page).to have_content('Photos')
  click_link 'Photos'
end

When(/^I log in$/) do
  User.create(name: 'admin', password: 's3cr3t', admin: true)
  fill_in 'name', with: 'admin'
  fill_in 'password', with: 's3cr3t'
  click_button 'Sign In'
end

When(/^I upload a photo$/) do
  attach_file('photo', "#{Dir.pwd}/features/fixtures/2011.png")
  fill_in 'year', with: '2011'
  click_button 'Upload'
end

When(/^I enter my new post$/) do
  fill_in 'post[title]', with: 'New Blog Post!'
  fill_in 'post[body]', with: 'Really excited about starting this **amazing** blog.'
end

When(/^I click on a post$/) do
  click_link 'Blog Post 1'
end

When(/^I edit the post$/) do
  fill_in 'post[title]', with: 'Newer Blog Post!'
  fill_in 'post[body]', with: 'You, know what? That text was a _little_ rubbish'
  click_button 'Submit'
end

Then(/^I should see the content for that page$/) do
  expect(page).to have_content('Welcome to the Stern family weekend website, where you’ll find information about this year’s family weekend, and pictures of previous years.
                                For any newcomers who might be interested we’ve included the story to date, and for those who consider themselves old-timers test yourselves by seeing if you can write out the list of where we were when before you check the history page (it took three of our finest minds for us to manage it).
                                Please send us any news and photos to add and we will put them up.')
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
  expect(page).to have_xpath("//img[contains(@src, '2011.png')]")
end

Then(/^I should be on (.+)$/) do |page_name|
  current_path = URI.parse(current_url).path
  expect(current_path).to eq(path_to(page_name))
end

Then(/^I should not be able to upload photos$/) do
  expect(page).not_to have_content('Upload Photo')
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

Then(/^I should see the video and its description$/) do
  expect(page).to have_xpath("//iframe")
  expect(page).to have_content('This film is the edited highlights of over 40 years of footage from the yearly tradition of the Stern family reunion.')
  expect(page).to have_content('For more information, contact Carly Hartley on carly(dot)hartley(at)gmail(dot)com')
end

Then(/^I should see my new post$/) do
  expect(page).to have_content('New Blog Post!')
  expect(page).to have_content('Really excited about starting this amazing blog.')
end

Then(/^I should see all the posts$/) do
  expect(page).to have_content('Blog Post 1')
  expect(page).to have_content('Blog Post 2')
  expect(page).to have_content('Blog Post 3')
end

Then(/^I should see links to view and edit all the posts$/) do
  expect(page).to have_xpath("//a[contains(@href, '/news/1')]")
  expect(page).to have_xpath("//a[contains(@href, '/news/1/edit')]")
end

Then(/^I should be able to edit that post$/) do
  current_path = URI.parse(current_url).path
  expect(current_path).to eq('/news/1/edit')
  expect(page).to have_xpath("//input[contains(@value, 'Blog Post 1')]")
  expect(page).to have_content('This is really important, everyone. _Really_ important.')
end

Then(/^I should see my edited post$/) do
  current_path = URI.parse(current_url).path
  expect(current_path).to eq('/news/1')
  expect(page).to have_content('Newer Blog Post!')
  expect(page).to have_content('You, know what? That text was a little rubbish')
end

