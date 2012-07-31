class AddPictureToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :picture, :string

  end
end
