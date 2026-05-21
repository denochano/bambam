class MessagesController < ApplicationController
  def create
    @element = Element.find(params[:element_id])

    @message = @element.messages.build(message_params)

    @message.role = "user"

    if @message.save

      @element.messages.create(
        role: "assistant",
        content: "This is a fake AI response for now."
      )

      redirect_to element_path(@element)

    else
      @messages = @element.messages.order(:created_at)

      render "elements/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
