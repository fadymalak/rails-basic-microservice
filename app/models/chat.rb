class Chat < ApplicationRecord
    has_many :message
    belongs_to :app
    scope :get_last_chat_id, lambda {|app_id| where(:app_id => app_id).last}

end
