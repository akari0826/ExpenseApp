class ExpenseCategoriesController < ApplicationController
  before_action :if_not_admin
  before_action :set_expense_category, only: [:show, :edit, :update]
  
  def index
    @expense_categories = ExpenseCategory.all
  end
  
  def new
    @expense_category = ExpenseCategory.new
  end
  
  def create
    @expense_category = ExpenseCategory.new(expense_category_params)
    if @expense_category.save
      redirect_to expense_categories_url, success: '経費カテゴリ登録に成功しました'
    else
      flash.now[:danger] = '経費カテゴリ登録に失敗しました'
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @expense_category.update(expense_category_params)
      redirect_to expense_categories_url, success: '経費カテゴリ更新に成功しました'
    else
      flash.now[:danger] = '経費カテゴリ更新に失敗しました'
      render :edit
    end
  end
  
  def destroy
    ExpenseCategory.find(params[:id]).discard
    redirect_to expense_categories_url, success: '経費カテゴリを削除しました'
  end
  
  private
  def expense_category_params
    params.require(:expense_category).permit(:name)
  end
  
  def set_expense_category
    @expense_category = ExpenseCategory.find(params[:id])
  end
end
