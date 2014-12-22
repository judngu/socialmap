class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
	  	t.integer :user_id
	  	t.integer :event_id
	  	t.integer :value
	  	t.integer :picked_user, class_name: "User"

  	t.timestamps
    end
  end
end
