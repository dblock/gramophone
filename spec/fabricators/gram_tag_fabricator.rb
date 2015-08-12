Fabricator(:gram_tag, from: 'Gramophone::Models::GramTag') do
  name { Faker::Lorem.word }
end
