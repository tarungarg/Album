FactoryGirl.define do
  factory :photo do
  	image Rack::Test::UploadedFile.new(Rails.root + 'spec/files/images.jpg', 'image/jpg')
  	album
  	
  	factory :photo_without_image do 
  		image ""
  	end

  	factory :photo_with_tags do
	  	after(:create) do |photo|
	  		FactoryGirl.create(:tag, photo: photo)
	  	end
  	end

    factory :photo_without_tags do
	  	after(:create) do
	  		FactoryGirl.create(:tag_without_caption)
	  	end
  	end
  end

end