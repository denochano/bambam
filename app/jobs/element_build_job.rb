class ElementBuildJob < ApplicationJob
  queue_as :default

  def perform(theme, message)
    theme_context = "You are creating a new component under a user definined theme with the (theme_id: #{theme.id}) called #{theme.name} with a description of #{theme.specs}"
    ruby_llm_chat = RubyLLM.chat(model: "claude-sonnet-4-6")
    ruby_llm_chat.with_tool(CreateElementTool)
    ruby_llm_chat.with_instructions("#{Element.system_prompt}\n#{theme_context}")
    ruby_llm_chat.ask(message)
  end
end
