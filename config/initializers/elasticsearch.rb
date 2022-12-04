Elasticsearch::Model.client = Elasticsearch::Client.new log: true, host: 'localhost:9200', retry_on_failure: true
