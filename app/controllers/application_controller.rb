class ApplicationController < ActionController::API
    require 'json_web_token'
    include Response
    include ExceptionHandler
end
