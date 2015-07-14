class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @settings = Setting.all
  end

  def edit
    @setting = Setting.find(params[:id])
  end

  def update
    @setting = Setting.find(params[:id])

    if @setting.update_attributes(setting_params)
      flash[:success] = 'Setting updated'
      redirect_to settings_path
    else
      render :edit
    end
  end

  private

    def setting_params
      params.require(:setting).permit(:value)
    end
end
