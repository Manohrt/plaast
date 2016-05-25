require 'test_helper'

class MailerNotificationTest < ActionMailer::TestCase
  test "dashboard" do
    mail = MailerNotification.dashboard
    assert_equal "Dashboard", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
