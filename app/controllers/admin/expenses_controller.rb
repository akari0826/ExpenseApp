class Admin::ExpensesController < ApplicationController
  before_action :authenticate_user, :if_not_admin
  before_action :set_expense, only: [:show, :edit, :update, :approval]
  
  def index
    #N+1問題/検索/ページネーション
    @expenses = Expense.includes(:user).search(expense_search_params).page(params[:page]).per(10)
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @expense.update(expense_params)
      redirect_to admin_expense_url, success: '経費データ更新に成功しました'
    else
      flash.now[:danger] = '経費データ更新に失敗しました'
      render :edit
    end
  end
  
  def destroy
    Expense.find(params[:id]).discard
    redirect_to admin_expenses_url, success: '経費データを削除しました'
  end
  
  def approval
    if @expense.approval == true #承認済データが取消された場合
      @expense.approval = false
      
      @user = Expense.find(params[:id]).user #経費を登録したユーザを出す
      UserMailer.with(user: @user).approval_cancellation_email.deliver
      
    else #未承認データが承認された場合
      @expense.approval = true
      
      @user = Expense.find(params[:id]).user
      UserMailer.with(user: @user).approval_email.deliver
    end
    
    @expense.save
    redirect_to admin_expenses_path(@expense), info: '申請状況を更新しました' 
  end
  
  private
  def expense_params
    params.require(:expense).permit(:application_date, :expense_category_id, :expense_detail, :expense, :attached_file, :approval)
  end
  
  def set_expense
    @expense = Expense.find(params[:id])
  end
  
  def expense_search_params
    params.fetch(:search, {})
    .permit(:application_date_from, :application_date_to, :name, :expense_category_id, :expense_from, :expense_to, :approval, :application_date)
  end
end
