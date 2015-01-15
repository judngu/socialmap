class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :user_id, null: false
      t.integer :event_id, null: false
      t.integer :value, null:false
      t.integer :picked_user_id, null: false

      t.timestamps
    end
  end
end
