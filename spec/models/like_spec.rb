# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  it('create a valid like') do
    expect(subject).to be_instance_of(Like)
  end

  it('reject an invalid like') do
    like = Like.create
    expect(like.valid?).to be_falsey
  end
end
