# frozen_string_literal: true

class UsersBackoffice::WelcomeController < UsersBackofficeController
  def index
    @user_stat = UserStat.find_or_create_by(user: current_user)
  end
end
