class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title
      t.string :description
      t.integer :sharing_status
      t.string :img_url

      t.timestamps
    end
  end
end

