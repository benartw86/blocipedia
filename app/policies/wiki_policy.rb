class WikiPolicy < ApplicationPolicy
  
  class Scope < Scope

    def resolve
      # if admin, all
      # if guest, public
      # if premium, your own + public + collaborating
      # if standard, yours + public +collaborating
      wikis = []
      scope.all.each do |wiki|
        if user.present? && (user.admin? || !wiki.private || wiki.user == user) #wiki.users.include?(user)
          wikis << wiki
        end
      end
      wikis
    end
  end
  
  def show?
    user.admin? || (record.user == user || !record.private) #user is collaborators
  end
  
  #only admin and premium user who owns the private wiki can see it
  #def show?
    #unless user.admin? || record.user == user && @wiki[:private]
    #end
  #end
    
  def create?
    user.present?
  end
  
  def update?
    user.present? # && (record.private || record.user.include?(user))
  end
    
  def destroy?
    user.admin? || record.user == user
  end  
end