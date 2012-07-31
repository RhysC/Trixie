class CreateIncidentHistories < ActiveRecord::Migration
  def change
    create_table :incident_histories do |t|
      t.text :comment
      t.timestamp :raised_on
      t.text :user_audit

      t.timestamps
    end
  end
end
