class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome
    @greeting = "olá"

    mail to: (@user.email, subject: 'Bem vindo ao AlentoMed')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.contactuser.subject
  #
  def contactuser
    @greeting = "Olá"

    mail to: (@user.email, subject: 'Informações para prosseguir com o tratamento')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.contactstudy.subject
  #
  def contactstudy
    @greeting = "Hi"

    mail to: (@study.email, subject: 'O usuário (SUBSTITUIR PELO NOME DA PESSOA) deseja participar do seu estudo: (NOME DO ESTUDO)'
  end
end
