require 'rails_helper'

RSpec.feature "Likes", type: :feature do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    post = FactoryBot.create(:post)
  end

  scenario "a user can like a post" do
    visit '/posts'
    click_on 'Like'
    expect(page).to have_content '1 Like'
  end

  scenario "a user can unlike a post" do
    visit '/posts'
    click_on 'Like'

    click_on 'Unlike'
    expect(page).to have_content '0 Likes'
  end

  scenario "a user can like a comment" do
    visit '/posts'
    fill_in "comment[body]", with: "A comment!"
    click_button "Create Comment"
    visit '/posts'
    click_button 'Like Comment'
  end
end
