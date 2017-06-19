class WelcomePolicy < ApplicationPolicy
  def index?
    user.present? || user.present == false 
  end
  
  def about?
    user.present? || user.present == false 
  end