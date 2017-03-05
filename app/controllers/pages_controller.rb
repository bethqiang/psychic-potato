class PagesController < ApplicationController
  # GET request for / (home page)
  def home
    # Plan.find is basically Sequelize's Model.findById(id)
    @basic_plan = Plan.find(1)
    @pro_plan = Plan.find(2)
  end

  def about
  end
end
