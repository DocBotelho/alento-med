class Treatment < ApplicationRecord
  belongs_to :user
  belongs_to :trial
  belongs_to :institution
  belongs_to :doctor, optional: true
  after_create :send_contactuser_email

  def send_contactuser_email
    UserMailer.contactuser(self).deliver_now
  end
end
