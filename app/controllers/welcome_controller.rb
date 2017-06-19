class WelcomeController < ApplicationController
  
  def index
    @users = User.all
    @wikis = Wiki.all
  end

  def about
  end
  
  private
    def authorize_user
    end
end
