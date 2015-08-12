namespace :instagram do
  desc 'Grab from Instagram.'
  task :grab, [:tag] => :environment do |_t, args|
    tag = args[:tag] || fail('Missing tag.')
    puts "Grabbing for #{tag} ..."
    client_id = ENV['INSTAGRAM_CLIENT_ID'] || fail('Missing ENV[INSTAGRAM_CLIENT_ID]!')
    client = Instagram.client(client_id: client_id)
    results = client.tag_recent_media(tag)
    puts "Inserting #{results.count} record(s) ..."
    results.each do |result|
      gram = Gramophone::Models::Gram.where(instagram_id: result.id).first
      gram ||= Gramophone::Models::Gram.new(instagram_id: result.id)
      gram.data = result
      gram.save!
      puts " #{gram.instagram_id}"
    end
  end
end
