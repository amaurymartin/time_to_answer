# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  def profile_update_email
    AdminMailer.profile_update_email(Admin.first, Admin.last)
  end
end
