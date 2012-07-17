class HomeController < ApplicationController
  def index
    #TODO - need to define what we actually want on this page
    @users = User.all
  end
end
