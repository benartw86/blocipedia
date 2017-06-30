class ChargesController < ApplicationController
  include ApplicationHelper
  
  def new
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "BigMoney Membership - #{current_user.email}",
     amount: 1500
    }
  end
  
  def create
      
    @user = current_user  
    #create a Stripe Customer object, for associating with the charge
  
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
 
   # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: 1500,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )
    
    User.upgrade_role(@user)
 
    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to root_path # or wherever
 
   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
  
  #loop through the wikis of the user and change the private attribute to false
  
  def downgrade
    @user = current_user
    
    User.publicize_wikis(@user)
    
    User.downgrade_role(@user)
    
    flash[:notice] = "You have successfully downgraded to standard, #{current_user.email}! Become premium again below."
    redirect_to root_path
  end
end
