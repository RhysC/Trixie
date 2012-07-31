class AddCoordinatesAndPicturesToIncidentHistory < ActiveRecord::Migration
  def change
     add_column :incident_histories, :coordinates, :text
     add_column :incident_histories, :picture, :string     
   end
end
