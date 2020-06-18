class UserStat < ApplicationRecord
  belongs_to :user

  def questions_total
    right_questions + wrong_questions
  end

  def self.set_user_stats(answer, current_user)
    return if current_user.nil?

    user_stat = UserStat.find_or_create_by(user: current_user)

    answer.correct? ? user_stat.right_questions += 1 : user_stat.wrong_questions += 1

    user_stat.save!
  end
end
