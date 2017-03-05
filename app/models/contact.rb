# We don't have to explicitly tell Rails that we want name, email, comments, etc.
# Rails will automatically go into db/schema to see what we want in it
# If we want any restrictions on our fields (e.g. limit to 200 chars, @, etc.),
# we should put this in our Contact class

class Contact < ActiveRecord::Base
  # Contact form validations - only send if someone fills out everything
  validates :name, presence: true
  validates :email, presence: true
  validates :comments, presence: true
end
