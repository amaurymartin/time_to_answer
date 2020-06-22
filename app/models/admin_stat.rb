# frozen_string_literal: true

class AdminStat < ApplicationRecord
  CONSTS = {
    users_total: 'USERS_TOTAL',
    questions_total: 'QUESTIONS_TOTAL'
  }

  # scopes
  scope :users_total, -> { find_by_description(CONSTS[:users_total]).value.to_i }
  scope :questions_total, -> { find_by_description(CONSTS[:questions_total]).value.to_i }

  # class methods
  def self.increment_total(event)
    admin_stat = AdminStat.find_or_create_by(description: event)

    admin_stat.value += 1.00
    admin_stat.save
  end
end
