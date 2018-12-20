module Saas
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception

    helper_method :current_subscriber
  end
end
