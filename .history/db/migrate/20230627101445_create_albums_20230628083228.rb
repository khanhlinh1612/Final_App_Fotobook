class CreateAlbums < ActiveRecord::Migration[7.0]
  create_enum :mode, ["public", "private"]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :description
      t.enum :sharing_mode, enum_type: :mode, default: "public" , null:false
      t.integer :total_like
      t.timestamps
    end
    add_reference :photos, :user,  foreign_key: true
  end
end
