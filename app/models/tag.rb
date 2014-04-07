class Tag < ActiveRecord::Base

	attr_accessible :caption, :photo_id

	belongs_to :photo
	after_save :create_tags

	HASH_TAG_REGEX = /#[a-zA-Z0-9]+/


	private

	def create_tags
		hash_string = self.caption.scan(HASH_TAG_REGEX)
		all_tags = []
		hash_string.each do |hashtag|
			tag = Hashtag.find_or_create_by_name(hashtag)
			if tag.new_record?
				tag.name = hashtag
				tag.save
			end
			all_tags << tag
		end
		add_tags_to_photos(all_tags)
	end

	def add_tags_to_photos(tags)
		self.photo.hashtags << tags
	end

end
