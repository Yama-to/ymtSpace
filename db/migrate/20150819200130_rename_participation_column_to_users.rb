class RenameParticipationColumnToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :participation, :position
  end
end
