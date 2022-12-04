class AddMessageJob < ApplicationJob
  queue_as :message_queue

  def perform(text:,mid:,chat_id:)
    # Do something later
    puts text
    puts mid
    puts chat_id
    msg = Message.create(:text_msg => text , :mid => mid , :chat_id => chat_id)
  end
end
