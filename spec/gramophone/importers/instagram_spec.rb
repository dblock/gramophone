require 'spec_helper'

describe Gramophone::Importers::Instagram do
  before do
    @old_instagram_client_id = ENV['INSTAGRAM_CLIENT_ID']
    ENV['INSTAGRAM_CLIENT_ID'] ||= 'test'
  end
  after do
    ENV['INSTAGRAM_CLIENT_ID'] = @old_instagram_client_id
  end
  describe '#import_tag!', vcr: { cassette_name: 'instagram/tag_recent_media', allow_playback_repeats: true } do
    let!(:tags) { Gramophone::Importers::Instagram.import_tag! 'tag' }
    it 'returns grams' do
      expect(tags.count).to eq 20
      expect(tags.first).to be_a Gramophone::Models::Gram
    end
    it 'creates grams' do
      expect(Gramophone::Models::Gram.count).to eq 20
    end
    it 'tags grams' do
      expect(Gramophone::Models::Gram.first.tags).to eq ['tag']
    end
    it 'does not import grams twice' do
      expect do
        Gramophone::Importers::Instagram.import_tag! 'tag'
      end.to_not change(Gramophone::Models::Gram, :count)
    end
    it 'merges data' do
      Gramophone::Models::Gram.first.destroy
      expect do
        Gramophone::Importers::Instagram.import_tag! 'tag'
      end.to change(Gramophone::Models::Gram, :count).by(1)
    end
  end
end
