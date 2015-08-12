namespace :instagram do
  desc 'Grab from Instagram.'
  task :import, [:tag] => :environment do |_t, args|
    tag = args[:tag] || fail('Missing tag.')
    puts "Grabbing for #{tag} ..."
    results = Gramophone::Importers::Instagram.import_tag!(tag)
    puts "Imported #{results.count} gram(s)."
  end
end
