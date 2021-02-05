class Admin::ExpensesController < ApplicationController
  before_action :if_not_admin
  
  def index
    @expenses = Expense.all
  end
  
  def show
    @expense = Expense.find(params[:id])
  end
  
  private
  def if_not_admin
    redirect_to root_url unless current_user.admin?
  end
end
