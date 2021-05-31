require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) { User.new(
    name: 'John',
    email: 'john@test.com',
    password: '888888',
    password_confirmation: '888888'
  )}

  describe 'Validations' do
    it "is valid with valid attributes" do
      user.save
      expect(user).to be_valid
      expect(user.errors.full_messages).to be_empty
    end

     it "is not valid without name" do
      user.name = nil
      user.save
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include ("Name can't be blank")
    end

    it "is not valid without an email" do
      user.email = nil
      user.save
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include ("Email can't be blank")
    end

    it "is not valid without pasword" do
      user.password = nil
      user.save
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include ("Password can't be blank")
    end

    it "is not valid without pasword confirmation" do
      user.password_confirmation = nil
      user.save
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include ("Password confirmation can't be blank")
    end

    it "is not valid when password and password_confirmation don't match" do
      user.password_confirmation = "000000"
      user.save
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include ("Password confirmation doesn't match Password")
    end

    it "is not valid when email isn't unique (case insensitive)" do
      same_as_user = User.create(
        name: "John",  
        email: "john@test.com", 
        password: "111111", 
        password_confirmation: "111111"
      )
      user.save
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include ("Email has already been taken")
    end

    it "is not valid when password is shorter than 6 characters" do
      user.password = "asdf"
      user.password_confirmation = "asdf"
      user.save
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include ("Password is too short (minimum is 6 characters)")
    end


    describe '.authenticate_with_credentials' do
    it "authenticates when credentials are valid" do
      user.save!
      auth = User.authenticate_with_credentials(user.email, user.password)
      expect(auth).to eq user
    end

    it "doesn't authenticate when email is incorrect" do
      user.save!
      auth = User.authenticate_with_credentials("other@gmail.com", user.password)
      expect(auth).to eq nil
    end

    it "doesn't authenticate when password is incorrect" do
      user.save!
      auth = User.authenticate_with_credentials(user.email, "forgot")
      expect(auth).to eq nil
    end

    it "authenticates when email is correct but contains whitespace around it" do
      user.save!
      auth = User.authenticate_with_credentials("   " + user.email + "  ", user.password)
      expect(auth).to eq user
    end

    it "authenticates when email is correct but in the wrong case" do
      user.save!
      auth = User.authenticate_with_credentials("JOHn@tEst.cOM", user.password)
      expect(auth).to eq user
    end
  end




  end 
end
