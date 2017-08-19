class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    @greeting = "Olá #{@user.name},"
    @welcomemessage = "Seja bem vindo à plataforma AlentoMed, ficamos felizes pelo seu cadastro."
    @aboutus = "Nossa função é conectar pacientes com tratamentos conduzidos por pesquisas clinicas, possibilitando aos pacientes mais acesso a tratamentos gratuitos e de alta qualidade."
    @procedure = "Sempre que quiser participar de tratamentos conduzidos por pesquisas clinicas, acesse nosso site e pesquise pela doença a ser tratada. Caso encontre algum estudo que queira participar, entre na página do estudo e clique em 'QUERO CANDIDATAR', após isso aparecerá uma tela com mais informações e um botão para confirmar o consentimento com as informações presentes. Após a confirmação, enviaremos suas informações de contato para a entidade responsável pelo estudo para que entrem em contato com você e prossigam com o processo. Você também receberá em seu email as informações de contato da instituição responsável."
    @reminder = "Lembre-se que cada estudo tem critérios de seleção especificos e há um processo de seleção de candidatos para cada estudo. Consulte mais detalhes em nossa página e nos links fornecidos, ou entre diretamente em contato com os responsáveis pelo estudo ou conosco através do email contato@alentomed.com.br para mais informações."
    @ending = "Agradecemos a sua visita e lhe desejamos muita saúde."
    @us = "Atenciosamente,"
    @alentoteam = "Equipe AlentoMed"

    mail(to: @user.email, subject: 'Obrigado por se cadastrar na AlentoMed')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.contactuser.subject
  #
  def contactuser
    @greeting = "Olá"

    mail to: (@user.email, subject = 'Informações para prosseguir com o tratamento')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.contactstudy.subject
  #
  def contactstudy
    @greeting = "Hi"

    mail to: (@study.email, subject = 'O usuário (SUBSTITUIR PELO NOME DA PESSOA) deseja participar do seu estudo: (NOME DO ESTUDO)')
  end
end
