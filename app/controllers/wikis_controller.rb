class WikisController < ApplicationController
  
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  def index
    @wikis = Wiki.all
    authorize(@wikis)
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
    
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting your wiki."
      render :show
    end
  end
  
  def show
  end

  def new
    @wiki = Wiki.new
  end

  def edit
  end
  
  def update
    
    if @wiki.update_attributes(wiki_params)
      
      flash[:notice] = "Your wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "Error.  Your wiki was not updated."
      render :edit
    end
  end
  
  private
    
    def wiki_params
      params.require(:wiki).permit(:title, :body)
    end
    
    #use private method to avoid repetition above, example of strong paramaters to avoid repetition and keep model safe
    def set_wiki
      @wiki = Wiki.find(params[:id])
    end
end
