class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :update_money, :get_money, :get_identification, :verify_pass]
  before_action :authenticate_request!, only:[:show, :update, :get_user, :verify_pass]



  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    if @current_user.id == params[:id].to_i
      get_user
    else
      renderError("Forbidden",403,"current user has no access")
    end
  end

  # POST /users
  def create
      @user = User.new(user_params)
    if @user.save
      UserNotifierMailer.send_signup_email(@user).deliver
      head 201
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def get_money
    if @user
      render json: {money: @user.money}, status: 200
    else
      renderError("Not Found",404,"User dont exists")
    end
  end

  def get_identification
    if @user
      render json: {identification: @user.identification}, status: 200
    else
      renderError("Not Found",404,"User not found")
    end
  end

  # PATCH/PUT /users/1
  def update
    if @current_user.id == params[:id].to_i
      if (!user_params[:email]) && ( !user_params[:firstName]) && (!user_params[:lastName])
        if @user.update(user_params)
          head 204
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      else
        renderError("Not acceptable",406,"Only password can be updated")
      end
    else
      renderError("Forbidden",403,"current user has no access")
    end
  end

  def update_money
    if @user
      if (!user_params[:email]) && (!user_params[:firstName]) && (!user_params[:lastName])&&(!user_params[:password]) && (!user_params[:password_confirmation])
        if @user.update(user_params)
          head 204
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      else
        renderError("Not acceptable",406,"Only money can be updated")
      end
    else
        renderError("Not Found",404,"User not found")
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def login
    user = User.find_by(email: params[:email].to_s.downcase)
    if user && user.authenticate(params[:password])
      #if user.confirmed_at?
        auth_token = JsonWebToken.encode({user_id: user.id})
        render json: {auth_token: auth_token}, status: :ok
      #else
      #  renderError("Unauthenticated",401,"Email not verified")
      #end
    else
      renderError("Unauthenticated",401,"Invalid username / password")
    end
  end

  def get_user
    render json: {id: @current_user.id,
                  firstName: @current_user.firstName,
                  lastName: @current_user.lastName,
                  email: @current_user.email,
                  money: @current_user.money}
  end

  def search_user
    user=User.find_by(id: params[:id])
    if user
      renderError("Success",200,"The user exists")
    else
      renderError("Not found",404,"The user does not exists")
    end
  end


  def confirm
    token = params[:token].to_s
    user = User.find_by(confirmation_token: token)
    if user.present? && user.confirmation_token_valid?
      user.mark_as_confirmed!
      UserNotifierMailer.send_confirm_email(user).deliver
      render json: "Email succesfully confirmed", status: :ok
    else
      renderError("Not found",404,"Invalid token")
    end
  end

  def verify_pass
    if @user.authenticate(params[:password])
      renderError("Success",200,"password is correct")
    else
      renderError("Unauthenticated",401,"Invalid password")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if !(Integer(params[:id]) rescue false)
        renderError("Not Acceptable (Invalid Params)", 406, "The parameter id is not an integer")
        return -1
      end
      if @user = User.find(params[:id])
        return @user
      else
        renderError("Not found",404,"User not found")
      end
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:firstName, :lastName, :money, :email, :token, :password, :password_confirmation, :identification)
    end
end
