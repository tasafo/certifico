namespace :db do
  namespace :certificar_me do
    desc 'Updates download subscribers'
    task :update_download_subscribers => :environment do
      Download.all.each do |download|
        subscriber = Subscriber.find_by user: download.user, certificate: download.certificate

        download.update(subscriber: subscriber) if subscriber
      end
    end
  end
end
