module Response
  def json_response(object, status = :ok)
    render(json: object, status: status)
  rescue StandardError => e
    message = Rails.env.production? ? 'Something is wrong' : e.message
    Rails.logger.error ['Errors:', message].join(' ')
    render(json: { errors: { server_error: message } }, status: :bad_request)
  end

  def serialized_response(serializers: { meta: nil, data: nil, errors: nil }, status: :ok)
    hash = {}

    serializers.each do |key, value|
      next if value.nil?

      if key == :data && value.to_hash.is_a?(Array)
        hash[:items] = value.class < ::Api::V1::BaseResource ? value.to_hash : value
      else
        hash[key] = value.class < ::Api::V1::BaseResource ? value.to_hash : value
      end
    end
    hash = { data: hash } if hash[:data].nil?
    json_response(hash.presence, status)
  end
end
