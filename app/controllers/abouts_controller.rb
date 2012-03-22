class AboutsController < ApplicationController

  respond_to :html, :json
 
  def index
    @about_graphs = About.where(:genre => "paragraph")
    @about_faqs = About.where(:genre => "FAQ")    
    @about = About.new
  end
  
  
  def new
  end
  def create
    @about = About.new(params[:about])
    if @about.save
      flash[:notice] = "About section created."
      redirect_to abouts_path
    else
      render 'index'
    end
  end
  def edit
  end
  def update
    @about = About.find(params[:id])
    @about.update_attributes(params[:about])
    respond_with @about
  end
  
  def destroy
  end



end