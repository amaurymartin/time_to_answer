# frozen_string_literal: true

class AdminMailer < ApplicationMailer
  def profile_update_email(current_admin, updated_admin)
    @current_admin = current_admin
    @updated_admin = updated_admin

    mail(to: @updated_admin.email, subject: "Updated Profile - Time to Answer")
  end
end
