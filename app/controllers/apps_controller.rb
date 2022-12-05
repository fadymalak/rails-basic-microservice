class AppsController < ApplicationController
  before_action :set_app, only: %i[ show update destroy ]

  # GET /apps
  def index
    @apps = App.all

    render json: @apps
  end

  # GET /apps/1
  def show
    render json: @app
  end

  # POST /apps
  def create
    @app = App.new(app_params)
    @token = SecureRandom.urlsafe_base64(18)
    @app.token=@token
    if @app.save
      render json: @app, status: :created, location: @app
    else
      render json: @app.errors, status: :unprocessable_entity
    end
  end



  
  # "id": 1,
  # "name": "asdasD",
  # "token": "uERDjBeI2Yz2KqgLwjJLVNia",
  # "chats_count": 0,
  # "created_at": "2022-12-04T19:54:07.128Z",
  # "updated_at": "2022-12-04T19:54:07.128Z"
# }
  # PATCH/PUT /apps/1
  def update
    if @app.update(app_params)
      render json: @app
    else
      render json: @app.errors, status: :unprocessable_entity
    end
  end

  # DELETE /apps/1
  def destroy
    @app.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = App.find_by_token(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def app_params
      params.require(:app).permit(:name)
    end

end
