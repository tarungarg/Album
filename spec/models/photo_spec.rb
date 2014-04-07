require 'spec_helper'

describe Photo do

  it { should allow_mass_assignment_of(:image) }
  it { should allow_mass_assignment_of(:album_id) }
  it { should allow_mass_assignment_of(:tags_attributes) }
  it { should belong_to(:album) }
  it { should have_many(:tags).dependent(:destroy) }
  it { should accept_nested_attributes_for(:tags) }
  it { should have_and_belong_to_many(:hashtags) }

  it "should save photo with album" do
    FactoryGirl.build(:photo).should be_valid
  end

  it "should not create tags" do
    photo = FactoryGirl.create(:photo_without_tags)
    photo.tags.count.should eql(0)
  end

  it "should create tags" do
    photo = FactoryGirl.create(:photo_with_tags)
    photo.tags.count.should_not eql(0)
  end

end

