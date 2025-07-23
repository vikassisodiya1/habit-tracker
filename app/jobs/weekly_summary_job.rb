class WeeklySummaryJob < ApplicationJob
  queue_as :mailers

  def perform
    User.find_each do |user|
      WeeklySummaryMailer.summary_email(user).deliver_later
    end
  end
end
