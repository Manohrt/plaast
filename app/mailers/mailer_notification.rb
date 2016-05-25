class MailerNotification < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer_notification.dashboard.subject
  #
  def dashboard(mail)
   @mail = mail
  mail(to: "ceo@whiteplast.com",
         bcc: ["fmwp2@whiteplast.com","urmila.murali@altiussolution.com","manohrt92@gmail.com"])  
end
end
