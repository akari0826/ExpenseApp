class ExpenseDataController < ApplicationController
  def new
    @expense_data = ExpenseData.new
  end
  
  def create
    @expense_data = current_user.expense_data.new(expense_data_params)
    
    if @expense_data.save
      redirect_to expense_data_path, success: '経費データの登録に成功しました'
    else
      flash.now[:danger] = '経費データの登録に失敗しました'
      render :new
    end
  end
  
  private
  def expense_data_params
    params.require(:expense_data).permit(:application_date, :expense_catagory_id, :expense_detail, :expense, :attached_file)
  end
end
