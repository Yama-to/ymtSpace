class CreateThumbnails < ActiveRecord::Migration
  def change
    create_table :thumbnails do |t|
      t.text :thumbnail
      t.integer :role
      t.references :prototype, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
