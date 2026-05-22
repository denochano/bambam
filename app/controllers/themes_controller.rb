class ThemesController < ApplicationController
  def index
    @themes = current_user.themes
  end

  def show
    @theme = Theme.find(params[:id])
    @element = Element.new
    @element.messages.build
  end

  def new
    @theme = Theme.new
  end

  def create
    @theme = Theme.new(theme_params)
    @theme.user = current_user
    if @theme.save
      # theme_style_creation (Move to backgroud job - ai-build)
      AiBuildJob.perform_later(@theme)
      redirect_to themes_path, notice: "Theme creation in progress..."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def theme_params
    params.require(:theme).permit(:name, :specs)
  end
end
