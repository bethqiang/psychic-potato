Rails.application.routes.draw do
  # Root needs to point to the pages controller > home method
  # Then, Rails checks the controller file, finds the home method,
  # and says I need to gather the corresponding view file
  root to: 'pages#home'
  # Edit devise's functionality - when devise is about to create a user,
  # we're going to extend the gem so that devise will know if it's a basic user or a pro user
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # When a client hits /about, Rails will check the controller file &
  # find the about method
  get 'about', to: 'pages#about'
  # Instead of doing `get 'contacts/new', to: 'contacts#new' --
  # Creates a bunch of routes for us, but we're telling it we only need the create action
  resources :contacts, only: [:create]
  # Without the line below, we'd also need the new action
  # But we want a custom URL
  # We can still use new_contact_path in our navbar link, so we can set an alias
  get 'contact-us', to: 'contacts#new', as: "new_contact"
end
