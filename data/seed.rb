artists = {
  'jeffkoons' => { artist_id: 'jeff-koons' },
  'petracortright' => { artist_id: 'petra-cortright' },
  'sterlingruby' => { artist_id: 'sterling-ruby' },
  'olafureliasson' => { artist_id: 'olafur-eliasson' },
  'edruscha' => { artist_id: 'ed-ruscha' },
  'alexisrael' => { artist_id: 'alex-israel' },
  'traceyemin' => { artist_id: 'tracey-emin' },
  'yayoikusama' => { artist_id: 'yayoi-kusama' },
  'ernestoneto' => { artist_id: 'ernesto-neto' },
  'louisebourgeois' => { artist_id: 'louise-bourgeois' },
  'danflavin' => { artist_id: 'dan-flavin' },
  'christopherwool' => { artist_id: 'christopher-wool' },
  'gerhardrichter' => { artist_id: 'gerhard-richter' },
  'cindysherman' => { artist_id: 'cindy-sherman' }
}

artists.keys.each do |artist|
  puts artist
  Gramophone::Importers::Instagram.import_tag! artist
end

artists.each_pair do |artist, options|
  Gramophone::Models::GramTag.find(artist).update_attributes!(artist_id: options[:artist_id])
end
