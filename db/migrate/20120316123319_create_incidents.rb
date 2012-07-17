class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.datetime :raised_on
      t.references :user
      t.text :user_audit
      #t.text :notifications

      t.timestamps
    end
    add_index :incidents, :user_id
  end
end
