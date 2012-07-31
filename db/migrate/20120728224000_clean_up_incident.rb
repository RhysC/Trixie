class CleanUpIncident < ActiveRecord::Migration
  def up
    remove_column :incidents, :picture
  end

  def down
    add_column :incidents, :picture, :string
  end
end
