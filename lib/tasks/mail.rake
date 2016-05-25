task :mail => :environment do
 MailerNotification.dashboard(@mail).deliver_now
end
