class UsersController < ApplicationController
    before_action :authorized, only: [:auto_login]

    # REGISTER
    def create
      user = User.find_by(email: params[:email])
      unless user
        valid_user = User.create(user_params)
      end
      if valid_user.present?
        token = encode_token({user_id: valid_user.id})
        render json: {user: valid_user.nick_name, token: token}
      else
        render json: {error: "Can't create an account"}, status: :unprocessable_entity
      end
    end

    def self.create_user_for_google(data)
      where(uid: data["email"]).first_or_initialize.tap do |user|
        user.provider="google_oauth2"
        user.email=data["email"]
        user.password="12341234"
        user.nick_name=data["email"]
        user.save!
      end
      set_headers(tokens)
      render json: { status: 'Signed in successfully with google'}
    end

    # LOGGING IN
    def login
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        token = encode_token({user_id: @user.id})
        render json: {user: @user.nick_name, token: token, id: @user.id}
      else
        render json: {error: "Invalid username or password"}, status: :unprocessable_entity
      end
    end

    def auto_login
      render json: @user.nick_name
    end

    def password_change
      @user = User.find(params[:id])
      if @user && @user.authenticate(params[:password])
        @user.password = params[:new_password]
        @user.save
        render json: {user: @user.nick_name, id: @user.id}
      else
        render json: {error: "Password is incorrect"}, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:email, :password, :nick_name)
    end

    def set_headers(tokens)
      headers['access-token'] = (tokens['access-token']).to_s
      headers['client'] =  (tokens['client']).to_s
      headers['expiry'] =  (tokens['expiry']).to_s
      headers['uid'] =@user.id
      headers['token-type'] = (tokens['token-type']).to_s
    end
end
