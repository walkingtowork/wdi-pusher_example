class MainController < ApplicationController
  def index
    @message = Message.order("created_at DESC")
  end

  def send_message
    @message = params[:message][:text]

    Message.create(content: @message)

    Pusher['chat'].trigger('new_message', {
      message: @message
    })

    render nothing: true
  end
end
