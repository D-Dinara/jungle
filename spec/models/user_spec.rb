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

    it 'should have a minimum length when a user account is being created' do
      user = User.new(email: 'test@example.com', first_name: 'John', last_name: 'Doe', password: 'pass', password_confirmation: 'pass')
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

  # describe '.authenticate_with_credentials' do
  #   before do
  #     @user = User.create(email: 'test@example.com', first_name: 'John', last_name: 'Doe', password: 'password', password_confirmation: 'password')
  #   end

  #   it 'should authenticate user with correct credentials' do
  #     authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
  #     expect(authenticated_user).to eq(@user)
  #   end

  #   it 'should return nil for non-existent email' do
  #     authenticated_user = User.authenticate_with_credentials('nonexistent@example.com', 'password')
  #     expect(authenticated_user).to be_nil
  #   end

  #   it 'should return nil for incorrect password' do
  #     authenticated_user = User.authenticate_with_credentials('test@example.com', 'incorrect_password')
  #     expect(authenticated_user).to be_nil
  #   end

  #   it 'should authenticate user with leading/trailing spaces in email' do
  #     authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
  #     expect(authenticated_user).to eq(@user)
  #   end

  #   it 'should authenticate user with wrong case in email' do
  #     authenticated_user = User.authenticate_with_credentials('TEST@example.COM', 'password')
  #     expect(authenticated_user).to eq(@user)
  #   end

  end
end
