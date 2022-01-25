require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  # let(:user1) { double("user1", :id => 1, :friends => []) }
  # let(:user2) { double("user2", :id => 2, :friends => []) }
  # let(:friend_request) { double("friend request", :id => 1, :user_id => 1, :friend_id => 2) }
  
  request = FactoryBot.create(:friend_request)

  describe('#initialize') do
    it('creates a friend request instance') do
      expect(subject).to be_instance_of(FriendRequest)
    end
  end

  describe('#accept') do
    it('adds friend to user friends') do
      p request
      request.accept
    
    end

    it('destroys friend request') do
      
    end
  end
end
