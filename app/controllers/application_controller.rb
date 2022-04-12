class ApplicationController < ActionController::Base
  include RansackParams

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |type|
      type.all  { render nothing: true, status: :not_found }
    end
  end
end
