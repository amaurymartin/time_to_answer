class Site::WelcomeController < SiteController
  before_action :set_questions, only: [:index]

  def index
  end

  private

  def set_questions
    @questions = Question.includes(:answers)
                         .order(:description)
                         .page(params[:page])
  end
end
