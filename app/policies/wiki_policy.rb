class WikiPolicy < ApplicationPolicy
    def  index?
        user.present?
    end
end