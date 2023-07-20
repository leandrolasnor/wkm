class AddDeletedAtToVacations < ActiveRecord::Migration[7.0]
  def change
    add_column :vacations, :deleted_at, :datetime
    add_index :vacations, :deleted_at
  end
end
