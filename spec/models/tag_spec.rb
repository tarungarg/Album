require 'spec_helper'

describe Tag do

  it { should allow_mass_assignment_of(:caption) }
  it { should allow_mass_assignment_of(:photo_id) }
  it { should belong_to(:photo) }
  
  it "should have tags entered in hashtag table" do
    before_count = Hashtag.count
    FactoryGirl.create(:tag)
    after_count = Hashtag.count
    before_count.should_not eql after_count
  end

  it "should enter 2 tags in hashtag table" do
    FactoryGirl.create(:tag_with_2_hashtags)
    after_count = Hashtag.count
    after_count.should eql(2)
  end

  it "should associate photo with hashtags" do
    tag = FactoryGirl.create(:tag)
    tag.photo.hashtags.size.should_not eql(0)
  end
end
