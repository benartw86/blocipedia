class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  enum role: [:standard, :premium, :admin]
         
  has_many :wikis
  
  #method to change the role attribute for the current user.  Link included in index view page.  Perhaps this method should be a Role controller that can direct
  #to a page where you can choose your role?
  
  def self.upgrade_role(user)
    user.premium!  
  end
  
  def self.downgrade_role(user)
    user.standard!
  end
  
   def self.publicize_wikis(user)   
      user.wikis.where(private: true) do |wiki|
        wiki.private = false
        wiki.save
    end
  end
end
