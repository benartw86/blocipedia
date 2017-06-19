class WikiPolicy < ApplicationPolicy
  def index?
    user.present?
  end
    
  def create?
    user.present?
  end
    
  def destroy?
    user.admin? || user.present?
  end  
end