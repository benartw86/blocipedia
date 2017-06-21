class WikiPolicy < ApplicationPolicy
  def index?
    user.present?
  end
    
  def create?
    user.present?
  end
  
  def update?
    user.present? && authorize(@record)
  end
    
  def destroy?
    user.admin? || record.user == user
  end  
end