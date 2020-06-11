class Site::SearchController < SiteController
  def questions
    @questions = Question.search(params[:question], params[:page])
  end
end
