require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "should register the user successfully when all fields are set" do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'janedoe@test.com',
        password: 'hello1234',
        password_confirmation: 'hello1234'
      )
      expect(user.save).to be true
    end

    it "should require password and password confirmation fields" do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'janedoe@test.com',
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it "should require the password and the password confirmation fields to match" do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'janedoe@test.com',
        password: 'hello1234',
        password_confirmation: 'gello1234'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should require the email to be unique" do
      email = 'test@test.com'

      user1 = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: email,
        password: 'hello1234',
        password_confirmation: 'hello1234'
      )
      user1.save!

      user2 = User.new(
        first_name: 'John',
        last_name: 'Deere',
        email: email.upcase,
        password: 'heya1234',
        password_confirmation: 'heya1234'
      )
      expect(user2.save).to be false
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it "should require a first name to be present" do
      user = User.new(
        last_name: 'Doe',
        email: 'janedoe@test.com',
        password: 'hello1234',
        password_confirmation: 'hello1234'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it "should require a last name to be present" do
      user = User.new(
        first_name: 'Jane',
        email: 'janedoe@test.com',
        password: 'hello1234',
        password_confirmation: 'hello1234'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it "should require an email to be present" do
      user = User.new(
        first_name: 'Jane',
        last_name: "Doe",
        password: 'hello1234',
        password_confirmation: 'hello1234'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "should require the password to be a minimum of three characters long" do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'janedoe@test.com',
        password: 'hi',
        password_confirmation: 'hi'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    let!(:user) do
      User.create(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'janedoe@test.com',
        password: 'hello1234'
      )
    end

    it "returns the user when authenticated" do
      authenticated_user = User.authenticate_with_credentials('janedoe@test.com', 'hello1234')
      expect(authenticated_user).to eq(user)
    end

    it "returns nil when not authenticated" do
      authenticated_user = User.authenticate_with_credentials('janedoe@test.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    it "returns the user even with trailing spaces" do
      authenticated_user = User.authenticate_with_credentials('  janedoe@test.com ', 'hello1234')
      expect(authenticated_user).to eq(user)
    end

    it "returns the user regardless of the case they use for their email" do
      authenticated_user = User.authenticate_with_credentials('JANEdoE@tESt.CoM', 'hello1234')
      expect(authenticated_user).to eq(user)
    end

  end

end
