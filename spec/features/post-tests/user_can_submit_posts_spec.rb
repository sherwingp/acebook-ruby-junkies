# frozen_string_literal: true

require 'rails_helper'
require_relative "../../helpers/sign_up_helper_spec.rb"


RSpec.feature "Timeline", type: :feature do
  scenario "Can submit posts and view them" do
    sign_up
    visit "/posts/new"
    fill_in "post[message]", with: "Hello, world!"
    click_on "Post"
    expect(page).to have_content("Hello, world!")
    #Database has username as name
    expect(page).to have_content("John Doe")
  end

  scenario "should have an image once an image post is made" do
    sign_up
    visit "/posts/new"
    fill_in "post[message]", with: "Hello, world!"
    attach_file('post[image]',
                File.join(Rails.root, '/spec/feature_test_image1.jpeg'), :visible => false)
    click_button "Post"

    expect(page).to have_css("img[src*='/feature_test_image1.jpeg']")
  end
end
