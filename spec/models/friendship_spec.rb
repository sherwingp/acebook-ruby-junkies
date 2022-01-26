require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @friend = FactoryBot.create(:friend)
  end
  
  it 'is valid with valid attributes' do
    subject.user_id = @user.id
    subject.friend_id = @friend.id
    expect(subject).to be_valid
  end

  it 'is not valid without a friend' do
    subject.user_id = @user.id
    expect(subject).to be_invalid
  end

  it 'is not valid without a user' do
    subject.friend_id = @friend.id
    expect(subject).to be_invalid
  end

  it 'is not valid to befriend yourself' do
    subject.user_id = @user.id
    subject.friend_id = @user.id
    expect(subject).to be_invalid
  end
end
