class UserMailerPreview < ActionMailer::Preview
  def welcome
    user = User.last
    UserMailer.welcome(user)
  end
end
