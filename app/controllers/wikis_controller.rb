class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end
  
  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title] 
    @wiki.body = params[:wiki][:body]
    
    if @wiki.save
      
      flash[:notice] = "Your wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "Error.  Your wiki was not saved."
      render :new
    end
  end
  
  def destroy 
    @wiki = Wiki.find(params[:id])
    
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting your wiki."
      render :show
    end
  end
  
  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    
    if @wiki.save
      
      flash[:notice] = "Your wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "Error.  Your wiki was not saved."
      render :new
    end
  end
end
