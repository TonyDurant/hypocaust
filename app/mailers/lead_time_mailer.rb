class LeadTimeMailer < ActionMailer::Base
  default from: "notifications@hypocaust.org"

  def upcoming_deliveries_notification(lead_times, user)
    @lead_times = lead_times
    @user = user
    @url = "http://hypocaust.org"
    mail(:to => user.email, :subject => "Your upcoming deliveries for the next 2 weeks")
    encode_subject = false
  end
end
