require 'spec_helper'

describe User do

  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:password) }
  it { should have_many(:albums).dependent(:destroy) }
  
  it "should create a user object with valid attributes" do
    FactoryGirl.create(:user)
  end

  it "should not create a user object with invalid attributes" do
  	FactoryGirl.build(:user, email: "").should_not be_valid
  end

  it "should require an email address" do
    user_with_blank_email = FactoryGirl.build(:user, email: "")
    user_with_blank_email.should_not be_valid
  end

  it "should accept email with valid format" do
    addresses = %w[test@xyz.com THE_xyz@xyz.aus.org first.last@foo.in]
    addresses.each do |address|
      valid_email_user = FactoryGirl.build(:user, email: address)
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@xyz,com user_at_xyzf.org example.test@xyz.]
    addresses.each do |address|
      invalid_email_user = FactoryGirl.build(:user, email: address)
      invalid_email_user.should_not be_valid
    end
  end

  it "should create user with unique email throughout the system" do
    @user = FactoryGirl.create(:user)
    user_with_duplicate_email = FactoryGirl.build(:user, email: @user.email)
    user_with_duplicate_email.should_not be_valid
  end

  describe "password validations" do

    it "should require a password" do
      FactoryGirl.build(:user, password: "").should_not be_valid
    end

    it "should require a matching password confirmation" do
    	FactoryGirl.build(:user, password_confirmation: "").should_not be_valid
    end

    it "should reject short passwords" do
      FactoryGirl.build(:user, { password: 'aaaa', password_confirmation: 'aaa' }).should_not be_valid
    end

    it "should save user with album and images" do
      lambda {FactoryGirl.create(:album_without_user) }.should raise_error
    end
  
  end

end
