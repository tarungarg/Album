FactoryGirl.define do
  factory :user do
		sequence :email do |n|
    	n.to_s + Faker::Internet.email 
   	end

  	password "qwertyuiop"
  	password_confirmation "qwertyuiop"

  	factory :album_with_user do
	  	after(:create) do |user|
	  		FactoryGirl.create(:album, user: user)
	  	end
  	end

    factory :album_without_user do
	  	after(:create) do |user|
	  		FactoryGirl.create(:album, user: nil)
	  	end
  	end

    factory :user_with_albums_photos_and_tags, class: User do
      ignore do
        album_count 2 
      end

      after(:create) do |user_with_albums_photos_and_tags, evaluator|
        FactoryGirl.create_list(:album_with_images, evaluator.album_count, user: user_with_albums_photos_and_tags)
      end
    end
  
  end
end
