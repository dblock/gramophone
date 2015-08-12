Fabricator(:gram, from: 'Gramophone::Models::Gram') do
  tags { [Faker::Lorem.word] }
end
