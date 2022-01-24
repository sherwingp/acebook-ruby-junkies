# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Likes', type: :feature do
  scenario 'a user can like a post' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    FactoryBot.create(:post)

    visit '/posts'
    click_on 'Like'
    expect(page).to have_content '1 Like'
  end

  scenario 'a user can unlike a post' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    FactoryBot.create(:post)

    visit '/posts'
    click_on 'Like'

    click_on 'Unlike'
    expect(page).to have_content '0 Likes'
  end
end
