require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do

    it 'save user when all fields are input correctly' do
      @user = User.new(name: 'John', email: '123@gmail.com', password: "111", password_confirmation: "111")
      expect(@user).to be_valid
    end

    it 'dont save the password if its not match up with password_confirmation' do
      @user = User.new(name: 'John', email: '123@gmail.com', password: "111", password_confirmation: "222")
      @user.save 
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'show an error message if password does not set up properly' do
      @user = User.new(name: 'John', email: '123@gmail.com', password: nil, password_confirmation: nil)
      @user.save
      expect(@user.errors.full_messages).to include("Please type something for the pasword do not leave it blank")
    end

    it 'should provide an error message if name not set' do
      @user = User.new(name: nil, email: '123@gmail.com', password: "111", password_confirmation: "111")
      @user.save
      expect(@user).to_not be_valid
    end

    it 'should provide an error message if email not set' do
      @user = User.new(name: 'John', email: nil, password: "111", password_confirmation: "111")
      @user.save
      expect(@user).to_not be_valid
    end

    it 'should provide an error message if email is not unique' do
      @user_1 = User.new(name: 'John', email: '123@gmail.com', password: "111", password_confirmation: "111")
      @user_1.save
      @user_2 = User.new(name: 'Amy', email: '123@gmail.com', password: "222", password_confirmation: "222")
      @user_2.save
      expect(@user_2.errors.full_messages).to include("Email has been used")
    end

    it 'should have a minimun password length' do
      @user = User.new(name: 'John', email: '123@gmail.com', password: "1", password_confirmation: "1")
      @user.save
      expect(@user.errors.full_messages).to include('please at least put 2 characters password')
    end

  end

  describe '.authenticate_with_credentials' do
    
    it 'should only log-in user with valid credentials' do
      @user = User.new(name: 'John', email: '123@gmail.com', password: "111", password_confirmation: "111")
      @user.save
      @user_logged_in = User.authenticate_with_credentials('123@gmail.com', "111")
      expect(@user_logged_in).to_not eq(nil)
    end

    it 'should authenticate user if email contains trailing spaces' do
      @user = User.new(name: 'John', email: '123@gmail.com', password: "111", password_confirmation: "111")
      @user.save
      @user_logged_in = User.authenticate_with_credentials('123 @gmail.com ', "111")
      expect(@user_logged_in).to_not eq(nil)
    end

    it 'should authenticate user if email in the wrong case' do
      @user = User.new(name: 'John', email: '123@gmail.com', password: "111", password_confirmation: "111")
      @user.save
      @user_logged_in = User.authenticate_with_credentials('111@gmail.com', "111")
      expect(@user_logged_in).to_not eq(nil)
    end
  end

end