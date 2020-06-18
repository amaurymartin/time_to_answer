# frozen_string_literal: true

module UsersBackofficeHelper
  def user_avatar_uri
    user_avatar = current_user.user_profile.user_avatar
    user_avatar.attached? ? user_avatar : 'img.jpg'
  end
end
