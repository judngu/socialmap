class AddIndexToEvents < ActiveRecord::Migration
  def change
    add_index :events, :passphrase
  end
end
