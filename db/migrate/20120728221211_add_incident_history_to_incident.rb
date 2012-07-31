class AddIncidentHistoryToIncident < ActiveRecord::Migration
  change_table :incident_histories do |t|
    t.belongs_to :incident
  end
end
