class AddChatJob < ApplicationJob
  queue_as :chat_queue

  def perform(cid: , app_id:)
    # Do something later
    puts "Hello world"
    chat = Chat.new
    chat.app_id= app_id
    chat.cid= cid
    chat.save
  end
end
