require "json"

class ElementsController < ApplicationController
  def create
    @theme = Theme.find(params[:theme_id])
    @element = Element.new(element_params)
    @element.theme = @theme

    reply = JSON.parse(llm_element_creation)
    @element.html_code = reply["html_code"]
    @element.css_code = reply["css_code"]
    params[:element][:messages_attributes]["0"][:html_code] = @element.html_code
    params[:element][:messages_attributes]["0"][:css_code] = @element.css_code
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
    # params.require(:element).permit(:name, messages_attributes: %i[content role _destroy])
    params.require(:element).permit(:name, messages_attributes: %i[content role html_code css_code _destroy])
  end

  def llm_element_creation
    ruby_llm_chat = RubyLLM.chat(model: "claude-sonnet-4-6")
    ruby_llm_chat.with_instructions("#{Element.system_prompt}\n#{theme_context}")
    ruby_llm_chat.ask(element_params[:messages_attributes]["0"][:content]).content
  end

  def theme_context
    "The user has named the theme for this element #{@theme.name} and provided this element will be: #{@theme.specs}"
    # '
    # THEME: Early 2000s ("Web 2.0" era)

    # The optimistic, glossy web aesthetic of roughly 2003–2008. Defining traits:

    # - Color: bright, saturated, candy-like palettes—sky blues, lime greens, hot oranges. Lots of white space with one or two punchy accent colors.
    # - Surfaces: glassy "aqua/gel" buttons with vertical gradients and a glossy highlight across the top half. Reflective sheen, subtle inner glows.
    # - Depth: heavy use of soft drop shadows, beveled/embossed edges, and gradients to make everything feel 3D and clickable. Nothing is flat.
    # - Shape: generously rounded corners, pill-shaped buttons, rounded rectangular panels.
    # - Decoration: starburst/sticker badges ("New!", "Beta"), reflective floor effects under logos, faint diagonal pinstripe or gradient backgrounds.
    # - Typography: clean sans-serifs (Verdana, Tahoma, Lucida Grande, Helvetica), often with a subtle drop shadow or gradient on headings. Mixed sizes, friendly and rounded feeling.
    # - Mood: glossy, friendly, energetic, slightly skeuomorphic—everything looks tactile and polished, like a candy-coated app.
    # '
  end
end
