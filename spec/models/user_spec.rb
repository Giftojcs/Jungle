require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:each) do
      User.destroy_all
    end

    it 'requires unique emails (case-insensitive)' do
      existing_user = User.create!(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(existing_user).to be_valid

      new_user = User.new(
        email: 'TEST@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(new_user).to_not be_valid
      expect(new_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'requires password and password_confirmation when creating the model' do
      user = User.new(
        email: 'test@example.com'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank", "Password confirmation can't be blank")
    end

    it 'requires a minimum password length' do
      user = User.new(
        email: 'test@example.com',
        password: 'pass',
        password_confirmation: 'pass'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
  end

  describe 'authenticate_with_credentials' do
    before(:each) do
      User.destroy_all
    end

    it 'authenticates with valid credentials' do
      user = User.create!(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'authenticates successfully with spaces around email' do
      user = User.create!(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'authenticates successfully with wrong case in email' do
      user = User.create!(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('TEST@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
end
