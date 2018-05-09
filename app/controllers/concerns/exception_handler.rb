module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: "Couldn't find user" }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do
      json_response({ message: "Invalid JSON" }, :bad_request)
    end
  end
end