# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it('Creates a User class instance') do
    expect(subject).to be_instance_of(User)
  end

  it('Creates a user with a first name') do
    expect(subject.name).to eq(nil)
  end

  it('Creates a user with a last name') do
    expect(subject.surname).to eq(nil)
  end
end
