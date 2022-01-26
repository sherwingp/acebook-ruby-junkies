require 'rails_helper'

RSpec.describe FriendRequest, type: :model do

  before(:each) do
    @request = FactoryBot.create(:friend_request)
  end

  describe('#initialize') do
    it('creates a friend request instance') do
      expect(subject).to be_instance_of(FriendRequest)
    end
  end

  describe('#accept') do
    it('adds friend to user friends') do
      @request.accept
      friend_id = @request.friend_id
      expect(User.find(@request.user_id).friends.first.id).to eq(friend_id)
    end

    it('destroys friend request') do
      expect(@request).to receive(:destroy)
      @request.accept
    end
  end
end
