class ChatCalculate                        
    include Sidekiq::Worker
                                          
    def perform()                     
      # Add your code here. 
      apps = App.all.to_a
      apps_hash = {}
      apps.each do |app|
        count = $redis.get "chat_count_#{app.token}"
        apps_hash[app.id] = {"chats_count"=> count}
      end
      
      App.update(apps_hash.keys,apps_hash.values)
      puts "Chat Calculation Done"        
    end                     
  end