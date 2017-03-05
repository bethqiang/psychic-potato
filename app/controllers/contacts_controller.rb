class ContactsController < ApplicationController
  def new
    # Every time someone pulls up our comments form, Rails will create a new
    # blank contact object
    # Store it in the contact variable
    # @ indicates instance variable
    @contact = Contact.new
  end

  # Whenever you want to save to db, use create
  def create
    # Contact object is re-assigning to the fields
    # Mass assigment - multiple values being assigned
    @contact = Contact.new(contact_params)
    if @contact.save
      # If the save is successful
      # Grab the name, email, and comments and store them in these variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      # Rails methods
      ContactMailer.contact_email(name, email, body).deliver
      # Then show the client the success message & refresh the page
      flash[:success] = "Message sent."
      redirect_to new_contact_path
    else
      # Errors will be in an array format
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end

  # "Strong parameters"
  # Security - whitelist these 3 fields as being able to be mass-assigned
  # Private methods are designed to only to be used inside your file
  private # or protected
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end