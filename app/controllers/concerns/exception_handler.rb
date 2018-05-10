module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message.error }, e.message.status)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message.error }, e.message.status)
    end
  end
end