require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'must be created with password field' do
      user = User.new(email: 'test@test.com', first_name: 'John', last_name: 'Doe', password: nil, password_confirmation: 'password')
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'must be created with password_confirmation field' do
      user = User.new(email: 'test@test.com', first_name: 'John', last_name: 'Doe', password: 'password', password_confirmation: nil)
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'password and password_confirmation must match' do
      user = User.new(email: 'test@test.com', first_name: 'John', last_name: 'Doe', password: 'password', password_confirmation: 'different_password')
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'emails must be unique (not case sensitive)' do
      User.create(email: 'TEST@TEST.com', first_name: 'John', last_name: 'Doe', password: 'password', password_confirmation: 'password')
      user = User.new(email: 'test@test.COM', first_name: 'Jane', last_name: 'Doe', password: 'password', password_confirmation: 'password')
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'email should be required' do
      user = User.new(email: nil, first_name: 'John', last_name: 'Doe', password: 'password', password_confirmation: 'password')
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'first name should be required' do
      user = User.new(email: 'test@test.com', first_name: nil, last_name: 'Doe', password: 'password', password_confirmation: 'password')
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'last name should be required' do
      user = User.new(email: 'test@test.com', first_name: 'John', last_name: nil, password: 'password', password_confirmation: 'password')
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end


  end
end
