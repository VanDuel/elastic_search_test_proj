Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: ENV.fetch('ELASTICSEARCH_URL', 'http://localhost:9200'),
  request_timeout: Integer(ENV.fetch('ELASTICSEARCH_REQUEST_TIMEOUT', 5))
)
