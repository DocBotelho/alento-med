class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    @greeting = "Olá #{@user.name},"
    @briefintro = "Seja bem vindo à plataforma AlentoMed, ficamos felizes pelo seu cadastro."
    @intro = "Nossa função é conectar pacientes com tratamentos conduzidos por pesquisas clinicas, possibilitando aos pacientes mais acesso a tratamentos gratuitos e de alta qualidade."
    @content = "Sempre que quiser participar de tratamentos conduzidos por pesquisas clinicas, acesse nosso site e pesquise pela doença a ser tratada. Caso encontre algum estudo que queira participar, entre na página do estudo e clique em 'QUERO CANDIDATAR', após isso aparecerá uma tela com mais informações e um botão para confirmar o consentimento com as informações presentes. Após a confirmação, enviaremos suas informações de contato para a entidade responsável pelo estudo para que entrem em contato com você e prossigam com o processo. Você também receberá em seu email as informações de contato da instituição responsável."
    @reminder = "Lembre-se que cada estudo tem critérios de seleção especificos e há um processo de seleção de candidatos para cada estudo. Consulte mais detalhes em nossa página e nos links fornecidos, ou entre diretamente em contato com os responsáveis pelo estudo ou conosco através do email contato@alentomed.com.br para mais informações."
    @ending = "Agradecemos a sua visita e lhe desejamos muita saúde."
    @att = "Atenciosamente,"
    @alentoteam = "Equipe AlentoMed"

    mail(to: @user.email, subject: 'Obrigado por se cadastrar na AlentoMed')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.contactuser.subject
  #
  def contactuser
    @greeting = "Olá #{@user.name},"
    @briefintro = "Obrigado pelo seu interesse em utilizar nossa plataforma para participar do tratamento: #{@trial.title}."
    @intro = "Nós enviamos as seguintes informações de contato para a instituição responsável pelo estudo cientifico que conduzirá o tratamento: Nome: #{@user.name}, Email: #{@user.email} e Telefone: #{@user.phone}. A partir de agora, você pode aguardar o contato da instituição para prosseguir com os procedimentos. Se houver algum erro nos seus dados fornecidos, por favor corrija as informações em seu cadastro clicando na sua foto de perfil no canto superior direito e em seguida editar cadastro. Após isso, candidate-se no estudo novamente ou entre em contato através das informações abaixo."
    @institutionname = "Nome da instituição: #{@institution.name}"
    @institutionaddress = "Endereço: #{@institution.address}"
    @medic = " Médicos(as) responsáveis: #{@trialdoctors.name}"
    @contactemail = "Email(s) para contato: #{@trialdoctors.email}"
    @contactphone = "Número de telefone para contato: #{@trialdoctors.phone}"
    @nctindentifier = "Identificador NCT: #{@trial.trial_nct_id}"
    @reminder = "Lembre-se que cada estudo tem critérios de seleção especificos e há um processo de seleção de candidatos para cada estudo. Consulte mais detalhes em nossa página e nos links fornecidos, ou entre diretamente em contato com os responsáveis pelo estudo ou conosco através do email contato@alentomed.com.br para mais informações."
    @ending = "Agradecemos a sua visita e lhe desejamos muita saúde."
    @att = "Atenciosamente,"
    @alentoteam = "Equipe AlentoMed"
    mail to: (@user.email, subject = "Informações sobre o tratamento: #{@trial.title}")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.contactstudy.subject
  #
  def contactstudy
    @greeting = "Olá #{@trialdoctors.name}"

    mail to: (@trialdoctors.email, subject = "O usuário #{@user.name} deseja participar do seu estudo: #{@trial.title}, Identificador: #{@trial.trial_nct_id}")
  end
end
