require "sidekiq"
require "sidekiq-cron"

Sidekiq::Cron::Job.load_from_hash({
  "weekly_summary_job" => {
    "class" => "WeeklySummaryJob",
    "cron"  => "0 9 * * 1" # Every Monday at 9am
  }
})
