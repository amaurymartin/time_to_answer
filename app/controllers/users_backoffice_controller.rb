# frozen_string_literal: true

class UsersBackofficeController < ApplicationController
  before_action :authenticate_user!
  before_action :build_user_profile

  layout 'users_backoffice'

  def build_user_profile
    current_user.build_user_profile if current_user.user_profile.blank?
  end
end
