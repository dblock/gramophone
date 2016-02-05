namespace :instagram do
  desc 'Grab from Instagram.'
  task :import, [:tag] => :environment do |_t, args|
    tag = args[:tag] || raise('Missing tag.')
    puts "Grabbing for #{tag} ..."
    results = Gramophone::Importers::Instagram.import_tag!(tag)
    puts "Imported #{results.count} gram(s)."
  end

  desc 'Grab all from Instagram.'
  task import_all: :environment do
    puts "Importing #{Gramophone::Models::GramTag.count} tag(s) ..."
    Gramophone::Models::GramTag.all.each do |tag|
      STDOUT.write "Grabbing for #{tag.name} ..."
      results = Gramophone::Importers::Instagram.import_tag!(tag.name)
      puts " imported #{results.count} gram(s)."
    end
  end
end
