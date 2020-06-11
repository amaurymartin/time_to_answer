class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions
  has_many :answers

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  # Kaminari - Elements per page
  paginates_per 5

  scope :with_answers, -> { includes(:answers) }

  scope :order_by, ->(order, direction) { order("#{order} #{direction}") }

  scope :paginated, ->(page) { page(page) }

  scope :_search_, lambda { |question|
    where('lower(description) LIKE ?',
          "%#{Question.sanitize_sql_like(question.downcase)}%")
  }
end
