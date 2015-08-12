require 'spec_helper'

describe Gramophone::Api::Endpoints::TagsEndpoint do
  def app
    Gramophone::App.instance
  end

  let(:client) do
    Hyperclient.new('http://example.org/api') do |client|
      client.connection(default: false) do |conn|
        conn.request :json
        conn.response :json
        conn.use Faraday::Adapter::Rack, app
      end
    end
  end

  context 'tags' do
    before do
      3.times { Fabricate(:gram) }
    end

    it 'returns tags' do
      expect(client.tags({}).count).to be > 0
    end
  end

  context 'tag' do
    let(:tag) { Fabricate(:gram_tag) }
    context 'by name' do
      subject do
        client.tag(id: tag.name)
      end
      it 'redirects tp tag id' do
        expect(subject._links['location'].to_s).to end_with "tags/#{tag.id}"
      end
    end
    context 'by id' do
      subject do
        client.tag(id: tag.id)
      end
      it 'returns a tag' do
        expect(subject.name).to eq tag.name
      end
      it 'automatically assigns artist_id' do
        expect(subject._links['artist'].to_s).to eq "https://api.artsy.net/api/artists/#{tag.name}"
      end
    end
  end
end
