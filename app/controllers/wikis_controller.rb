class WikisController < ApplicationController
  
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  def index
    @wikis = policy_scope(Wiki)  
  end 
  
  def create
    
    @wiki = current_user.wikis.build(wiki_params)
   # or
    #@wiki = Wiki.new(wiki_params)
    #@wiki.user = current_user
    #authorize(@wiki)
    
    if @wiki.save
        
      flash[:notice] = "Your wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "Error.  Your wiki was not saved."
      render :new
    end
  end
  
  def destroy 
    authorize(@wiki)
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting your wiki."
      render :show
    end
  end
  
  def show
    #authorize(@wiki)
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @user = current_user
    @wiki = Wiki.find(params[:id])
    @user_emails = User.where.not(id: current_user.id || @wiki.users.pluck(:id))
  end
  
  def update
    
    authorize(@wiki)
    if @wiki.update_attributes(wiki_params)
      
      flash[:notice] = "Your wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "Error.  Your wiki was not updated."
      render :edit
    end
  end
  
  def user_wikis
    @wikis = current_user.wikis
  end
  
  private
    
    def wiki_params
      params.require(:wiki).permit(:title, :body, :private)
    end
    
    #use private method to avoid repetition above, example of strong paramaters to avoid repetition and keep model safe
    def set_wiki
      @wiki = Wiki.find(params[:id])
    end
end


#if session[:user_id] != @wiki.user_id
#      flash[:notice] = "Sorry!"
#      redirect_to wikis_path
#    end