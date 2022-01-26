require 'rails_helper'
require_relative "../../helpers/sign_up_helper_spec.rb"

RSpec.feature "Delete Post", type: :feature do
  scenario "User can delete their own post" do
		sign_up
		visit "/posts/new"
		fill_in "post[message]", with: "Hello, world!"
    click_on "Post"
		expect(page).to have_content("Hello, world!")
		click_on "Delete"
		expect(page).not_to have_content("Hello, world!")
	end
end
