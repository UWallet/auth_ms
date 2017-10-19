class GroupKeysController < ApplicationController
  before_action :set_group_key, only: [:show, :update_key, :destroy]

  # GET /group_keys
  def index
    @group_keys = GroupKey.all

    render json: @group_keys
  end

  # GET /group_keys/1
  def show
    render json: @group_key
  end

  # POST /group_keys
  def create
    @group_key = GroupKey.new(group_key_params)

    if @group_key.save
      render json: @group_key, status: :created
    else
      render json: @group_key.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /group_keys/update_key
  def update_key
    if @group_key.update(group_key_params)
      render json: @group_key
    else
      render json: @group_key.errors, status: :unprocessable_entity
    end
  end

  # DELETE /group_keys/1
  def destroy
    @group_key.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_key
      @group_key = GroupKey.find_by(user_id: params[:user_id])
    end

    # Only allow a trusted parameter "white list" through.
    def group_key_params
      params.permit(:user_id, :notification_key)
    end
end
