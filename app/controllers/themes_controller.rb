class ThemesController < ApplicationController
  def index
    @themes = current_user.themes
  end

  def show
    @theme = Theme.find(params[:id])
  end

  def new
    @theme = Theme.new
  end

  def create
    @theme = Theme.new(theme_params)
    @theme.user = current_user
    if @theme.save
      redirect_to theme_path(@theme)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def theme_params
    params.require(:theme).permit(:name, :specs)
  end
end
