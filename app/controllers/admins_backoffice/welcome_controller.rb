# frozen_string_literal: true

class AdminsBackoffice::WelcomeController < AdminsBackofficeController
  def index
    @users_total = AdminStat.users_total
    @questions_total = AdminStat.questions_total
  end
end
