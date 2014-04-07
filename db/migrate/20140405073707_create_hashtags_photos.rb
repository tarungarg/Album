class CreateHashtagsPhotos < ActiveRecord::Migration
  def change
    create_table :hashtags_photos do |t|
      t.integer :photo_id
      t.integer :hashtag_id
    end
  end
end
