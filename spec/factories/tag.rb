FactoryGirl.define do
  factory :tag do
  	caption  Faker::Lorem.sentence.split(' ').map{|x| '#' + x}.join(' ')
   	photo

   	factory :tag_without_caption do
   		caption ""
   	end

   	factory :tag_with_2_hashtags do
   		caption "#tar mar, india, company#vinsol"
   	end

  end

end
