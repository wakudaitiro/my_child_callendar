class RemoveColumsFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :phone_number, :string
    remove_column :users, :website, :string
  end
end
