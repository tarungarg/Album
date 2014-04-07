class Photo < ActiveRecord::Base

	attr_accessible :album_id, :image, :tags_attributes

	has_attached_file :image, styles: { thumb: "160x160>"}

	belongs_to :album
	has_many :tags, dependent: :destroy
	has_and_belongs_to_many :hashtags

	accepts_nested_attributes_for :tags, :reject_if => lambda { |a| a[:caption].blank? }

end