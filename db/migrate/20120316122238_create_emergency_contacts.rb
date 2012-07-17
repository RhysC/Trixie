class CreateEmergencyContacts < ActiveRecord::Migration
  def change
    create_table :emergency_contacts do |t|
      t.string :name
      t.string :email
      t.references :user
      t.text :user_audit
      t.timestamps
    end
    add_index :emergency_contacts, :user_id
  end
end
