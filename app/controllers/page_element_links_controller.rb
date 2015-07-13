class PageElementLinksController < ApplicationController
  before_action :authenticate_user!

  def show
    @page_element_link = PageElementLink.find(params[:id])
  end

  def edit
    @page_element_link = PageElementLink.find(params[:id])
    cookies[:referrer] = request.referrer
  end

  def update
    @page_element_link = PageElementLink.find(params[:id])

    if @page_element_link.update_attributes(page_element_link_params)
      flash[:success] = 'Link updated'
      redirect_to cookies[:referrer]
    else
      render :edit
    end
  end

  private

    def page_element_link_params
      params.require(:page_element_link).permit(:text, :link)
    end
end
