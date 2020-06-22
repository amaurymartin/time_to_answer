class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions, counter_cache: true
  has_many :answers

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  # callback
  after_create :increment_total

  # Kaminari - Elements per page
  paginates_per 5

  scope :with_answers, -> { includes(:answers) }
  scope :with_answers_and_subject, -> { includes(:answers, :subject) }

  scope :order_by, ->(order, direction) { order("#{order} #{direction}") }

  scope :paginated, ->(page) { page(page) }

  scope :_search_, lambda { |question|
    where('lower(description) LIKE ?',
          "%#{Question.sanitize_sql_like(question.downcase)}%")
  }

  scope :_search_subject_, ->(subject_id) { where(subject_id: subject_id) }

  private

  def increment_total
    AdminStat.increment_total(AdminStat::CONSTS[:questions_total])
  end
end
