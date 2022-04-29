require 'json'

class PostsController < ApplicationController
    skip_before_action :authorized, only: [:index, :show, :create, :update, :destroy, :mypost, :find]
    before_action :follow_status, :accept_status, :requested_status, :friends_status

    # GET /posts
    def index
      @posts = Post.select('posts.*, users.nick_name').joins(:user).order('posts.created_at').reverse_order
      render json: @posts
    end

    # GET /posts/1
    def show
      @post = Post.find(params[:id])
      render json: @post
    end

    def mypost
      @posts = Post.where("user_id = ?", params[:id])
      render json: @posts
    end

    # POST /posts
    def create
      byebug
      @post = Post.new(post_params)
      @post.likes = 0
      @post.viewer = 0

      if @post.save
        render json: @post, status: :created, location: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /posts/1
    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def find
      all_status = friends_status + requested_status + accept_status + follow_status
      posts = []
      all_status.map do |status|
        if status.nick_name.downcase.include? params[:nick_name].downcase
          posts << status
        end
      end
      render json: posts
    end  

    # DELETE /posts/1
    def destroy
      @post = Post.find(params[:id])
      @post.destroy
    end

    def likes
      @post = Post.find(params[:id])
      @post.likes = @post.likes + 1
      @post.save
    end

    def show_likes
      @post = Post.find(params[:id])
      @likes = @post.likes
      render json: @likes
    end

    def shares
      @post = Post.find(params[:id])
      @post.viewer = @post.viewer + 1
      @post.save
    end

    def show_shares
      @post = Post.find(params[:id])
      @viewers = @post.viewer
      render json: @viewers
    end

    private
      # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :content, :file, :image, :likes, :viewer, :comment_flag, :user_id, :status, :hashtags_attributes => [:tag, :post_id] )
    end
  end
