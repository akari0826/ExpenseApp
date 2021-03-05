class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update]
  
  def index
    @expenses = current_user.expenses.includes(:user).page(params[:page]).per(7)
  end
  
  def new
    @expense = Expense.new
  end
  
  def create
    @expense = current_user.expenses.new(expense_params)
    if @expense.save
      
      @user = User.find_by(admin: true) #管理者adminをtrueで出す
      UserMailer.with(user: @user).application_email.deliver
      
      redirect_to expenses_url, success: '経費データ登録に成功しました'
    else
      flash.now[:danger] = '経費データ登録に失敗しました'
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @expense.update(expense_params)
      
      @user = User.find_by(admin: true)
      UserMailer.with(user: @user).application_email.deliver
      
      redirect_to expense_url, success: '経費データ更新に成功しました'
    else
      flash.now[:danger] = '経費データ更新に失敗しました'
      render :edit
    end
  end
  
  def destroy
    Expense.find(params[:id]).discard
    redirect_to expenses_url, success: '経費データを削除しました'
  end
    
  private
  def expense_params
    params.require(:expense).permit(:application_date, :expense_category_id, :expense_detail, :expense, :attached_file)
  end
  
  def set_expense
    @expense = Expense.find(params[:id])
  end
end
