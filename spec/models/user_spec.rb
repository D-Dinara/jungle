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
      user = User.new(email: 'test@test.com', first_name: 'John', last_name: 'Doe', password: 'pass', password_confirmation: 'pass')
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    describe '.authenticate_with_credentials' do
      before do
        # Create a user for testing
        @user = User.create(
          email: 'test@test.com',
          first_name: 'John',
          last_name: 'Doe',
          password: 'password',
          password_confirmation: 'password'
        )
      end
  
      context 'when given valid credentials' do
        it 'returns the user instance' do
          authenticated_user = User.authenticate_with_credentials('test@test.com', 'password')
          expect(authenticated_user).to eq(@user)
        end
      end
  
      context 'when given invalid email' do
        it 'returns nil' do
          authenticated_user = User.authenticate_with_credentials('invalid_email@test.com', 'password')
          expect(authenticated_user).to be_nil
        end
      end
  
      context 'when given incorrect password' do
        it 'returns nil' do
          authenticated_user = User.authenticate_with_credentials('test@test.com', 'wrong_password')
          expect(authenticated_user).to be_falsey
        end
      end
  
      context 'when given email with leading/trailing whitespace' do
        it 'returns the user instance' do
          authenticated_user = User.authenticate_with_credentials('  test@test.com  ', 'password')
          expect(authenticated_user).to eq(@user)
        end
      end
  
      context 'when given email with different cases' do
        it 'returns the user instance' do
          authenticated_user = User.authenticate_with_credentials('TEST@test.com', 'password')
          expect(authenticated_user).to eq(@user)
        end
      end
    end


  end
end
