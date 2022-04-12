# frozen_string_literal: true

module RansackParams
  extend ActiveSupport::Concern

  included do
    def initialize_ransack
      params[:q] ||= {}
    end

    def ransack_params
      initialize_ransack && params[:q]
    end
  end
end
