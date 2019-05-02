class CompanyMailer < ActionMailer::Base
  default from: "notifications@hypocaust.org"

  def new_company(company)
    @company = company
    mail(:to => "avinogradov@hypocaust.org", :subject => "#{@company.email} — новая компания на Гипокаусте")
    encode_subject = false
  end
end
