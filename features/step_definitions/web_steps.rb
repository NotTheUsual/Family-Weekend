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

Then(/^I should see the content for that page$/) do
  expect(page).to have_content("Welcome to the Stern family weekend website, where you’ll find information about this year’s family weekend, and pictures of previous years.

For any newcomers who might be interested we’ve included the story to date, and for those who consider themselves old-timers test yourselves by seeing if you can write out the list of where we were when before you check the history page (it took three of our finest minds for us to manage it).

Please send us any news and photos to add and we will put them up.")
end