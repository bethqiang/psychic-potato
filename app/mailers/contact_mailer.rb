class ContactMailer < ActionMailer::Base
  default to: 'beth@bethqiang.com'

  def contact_email(name, email, body)
    # Variable assignment
    @name = name
    @email = email
    @body = body
    # Default settings
    mail(from: email, subject: 'Contact Form Message')
  end
end