class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show update destroy ]

  # GET /messages
  def index
    if params[:search].present?
      @messages = Message.search(params[:search])
    else
    @messages = Message.all
    end
    render json: @messages
  end

  # GET /messages/1
  def show
    render json: @message
  end

  # POST /messages
  def create

    @msg = Message.new
    @mid = reterive_last_msg_id params[:chat_id]
    @msg.text_msg= params[:txt]
    @app = App.find_by_token params[:token]
    @chat = Chat.where(:cid => params[:chat_id]).where(:app_id => @app.id)[0]
    
    
    @chat_id = @chat.id
    @msg.chat_id= @chat_id
    AddMessageJob.perform_now(text: params[:text_msg] , mid: @mid , chat_id: @chat_id)
    render json: @msg, status: :created
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:text_msg)
    end
    def reterive_last_msg_id(app_token)
      $redis.incr("message_count_$#{app_token}")
    end
end