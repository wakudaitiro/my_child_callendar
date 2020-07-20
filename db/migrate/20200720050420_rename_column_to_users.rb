class RenameColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :name, :babyname
    rename_column :users, :self_intro, :memo
  end
end
