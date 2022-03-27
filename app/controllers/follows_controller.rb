class FollowsController < ApplicationController
    skip_before_action :authorized, only: [:index, :show, :create, :update, :destroy]
    before_action :follow_status, :accept_status, :requested_status, :friends_status

    def index
      @follows = Follow.all
      render json: @follows
    end

    def find
      id = Follow.find_by("followee_id = ? AND follower_id = ?", params[:followee_id], params[:follower_id])
      if id.nil?
        id = Follow.find_by("followee_id = ? AND follower_id = ?", params[:follower_id], params[:followee_id])
      end
      render json: id
    end

    def show_friends
      render json: friends_status
    end

    def show_requested
      render json: requested_status
    end

    def show_to_accept
      render json: accept_status
    end

    def show_relationship
      relationship = requested_status + accept_status + friends_status
      render json: relationship
    end  

    def show_to_follow
      render json: follow_status
    end

    def show_all
      all_status = friends_status + requested_status + accept_status + follow_status
      render json: all_status
    end  

    # follow /follows
    def create
      @follow = Follow.new(follow_params)
      registered = false
      if Follow.where("followee_id = ? AND follower_id = ?", @follow.followee_id, @follow.follower_id).count > 0
        registered = true
      end 
      # byebug
      if !registered && @follow.save
        render json: @follow, status: :created
      else
        render json: @follow.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /follows/1
    def update
      @follow = Follow.find(params[:id])
      if @follow.update(follow_params)
        render json: @follow
      else
        render json: @follow.errors, status: :unprocessable_entity
      end
    end

    # DELETE /follows/1
    def destroy
      @follow = Follow.find(params[:id])
      @follow.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
    def set_follow
    @follow = Follow.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def follow_params
    params.require(:follow).permit(:followee_id, :follower_id, :status, :followee_nick_name, :follower_nick_name)
    end
end
