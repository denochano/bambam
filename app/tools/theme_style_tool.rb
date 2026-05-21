class ThemeStyleTool < RubyLLM::Tool
  description "Use this tool when the user attempts to create a theme"
  param :color, desc: "This will be the main background color of the theme. Provide HEX format."

  param :text_html, desc: <<~TXT
    Pure HTML markup for the h1 and h2. Must contain only valid HTML tags and attributes — no
    inline <style> tags, no <script> tags, and no external resource links. CSS classes and
    IDs may be used freely, as their styles will be defined separately in css_code. Do not
    wrap the output in a full HTML document (no <html>, <head>, or <body> tags) — return
    only the relevant HTML fragment. The h1 and h2 may read the name of this theme
    received in prompt.
  TXT

  param :text_css, desc: <<~TXT
    Pure CSS rules for styling the h1 and h2. Must contain only valid CSS — no <style> wrapper
    tags, no JavaScript, and no HTML. All selectors should be scoped using the element's
    name as a prefix or class to avoid conflicts (e.g. `.element-name .child`). Do not use
    inline styles or !important unless absolutely necessary. External fonts or resources
    should be imported at the top using @import.
  TXT

  param :button_html, desc: <<~TXT
    Pure HTML markup for the button. Must contain only valid HTML tags and attributes — no
    inline <style> tags, no <script> tags, and no external resource links. CSS classes and
    IDs may be used freely, as their styles will be defined separately in css_code. Do not
    wrap the output in a full HTML document (no <html>, <head>, or <body> tags) — return
    only the relevant HTML fragment.
  TXT

  param :button_css, desc: <<~TXT
    Pure CSS rules for styling the button. Must contain only valid CSS — no <style> wrapper
    tags, no JavaScript, and no HTML. All selectors should be scoped using the element's
    name as a prefix or class to avoid conflicts (e.g. `.element-name .child`). Do not use
    inline styles or !important unless absolutely necessary. External fonts or resources
    should be imported at the top using @import. The button may read the name of this theme
    received in prompt.
  TXT

  param :theme_id, desc: "This is the ID of the theme which will be provided in the prompt"

  def execute(color:, text_html:, text_css:, button_html:, button_css:, theme_id:)
    text_style = Element.new(
      name: "Text style",
      html_code: text_html,
      css_code: text_css,
      theme_id: theme_id
    )
    button = Element.new(
      name: "Simple button",
      html_code: button_html,
      css_code: button_css,
      theme_id: theme_id
    )
    theme = Theme.find(theme_id)
    theme.background = color
    theme.save
    if text_style.save && button.save
      { success: true }
    else
      { success: false, errors: text_style.errors.full_messages + button.errors.full_messages }
    end
  end
end
