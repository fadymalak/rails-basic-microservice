require 'elasticsearch/model'

class Message < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    
    belongs_to :chat
    index_name "instabug"
    document_type "message"
    settings index: { number_of_shards: 1 } do
        mapping dynamic: false do
          indexes :text_msg, analyzer: 'english'
        end
      end

    def self.search(query)
        __elasticsearch__.search(
            {
                query:{
                    multi_match: {
                        query: query ,
                        fields: [:text_msg,]
                    }
                },

            }
        )
    end

    def as_indexed_json(options=nil)
        self.as_json(only: [:text_msg , :mid])
    end
end
