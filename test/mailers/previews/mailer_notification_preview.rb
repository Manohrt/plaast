# Preview all emails at http://localhost:3000/rails/mailers/mailer_notification
class MailerNotificationPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/mailer_notification/dashboard
  def dashboard
    MailerNotification.dashboard
  end

end
