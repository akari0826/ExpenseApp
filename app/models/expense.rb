class Expense < ApplicationRecord
  validates :user_id, presence: true
  validates :application_date, presence: true
  validates :expense_category_id, presence: true
  validates :expense_detail, presence: true
  validates :expense, presence: true, format: { with: /\A[0-9]+\z/, message: "半角英数字のみ入力可" }
  validates :attached_file, presence: true
  
  belongs_to :user
  belongs_to :expense_category
  has_one_attached :attached_file
    
  
  scope :search, -> (expense_search_params) do
    return if expense_search_params.blank? #if文がtrueのとき(=paramsが空だったら)return以下は実行されない
    
    application_date_from(expense_search_params[:application_date_from]).order(application_date: :asc) #下で定義したscopeメソッドでAND検索
      .application_date_to(expense_search_params[:application_date_to]).order(application_date: :asc)
      .joins(:user).name_like(expense_search_params[:name])
      .expense_category_id(expense_search_params[:expense_category_id])
      .expense_from(expense_search_params[:expense_from])
      .expense_to(expense_search_params[:expense_to])
      .approval_is(expense_search_params[:approval])
  end
  
  #application_date_fromに値がある場合、application_dateで範囲検索
  scope :application_date_from, -> (date_from) { where('? <= application_date', date_from) if date_from.present? }
  #application_date_toに値がある場合、application_dateで範囲検索
  scope :application_date_to, -> (date_to) { where('application_date <= ?', date_to) if date_to.present? }
  #name_likeに値がある場合、nameをlike検索
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  #expense_category_idがある場合、expense_category_idで検索
  scope :expense_category_id, -> (category_id) { where(expense_category_id: category_id) if category_id.present? }
  #expense_fromがある場合、expenseで範囲検索
  scope :expense_from, -> (expense_from) { where('? <= expense', expense_from) if expense_from.present? }
  #expense_toがある場合、expenseで範囲検索
  scope :expense_to, -> (expense_to) { where('expense <= ?', expense_to) if expense_to.present? }
  #approval_isがある場合、approvalで検索
  scope :approval_is, -> (approval) { where(approval: approval) if approval.present? }
end