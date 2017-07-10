class WikiPolicy < ApplicationPolicy
  
  class Scope
    attr_reader :user, :scope
 
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    def destroy?
      user.admin? || record.user == user
    end  
 
    def resolve 
      wikis = []
      if user.role == 'admin'
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.user == user || wiki.users.include?(user)
            wikis << wiki # if the user is premium, only show them public wikis, or the private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # this is the lowly standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.user == user || wiki.users.include?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
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
    user.present? #&& (record.private || record.user.include?(user))
  end
    
  def destroy?
    user.admin? || record.user == user
  end  
end