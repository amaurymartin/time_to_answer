class Site::WelcomeController < SiteController
  before_action :set_questions, only: [:index]

  def index; end

  private

  def set_questions
    @questions = Question.with_answers
                         .order_by(:created_at, :desc)
                         .paginated(params[:page])
  end
end
