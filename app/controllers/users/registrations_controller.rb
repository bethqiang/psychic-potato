class Users::RegistrationsController < Devise::RegistrationsController
  # Only for a new action (when someone is trying to sign up), run the select_plan function
  before_action :select_plan, only: :new

  def create
    # Extend default Devise gem behavior so that users signing up with the Pro account
    # save with a special Stripe subscription function
    # Otherwise Devise signs up user as usual
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end

  # In case someone attempts to type plan=3 or some nonsense like that into the URL
  # private -> when you don't plan on using the function outside the file
  private
    def select_plan
      unless(params[:plan] == '1' || params[:plan] == '2')
        flash[:notice] = "Please select a membership plan to sign up."
        redirect_to root_url
      end
    end
end