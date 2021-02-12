class Admin::ExpensesController < ApplicationController
  before_action :if_not_admin
  
  def index
    @expenses = Expense.all
  end
  
  def show
    @expense = Expense.find(params[:id])
  end
  
  def edit
    @expense = Expense.find(params[:id])
  end
  
  def update
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      redirect_to admin_expense_url, success: '経費データ更新に成功しました'
    else
      flash.now[:danger] = '経費データ更新に失敗しました'
      render :edit
    end
  end
  
  def destroy
    Expense.find(params[:id]).destroy
    redirect_to admin_expenses_url, success: '経費データを削除しました'
  end
  
  def approval
    @expense = Expense.find(params[:id])
    if @expense.approval == true
      @expense.approval = false
    else
      @expense.approval = true
    end
    
    @expense.save
    redirect_to admin_expenses_path(@expense), info: 'ステータスを更新しました' 
  end
  
  private
  def if_not_admin
    redirect_to root_url unless current_user.admin?
  end
  
  def expense_params
    params.require(:expense).permit(:application_date, :expense_category_id, :expense_detail, :expense, :attached_file, :approval)
  end
end
