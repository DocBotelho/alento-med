class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user

    mail(to: @user.email, subject: 'Obrigado por se cadastrar na Alento')
  end

  def contactuser(treatment)
    @user = treatment.user
    @treatment = treatment


    # REMOVED/COMMENTED TO MAKE IT RUN By DocBotelho & Marcos TA
    # @contactemail = #{
    #   unless treatment.institution.institutioncontacts[0][:email].nil?
    #     treatment.institution.institutioncontacts[0][:email]
    #   else
    #     treatment.trial.centralcontacts[0][:email]
    #   end
    #   }"
    # @contactphone = " #{
    #   unless treatment.institution.institutioncontacts[0][:phone].nil?
    #     treatment.institution.institutioncontacts[0][:phone]
    #   else
    #     treatment.trial.centralcontacts[0][:phone]
    #   end
    #   }"


    mail(to: @user.email, subject: "Informações sobre o tratamento: #{treatment.trial.title}")
  end

  def contactstudy(treatment)
    @user = treatment.user

    mail(to: @user.email, subject: "O usuário #{treatment.user.name} deseja participar do seu estudo: #{treatment.trial.title}, Identificador: #{treatment.trial.trial_nct_id}")
  end
end
