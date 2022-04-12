class InvoiceProcessorsController < ApplicationController
  before_action :authenticate_user!

  def index
    @invoice_processors = current_user.invoice_processors.includes(:invoice, file_attachment: :blob)
  end

  def upload
    Invoices::Operations::FilesUploader.run(
      user: current_user,
      files: uploader_params[:files],
      file_type: uploader_params[:file_type]
    )
    flash[:notice] = 'Processing uploads'
    redirect_to invoice_processors_path
  end

  private

  def uploader_params
    params.require(:invoice_processor).permit(:file_type, files: [])
  end
end

