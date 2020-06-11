class Site::SearchController < SiteController
  def questions
    @questions = Question.with_answers
                         ._search_(params[:question])
                         .order_by(:created_at, :desc)
                         .paginated(params[:page])
  end
end
