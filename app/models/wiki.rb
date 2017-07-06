class Wiki < ActiveRecord::Base
    
  validates :title, 
            presence: true, 
            length: { minimum: 3 }
      
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators, source: :user
end  
