class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :photo_id
      t.string :caption

      t.timestamps
    end
  end
end
