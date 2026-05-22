class AiBuildJob < ApplicationJob
  queue_as :default

  def perform(theme)
    theme_context = "This is a theme called #{theme.name} with (theme_id: #{theme.id}) with a description of #{theme.specs}"
    ruby_llm_chat = RubyLLM.chat(model: "claude-sonnet-4-6")
    ruby_llm_chat.with_tool(ThemeStyleTool)
    ruby_llm_chat.with_instructions("#{Theme.system_prompt}\n#{theme_context}")
    ruby_llm_chat.ask(theme.specs)
  end
end
