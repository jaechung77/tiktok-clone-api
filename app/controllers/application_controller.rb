class ApplicationController < ActionController::API
  # protect_from_forgery except: :create
  # before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, '12341234')
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
        JWT.decode(token, '12341234', true, algorithm: 'HS256')
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

  def follow_status
    set_follows = []
    set_posts = []
    difference_set = []
    status_inserted_set = []
    set_follows = requested_status + accept_status + friends_status

    set_posts = Post.all

    difference_set = set_posts - set_follows | set_follows - set_posts 

    difference_set.map do |difference|
      user = User.find(difference["user_id"])
      difference["status"] = 1
      difference["nick_name"] = user.nick_name
      status_inserted_set << difference
    end
    return status_inserted_set
  end

  def accept_status
    followee_id = params[:id]
    follower_id = params[:id]
    accept_status = Follow.where("follower_id = ? AND status = 2", follower_id)
    accept_status_arr = []
    accept_status.map do |follow|
      hash = Post.find_by("user_id= ?", follow.followee_id)
      user = User.find(follow.followee_id)
      hash[:status] = 3
      hash[:nick_name] = user.nick_name
      accept_status_arr << hash
    end
    return accept_status_arr
  end

  def requested_status
    followee_id = params[:id]
    follower_id = params[:id]
    requested_status = Follow.where("followee_id = ? AND status = 2", followee_id)
    requested_status_arr = []
    requested_status.map do |follow|
      hash = Post.find_by("user_id= ?", follow.follower_id)
      user = User.find(follow.follower_id)
      hash[:status] = 2
      hash[:nick_name] = user.nick_name
      requested_status_arr << hash
    end
    return requested_status_arr
  end

  def friends_status
    followee_id = params[:id]
    follower_id = params[:id]
    friends_status = Follow.where("(follower_id = ? AND status = 4) 
    OR (followee_id = ? AND status = 4)", follower_id, followee_id)

    friends_status_arr = []
    key_val = ""
    friends_status.map do |follow|
      if params[:id].to_i == follow.follower_id 
        key_val = follow.followee_id
      elsif params[:id].to_i ==follow.followee_id
        key_val = follow.follower_id
      end
      hash = Post.find_by("user_id= ?", key_val)
      user = User.find(key_val)
      hash[:status] = 4
      hash[:nick_name] = user.nick_name
      friends_status_arr << hash
    end
    return friends_status_arr
  end
end
