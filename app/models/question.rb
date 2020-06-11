class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions
  has_many :answers

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  #Kaminari - Elements per page
  paginates_per 5

  def self.search(question, page)
    Question.where('lower(description) LIKE ?',
                   "%#{Question.sanitize_sql_like(question.downcase)}%")
            .includes(:answers)
            .order(created_at: :desc)
            .page(page)
  end

  def self.last_questions(page)
    Question.includes(:answers)
            .order(created_at: :desc)
            .page(page)
  end
end
