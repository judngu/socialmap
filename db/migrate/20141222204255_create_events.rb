class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.string :name, null: false
    	t.string :location
    	t.string :address
    	t.string :city
    	t.string :state
        t.string :zipcode
    	t.integer :user_id, null: false
    	t.string :question, null: false
    	t.string :passphrase, null: false
    	t.text :description

    	t.timestamps
    end
  end
end
