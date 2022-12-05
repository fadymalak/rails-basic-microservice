class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :text_msg
      t.integer :mid
      t.references  :chat, foreign_key: true

      t.timestamps
      t.index ["chat_id"] , name: 'index_chat_id', using: :btree
      t.index ["mid"], name: "index_chat_message_id", using: :btree
    end
  end
end
