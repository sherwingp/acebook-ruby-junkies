require 'rails_helper'

RSpec.feature "Timeline", type: :feature do
  scenario "Can submit posts and view them" do
    visit "/posts"
    click_link "What's on your mind?"
    fill_in "Message", with: "Hello, world!"
    click_button "Post"
    expect(page).to have_content("Hello, world!")
  end
end
