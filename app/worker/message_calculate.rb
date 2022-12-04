class MessageCalculate                        
    include Sidekiq::Worker

    def perform()                     
      # Add your code here.
      chats = Chat.all.to_a
      chats_hash = {}
      chats.each do |chat|
        app_token = chat.app.token #TODO bad pratice increase db hits should create join instead
        count = $redis.get "message_count_#{app_token}_#{chat.cid}"
        chats_hash[chat.id] = {"messages_count"=> count}
      end

      Chat.update(chats_hash.keys,chats_hash.values)
      puts "Messages Calculation Done"
    end                     
  end