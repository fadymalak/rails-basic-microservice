class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.integer :messages_count , :default => 0
      t.integer :cid
      t.references  :app, foreign_key: true
      t.timestamps
      t.index ["cid"], name: "index_chat_id", using: :btree
      t.index ["app_id"], name: "index_app_id", using: :btree
    end
  end
end
