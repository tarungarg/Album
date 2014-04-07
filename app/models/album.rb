class Album < ActiveRecord::Base

	attr_accessible :name, :user_id, :photos_attributes

	validates :user_id , presence: true
	validates :name, presence: true, uniqueness: true

	belongs_to :user
	has_many :photos, dependent: :destroy

	accepts_nested_attributes_for :photos, :reject_if => lambda { |a| a[:image].blank? }

	scope :include_all,		-> { includes(:photos, :photos => :hashtags) }

end