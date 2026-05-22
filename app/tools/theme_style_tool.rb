class ThemeStyleTool < RubyLLM::Tool
  description "Use this tool when the user attempts to create a theme"
  param :color, desc: "This will be the main background color of the theme. Provide HEX format."

  param :first_text_html, desc: <<~TXT
    Pure HTML markup for the headers. Must contain only valid HTML tags and attributes — no
    inline <style> tags, no <script> tags, and no external resource links. CSS classes and
    IDs may be used freely, as their styles will be defined separately in css_code. Do not
    wrap the output in a full HTML document (no <html>, <head>, or <body> tags) — return
    only the relevant HTML fragment. The headers may read the name of this theme
    received in prompt.
  TXT

  param :first_text_css, desc: <<~TXT
    Pure CSS rules for styling the header. Must contain only valid CSS — no <style> wrapper
    tags, no JavaScript, and no HTML. All selectors should be scoped using the element's
    name as a prefix or class to avoid conflicts (e.g. `.element-name .child`). Do not use
    inline styles or !important unless absolutely necessary. External fonts or resources
    should be imported at the top using @import. YOU MUST NAME THE CSS CLASS FOR THIS HEADER
    "header-1". FOR THE HEADER DONT CREATE A DIV AROUND THE H1, APPLY ALL STYLE DIRECTLY TO THE HEADER
    YOU MUST MAKE THE HEADER AND ITS LETTERING STAND OUT AGAINST THE HEX COLOR WITH A DIFFERENT COLOR.
  TXT

  param :second_text_html, desc: <<~TXT
    Pure HTML markup for the header. Must contain only valid HTML tags and attributes — no
    inline <style> tags, no <script> tags, and no external resource links. CSS classes and
    IDs may be used freely, as their styles will be defined separately in css_code. Do not
    wrap the output in a full HTML document (no <html>, <head>, or <body> tags) — return
    only the relevant HTML fragment. The headers may read the name of this theme
    received in prompt.
  TXT

  param :second_text_css, desc: <<~TXT
    Pure CSS rules for styling the headers. Must contain only valid CSS — no <style> wrapper
    tags, no JavaScript, and no HTML. All selectors should be scoped using the element's
    name as a prefix or class to avoid conflicts (e.g. `.element-name .child`). Do not use
    inline styles or !important unless absolutely necessary. External fonts or resources
    should be imported at the top using @import. DO NOT MAKE THIS HEADER ALL CAPS.
    YOU MUST NAME THE CSS CLASS FOR THIS HEADER "header-2". FOR THE HEADER DONT CREATE A DIV AROUND
    THE H1, APPLY ALL STYLE DIRECTLY TO THE HEADER YOU MUST MAKE THE HEADER AND ITS LETTERING STAND
    OUT AGAINST THE HEX COLOR WITH A DIFFERENT COLOR.
  TXT

  param :button_html, desc: <<~TXT
    Pure HTML markup for the button. Must contain only valid HTML tags and attributes — no
    inline <style> tags, no <script> tags, and no external resource links. CSS classes and
    IDs may be used freely, as their styles will be defined separately in css_code. Do not
    wrap the output in a full HTML document (no <html>, <head>, or <body> tags) — return
    only the relevant HTML fragment. YOU MUST MAKE THE BUTTON STAND OUT AGAINST THE BACKGROUND.
  TXT

  param :button_css, desc: <<~TXT
    Pure CSS rules for styling the button. Must contain only valid CSS — no <style> wrapper
    tags, no JavaScript, and no HTML. All selectors should be scoped using the element's
    name as a prefix or class to avoid conflicts (e.g. `.element-name .child`). Do not use
    inline styles or !important unless absolutely necessary. External fonts or resources
    should be imported at the top using @import. The button may read the name of this theme
    received in prompt. YOU MUST NAME THE CSS CLASS FOR THIS BUTTON "button-1".
  TXT

  param :theme_id, desc: "This is the ID of the theme which will be provided in the prompt"

  def execute(color:, first_text_html:, first_text_css:, second_text_html:, second_text_css:, button_html:,
              button_css:, theme_id:)
    text_style = Element.new(
      name: "Header 1",
      html_code: first_text_html,
      css_code: first_text_css,
      theme_id: theme_id
    )
    text_style_two = Element.new(
      name: "Header 2",
      html_code: second_text_html,
      css_code: second_text_css,
      theme_id: theme_id
    )
    button = Element.new(
      name: "Button",
      html_code: button_html,
      css_code: button_css,
      theme_id: theme_id
    )
    theme = Theme.find(theme_id)
    theme.background = color
    theme.save
    if text_style.save && text_style_two.save && button.save
      { success: true }
    else
      { success: false,
        errors: text_style.errors.full_messages + text_style_two.errors.full_messages + button.errors.full_messages }
    end
  end
end
