class Site::WelcomeController < SiteController
  before_action :set_questions, only: [:index]

  def index; end

  private

  def set_questions
    @questions = Question.last_questions(params[:page])
  end
end
