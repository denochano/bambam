class MessagesController < ApplicationController
  def create
    @element = Element.find(params[:element_id])

    @message = @element.messages.build(message_params)

    @message.role = "user"

    if @message.save
      AiUpdateJob.perform_later(@message)
      # response = llm_element_update

      redirect_to element_path(@element), notice: "Updating in progress..."

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
