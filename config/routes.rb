Rails.application.routes.draw do
  # Root needs to point to the pages controller > home method
  # Then, Rails checks the controller file, finds the home method,
  # and says I need to gather the corresponding view file
  root to: 'pages#home'
end
