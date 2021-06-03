class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update]
  require 'csv'
  
  def index
    #N+1問題/検索/ページネーション
    @expenses = current_user.expenses.includes(:user).search(expense_search_params).page(params[:page]).per(7)
  end
  
  def new
    @expense = Expense.new
  end
  
  def create
    @expense = current_user.expenses.new(expense_params)
    if @expense.save
      
      # ユーザが申請した際に@user=管理者に送信される
      @user = User.find_by(admin: true)
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
      
      # ユーザが申請を更新した際に@user=管理者に送信される
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
  
  def csv_download
    @expenses = current_user.expenses.includes(:user)
    # CSVファイル
    respond_to do |format|
      format.html
      format.csv do
        send_csv(@expenses)
      end
    end
    render :index
  end
  
  def send_csv(expenses)
    CSV.generate do |csv|
      csv_column_names = %w(申請日 申請者 経費カテゴリ 経費詳細 金額)
      csv << csv_column_names
      @expenses.each do |expense|
        csv_column_values = [
          expense.application_date,
          expense.user.name,
          expense.expense_category.name,
          expense.expense_detail,
          expense.expense.to_s(:delimited)
        ]
        csv << csv_column_values
      end
    end
  end
  
  private
  def expense_params
    params.require(:expense).permit(:application_date, :expense_category_id, :expense_detail, :expense, :attached_file)
  end
  
  def set_expense
    @expense = Expense.find(params[:id])
  end
  
  def expense_search_params
    params.fetch(:search, {}).permit(:approval, :application_date)
  end
end
