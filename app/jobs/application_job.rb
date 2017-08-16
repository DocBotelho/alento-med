class ApplicationJob < ActiveJob::Base
  config.active_job.queue_adapter = :sidekiq
end
