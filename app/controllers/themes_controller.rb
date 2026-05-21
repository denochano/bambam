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
      theme_style_creation
      redirect_to theme_path(@theme)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def theme_params
    params.require(:theme).permit(:name, :specs)
  end

  def theme_style_creation
    ruby_llm_chat = RubyLLM.chat(model: "claude-sonnet-4-6")
    ruby_llm_chat.with_tool(ThemeStyleTool)
    ruby_llm_chat.with_instructions("#{Theme.system_prompt}\n#{theme_context}")
    ruby_llm_chat.ask(theme_params[:specs]).content
  end

  def theme_context
    "This is a theme called #{@theme.name} with (theme_id: #{@theme.id}) with a description of #{@theme.specs}"
  end
end
