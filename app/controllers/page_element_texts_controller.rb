class PageElementTextsController < ApplicationController
  before_action :authenticate_user!

  def show
    @page_element_text = PageElementText.find(params[:id])
  end

  def edit
    @page_element_text = PageElementText.find(params[:id])
    cookies[:referrer] = request.referrer
  end

  def update
    @page_element_text = PageElementText.find(params[:id])

    if @page_element_text.update_attributes(page_element_text_params)
      flash[:success] = 'Text updated'
      redirect_to cookies[:referrer]
    else
      render :edit
    end
  end

  private

    def page_element_text_params
      params.require(:page_element_text).permit(:value)
    end
end
