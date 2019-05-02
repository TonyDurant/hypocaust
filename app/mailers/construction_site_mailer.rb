class ConstructionSiteMailer < ActionMailer::Base
  default from: "notifications@hypocaust.org"

  def invite_notification(construction_site, user)
    @construction_site = construction_site
    @user = user
    @url = "http://hypocaust.org"
    mail(:to => user.email, :subject => "Вас пригласили принять участие в проекте на Гипокауст")
    encode_subject = false
  end
end
