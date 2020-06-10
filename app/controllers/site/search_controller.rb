class Site::SearchController < SiteController
  def questions
    @questions = Question.where("lower(description) LIKE ?", "%#{Question.sanitize_sql_like(params[:question].downcase)}%")
                         .includes(:answers)
                         .order(:description)
                         .page(params[:page])
  end
end
