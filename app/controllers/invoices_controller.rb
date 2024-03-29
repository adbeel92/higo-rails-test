class InvoicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @invoices = collection.result
                          .page(params[:page])
                          .per(params[:per_page])
  end

  private

  def collection
    current_user.invoices
                .includes(:emitter)
                .order(created_at: :desc)
                .ransack(ransack_params)
  end
end
