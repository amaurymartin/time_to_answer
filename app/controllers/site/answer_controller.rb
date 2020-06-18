# frozen_string_literal: true

class Site::AnswerController < SiteController
  def question
    @answer = Answer.find(params[:answer_id])

    UserStat.set_user_stats(@answer, current_user)
  end
end
