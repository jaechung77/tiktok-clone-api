# Purpose
This app is an API of Tiktok-clone site. It provides CRUD and complies with RestFUL approach. 

## ERD
![ERD](https://github.com/jaechung77/tiktok-clone-api/blob/main/ERD%20Final.JPG)

## Database used: PostgreSQL

## Gems used: Carrier Wave, JWT
For JWT, we need to add the code below in ApplciationController
```
class ApplicationController < ActionController::API
    before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, 'yourSecret')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 'yourSecret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
```

In user controller
```
class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  # REGISTER
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end


  def auto_login
    render json: @user
  end

  private

  def user_params
    params.require(:users).permit(:email, :password, :first_name, :last_name, :nick_name)
  end

end
```

For carrier wave settings, please refer to my github page on https://github.com/jaechung77/rails-project#readme 


### Helper functions other than CRUD function, which handles "FOLLOW" in application, are in application_controller.
  Due to HABTM(Has and belongs to many) relation between users and follows table, it does set operation and many more.


