require 'rails_helper'
require_relative "../../helpers/sign_up_helper_spec.rb"

RSpec.feature "Edit Post", type: :feature do
  scenario "User can edit their own post" do
		sign_up
		visit "/posts/new"
		fill_in "post[message]", with: "Hello, world!"
    click_on "Post"
		expect(page).to have_content("Hello, world!")
		click_on "Edit"
		fill_in "post[message]", with: "Just edited my post"
		click_on "Post"
		expect(page).to have_content("Just edited my post")
	end
end
