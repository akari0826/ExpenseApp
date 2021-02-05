class ExpensesController < ApplicationController
  def index
    @expenses = current_user.expenses.all
  end
  
  def new
    @expense = Expense.new
  end
  
  def create
    @expense = current_user.expenses.new(expense_params)
    if @expense.save
      redirect_to expenses_path, success: '経費データ登録に成功しました'
    else
      flash.now[:danger] = '経費データ登録に失敗しました'
      render :new
    end
  end
  
  def show
    @expense = Expense.find(params[:id])
  end
    
  private
  def expense_params
    params.require(:expense).permit(:application_date, :expense_category_id, :expense_detail, :expense, :attached_file)
  end
end
