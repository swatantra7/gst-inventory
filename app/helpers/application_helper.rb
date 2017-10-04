module ApplicationHelper

  def is_pdf_request?
    params[:format] == 'pdf'
  end

end
