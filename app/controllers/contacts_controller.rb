class ContactsController < ApplicationController
  def new
    # GET reqeust to /contact-us
    # Show new contact form
    # Every time someone pulls up our comments form, Rails will create a new
    # blank contact object
    # Store it in the contact variable
    # @ indicates instance variable
    @contact = Contact.new
  end

  # POST request /contacts
  # Whenever you want to save to db, use create
  def create
    # Contact object is re-assigning to the fields
    # Mass assigment of form fields into Contact object
    @contact = Contact.new(contact_params)
    # Save the Contact object to the database
    if @contact.save
      # If the save is successful
      # Grab the name, email, and comments from the parameters
      # and store them in these variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      # Plug variables into Contact Mailer email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      # Store success message in flash hash and redirect to new action
      flash[:success] = "Message sent."
      redirect_to new_contact_path
    else
      # If Contact object doesnt save, store errors in flash hash
      # and redirect to new action
      # Errors will be in an array format
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end

  # "Strong parameters"
  # Whitelist these 3 fields as being able to be mass-assigned
  # THIS IS REQUIRED
  # Private methods are designed to only to be used inside your file
  private # or protected
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end