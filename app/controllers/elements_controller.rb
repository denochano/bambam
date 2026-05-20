class ElementsController < ApplicationController
  def create
    @theme = Theme.find(params[:theme_id])
    @element = Element.new(element_params)
    @element.theme = @theme
    if @element.save
      redirect_to element_path(@element)
    else
      render "themes/show", status: 422
    end
  end

  def show
    @element = Element.find(params[:id])
  end

  private

  def element_params
    params.require(:element).permit(:name, messages_attributes: %i[content role _destroy])
  end
end
