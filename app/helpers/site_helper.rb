# frozen_string_literal: true

module SiteHelper
  def msg_jumbotron
    case params[:action]
    when 'index'
      'Last created questions'
    when 'questions'
      "Results for \"#{params[:question]}\":"
    when 'subject'
      "Questions for subject \"#{params[:subject_description]}\":"
    end
  end
end
