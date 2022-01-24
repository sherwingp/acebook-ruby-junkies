# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  it('create a valid like') do
    like = Like.create(user_id: 1, post_id: 1)
    expect(like.user_id).to be 1
  end

  it('reject an invalid like') do
    like = Like.create
    expect(like.valid?).to be_falsey
  end
end
