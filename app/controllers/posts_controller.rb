class PostsController < ApplicationController

  before_filter :authenticate_poster, :only => [:new]
  
  def authenticate_poster
    unless current_user
      unauthorized
    else
      unless current_user == admin
        unauthorized
      end
    end
  end
  
  def unauthorized
    flash[:notice] = "you may not access that"
    redirect_to posts_path
  end

  def index
    @posts = Post.order('created_at DESC')
    @recent_posts = @posts.limit(5)
    @posts = @posts.paginate(:page => params[:page], :per_page => 5)
    @comment = Comment.new
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.create(params[:post])
    if @post.save
      redirect_to posts_path
    else
      flash[:warning] = "post fail."
    end
  end
  
  def show
    @posts = Post.find(params[:id])
    @recent_posts = Post.order('created_at DESC').limit(5)
    @comment = Comment.new
    render 'index'
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end

end