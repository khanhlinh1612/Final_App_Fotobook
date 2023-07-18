class CreateLikePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :like_photos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :photo, null: false, foreign_key: true

      t.timestamps
    end
    add_index  :like_photos, [:user_id, :photo_id], unique: true
  end
end
