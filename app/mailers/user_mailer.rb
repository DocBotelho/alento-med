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
  def contactuser(user)
    @user = user
    @greeting = "Olá #{@user.name},"
    @briefintro = "Obrigado pelo seu interesse em utilizar nossa plataforma para participar do tratamento: #{@trial.title}."
    @intro = "Nós enviamos as seguintes informações de contato para a instituição responsável pelo estudo cientifico que conduzirá o tratamento: Nome: #{@user.name}, Email: #{@user.email} e Telefone: #{@user.phone}. A partir de agora, você pode aguardar o contato da instituição para prosseguir com os procedimentos. Se houver algum erro nos seus dados fornecidos, por favor corrija as informações em seu cadastro clicando na sua foto de perfil no canto superior direito e em seguida editar cadastro. Após isso, candidate-se no estudo novamente ou entre em contato através das informações abaixo."
    @institutionname = "Nome da instituição: #{@institution.name}"
    @institutionaddress = "Endereço: #{@institution.address}"
    @medics = " Médicos(as) responsáveis: #{@trialdoctors.name}"
    @contactemail = "Email(s) para contato: #{@trialdoctors.email}"
    @contactphone = "Número de telefone para contato: #{@trialdoctors.phone}"
    @nctindentifier = "Identificador NCT: #{@trial.trial_nct_id}"
    @reminder = "Lembre-se que cada estudo tem critérios de seleção especificos e há um processo de seleção de candidatos para cada estudo. Consulte mais detalhes em nossa página e nos links fornecidos, ou entre diretamente em contato com os responsáveis pelo estudo ou conosco através do email contato@alentomed.com.br para mais informações."
    @ending = "Agradecemos a sua visita e lhe desejamos muita saúde."
    @att = "Atenciosamente,"
    @alentoteam = "Equipe AlentoMed"
    mail(to: @user.email, subject: "Informações sobre o tratamento: #{@trial.title}")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.contactstudy.subject
  #
  def contactstudy(contact)
    @user = user
    @greeting = "Olá #{@trialdoctors.name}"
    @briefintro = "Nós somos a AlentoMed. Uma plataforma que visa conectar usuários com tratamentos conduzidos por pesquisas clinicas. Você pode checar nossa plataforma através do site: www.alentomed.com.br."
    @intro = "Um usuário utilizou a nossa plataforma para expressar que tem interesse em participar do seu estudo cientifico #{@trial.name} com identificador #{@trial.nct_id}. Abaixo constam as informações do usuário para que possa ser dado prosseguimento nas etapas de aceitação do paciente. Enviamos também um email para o usuário com as seguintes informações de contato: email: #{@trialdoctors.email}, telefone: #{@trialdoctors.phone}. Seguem as informções do usuário abaixo:"
    @username = "Nome: #{@user.name}"
    @useremail = "Email do usuário: #{@user.email}"
    @userphone = "Telefone p/ contato: #{@user.phone}"
    @disclaimer = "Todas as nossas informações são obtidas através do banco de dados do site clinicaltrials.gov , caso haja alguma inconsistência nas iformações por favor entre em contato através do email contato@alentomed.com.br ou entre em contato com a equipe Clinical Trials."
    @ending = "Agradecemos a sua visita e lhe desejamos muita saúde."
    @att = "Atenciosamente,"
    @alentoteam = "Equipe AlentoMed"

    mail(to: @trialdoctors.email, subject: "O usuário #{@user.name} deseja participar do seu estudo: #{@trial.title}, Identificador: #{@trial.trial_nct_id}")
  end
end
