class AddCommentsCounterToPrototypes < ActiveRecord::Migration
  def change
    add_column :prototypes, :comments_count, :integer, default: 0
  end
end
