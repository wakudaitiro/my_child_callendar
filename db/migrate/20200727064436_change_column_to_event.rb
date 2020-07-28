class ChangeColumnToEvent < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :start, :start_datetime
    rename_column :events, :end, :end_datetime
  end
end
