class InvoicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @invoices = current_user.invoices
  end

  def create
    uploader = Invoices::Operations::XmlUploader.new(
      user: current_user,
      xml_file: xml_file
    )
    if uploader.run
      flash[:notice] = 'Successfully XML uploaded'
    else
      flash[:danger] = uploader.error_message
    end
    redirect_to invoices_path
  end

  private

  def xml_file
    params[:xml_file]
  end
end
