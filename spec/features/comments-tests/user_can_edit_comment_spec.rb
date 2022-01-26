require 'rails_helper'
require_relative "../../helpers/sign_up_helper_spec.rb"

RSpec.feature "Edit Comment", type: :feature do
  scenario "User can edit their own comment" do
		sign_up
		visit "/posts/new"
		fill_in "post[message]", with: "Hello, world!"
    click_on "Post"
		expect(page).to have_content("Hello, world!")
		fill_in "comment[body]", with: "A comment!"
    click_button "Comment"
		expect(page).to have_content("A comment!")
		find('input.edit-comment-btn').click
		fill_in "comment[body]", with: "Editing comment!"
		click_button "Comment"
		expect(page).to have_content("Editing comment!")
	end
end
