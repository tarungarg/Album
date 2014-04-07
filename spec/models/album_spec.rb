require 'spec_helper'

describe Album do

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:user_id) }
  it { should allow_mass_assignment_of(:photos_attributes) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }
  it { should have_many(:photos).dependent(:destroy) }
  it { should accept_nested_attributes_for(:photos) }
  it { should belong_to(:user) }
  it { should validate_uniqueness_of(:name) }

  it "should not save album without user" do
    FactoryGirl.build(:album, user_id: "").should_not be_valid
  end

  it "should not save album without user and show error message" do
    album = Album.create(:name => Faker::Name.name)
    album.errors.messages[:user_id].should eql ["can't be blank"]
  end

  it "should have uniqe name" do
    album = FactoryGirl.create(:album)
    album1 = Album.create(:name => album.name, :user_id => album.user_id)
    album1.errors.messages[:name].should eql ["has already been taken"]
  end

  it "should have multiple photos" do
    album = FactoryGirl.create(:album_with_images)
    album.photos.count.should eql(2)
  end

  it "should not save photos wihout attributes" do
    album = FactoryGirl.create(:album_without_image)
    album.photos.count.should eql(0)
  end

  it "should save wih user" do
    FactoryGirl.create(:album_with_user).should be_valid
  end

  it "should not save without user" do
    lambda {FactoryGirl.create(:album_without_user) }.should raise_error
  end

end
