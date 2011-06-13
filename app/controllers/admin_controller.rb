class AdminController < ApplicationController
  before_filter :admin?
  def index
    #show all the user, oier, ojees
    @users = User.all
  end
end