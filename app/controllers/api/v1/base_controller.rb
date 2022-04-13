class Api::V1::BaseController < ApplicationController
  extend ActiveSupport::Concern
  include Response

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  rescue_from ActiveRecord::RecordInvalid,
              ActiveRecord::RecordNotDestroyed,
              with: :render_unprocessable_entity

  rescue_from ActiveRecord::LockWaitTimeout, with: -> { render_conflict }

  rescue_from ActionController::ParameterMissing,
              ActionController::UnpermittedParameters,
              with: :render_bad_request

  private

  def render_unprocessable_entity(exception)
    render_with_error(exception.record)
  end

  #TODO ErrorsResource добавить
  def render_with_error(object, status = :unprocessable_entity)
    serialized_response(
      serializers: { errors: ::Api::V1::ErrorsResource.new(object) },
      status: status
    )
  end

  def render_not_found
    json_response({ errors: { non_field_errors: ['resource not found'] } }, :not_found)
  end

  def render_bad_request
    json_response({ errors: { non_field_errors: ['bad request'] } }, :bad_request)
  end

  def render_conflict
    json_response({ errors: { non_field_errors: ['conflict'] } }, :conflict)
  end

  def with_replica(&block)
    ActiveRecord::Base.connected_to(role: :reading, &block)
  end

  def with_primary(&block)
    ActiveRecord::Base.connected_to(role: :writing, &block)
  end
end
