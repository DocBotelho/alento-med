class Treatment < ApplicationRecord
  belongs_to :user
  belongs_to :trial
  belongs_to :institution
  belongs_to :doctor
  after_create :send_contactuser_email

  def send_contactuser_email
    @user = @treatment.user
    UserMailer.contactuser(@user).deliver_now
  end

  def send_contactstudy_email
    @trial = @institution.trial
    @studycontact = @institutio.
end
