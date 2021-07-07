class Admin::ExpensesController < ApplicationController
  before_action :if_not_admin
  before_action :set_expense, only: [:show, :edit, :update, :approval]
  require 'csv'
  
  def index
    # N+1問題/検索/ページネーション
    @expenses = Expense.includes(:user).search(expense_search_params).page(params[:page]).per(10)
    # 論理削除されたuser_idとユーザnameのhash
    @user_id_hash = {}
    user_discarded_obj = User.with_discarded.discarded
    user_discarded_obj.each do |user|
        @user_id_hash[user.id] = user.name
    end
    # CSVファイル
    respond_to do |format|
     format.html
     format.csv do
       send_data render_to_string, filename: "expenses.csv", type: :csv
     end
    end
  end
  
  def show
    @user_id_hash = {}
    user_discarded_obj = User.with_discarded.discarded
    user_discarded_obj.each do |user|
        @user_id_hash[user.id] = user.name
    end
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
    # 承認済データが取消された場合
    if @expense.approval
      @expense.approval = false
      
      # 管理者が承認取消した際に経費を登録したユーザに送信される
      @user = Expense.find(params[:id]).user
      UserMailer.with(user: @user).approval_cancellation_email.deliver
      
    # 未承認データが承認された場合
    else
      @expense.approval = true
      
      # 管理者が承認した際に経費を登録したユーザに送信される
      @user = Expense.find(params[:id]).user
      UserMailer.with(user: @user).approval_email.deliver
    end
    
    @expense.save
    redirect_to admin_expenses_url, info: '申請状況を更新しました' 
  end
  
  def analysis
    @expenses = Expense.includes(:user)
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
