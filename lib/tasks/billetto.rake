namespace :billetto do
  desc "Sync events from Billetto"
  task sync: :environment do
    EventLoaderJob.perform_now(ENV["URL"])
  end
end
