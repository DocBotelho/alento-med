module UsersHelper

  def user_picture
  current_user.facebook_picture_url || "no-avatar.jpg"
  end
end
