class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
    	t.integer :event_id
    	t.integer :user_id
    end
  end
end
