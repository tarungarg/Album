FactoryGirl.define do
  factory :album do
  	sequence(:name) {|n| Faker::Name.name }
  	user
    
    factory :album_with_images do
	    after(:create) do |album|
	      FactoryGirl.create_list(:photo_with_tags, 2, album: album)
	    end
	  end
	  
	  factory :album_without_image do
	  	after(:create) do
	  		FactoryGirl.create(:photo_without_image)
	  	end
	  end
  end

end
