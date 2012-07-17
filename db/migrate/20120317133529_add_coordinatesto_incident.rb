class AddCoordinatestoIncident < ActiveRecord::Migration
  def change
     add_column :incidents, :coordinates, :text

   end
end