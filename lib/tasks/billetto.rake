namespace :billetto do
  desc "Sync events from Billetto"
  task sync: :environment do
    EventLoaderJob.perform_later
  end
end
