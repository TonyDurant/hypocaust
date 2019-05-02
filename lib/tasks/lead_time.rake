task :lead_time_notification => :environment do
  users = User.all
  users.each do |user|
    unless user.lead_times.empty?
      lead_times = user.lead_times.where("? <= end_date AND end_date <= ?", Time.now, Time.now + 2.weeks)
      unless lead_times.empty?
        LeadTimeMailer.upcoming_deliveries_notification(lead_times, user).deliver
      end
    else
      puts "no upcoming deliveries"
    end
  end
end
