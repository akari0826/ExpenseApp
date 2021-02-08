class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  
  private
  def if_not_admin
    redirect_to root_url unless current_user.admin?
  end
end
