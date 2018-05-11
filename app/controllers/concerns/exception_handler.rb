module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def render_unprocessable_entity_response(exception)
      json_response({ message: exception.record.errors}, :unprocessable_entity)
    end

    def render_not_found_response(exception)
      json_response({ error: exception.message }, :not_found)
    end
  end
end