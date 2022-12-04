class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show update destroy ]

  # GET /chats
  def index
    @chats = Chat.all

    render json: @chats
  end

  # GET /chats/1
  def show
    render json: @chat
  end

  # POST /chats
  def create

    @chat = Chat.new
    @cid = reterive_last_app_id params[:app_id]
    @app = App.find_by_token params[:app_id]
    @chat.cid= @cid
    @chat.app_id = @app.id
    AddChatJob.perform_now(cid: @cid , app_id: @app.id)

    render json: @chat, status: :created
  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(chat_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    @chat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:messsage_count)
    end
    
    def reterive_last_app_id(app_token)
      $redis.incr("chat_count_#{app_token}")
    end
end
