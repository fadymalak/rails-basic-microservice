class CreateApps < ActiveRecord::Migration[7.0]
  def change
    create_table :apps do |t|
      t.string :name
      t.string :token
      t.integer :chats_count , :default => 0
      t.timestamps
    end
  end
end
