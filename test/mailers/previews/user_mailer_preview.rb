class UserMailerPreview < ActionMailer::Preview
  def welcome
    user = User.last
    UserMailer.welcome(user)
  end

  def contactuser
    user = User.last
    UserMailer.contactuser(user)
  end

  def contactstudy
    user = User.last
    UserMailer.contactstudy(user)
  end
end
