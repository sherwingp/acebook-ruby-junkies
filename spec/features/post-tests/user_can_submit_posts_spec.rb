require 'rails_helper'

RSpec.feature "Timeline", type: :feature do
  scenario "Can submit posts and view them" do
    visit "/posts"
    click_link "What's on your mind?"
    fill_in "Message", with: "Hello, world!"
    click_button "Post"
    expect(page).to have_content("Hello, world!")
    #Database has username as name
    expect(page).to have_content("name")
  end

  scenario "should have an image once an image post is made" do
    visit "/posts/new"
    fill_in "Message", with: "Hello, world!"
    attach_file('post[image]',
                File.join(Rails.root, '/spec/image1.jpeg'), :visible => false)
    click_button "Post"
    page.should have_css('img')
  end
end
