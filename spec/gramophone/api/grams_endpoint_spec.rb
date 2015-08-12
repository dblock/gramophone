require 'spec_helper'

describe Gramophone::Api::Endpoints::GramsEndpoint do
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

  context 'tagged' do
    it 'only returns grams with a given tag' do
      gram_foo = Fabricate(:gram, tags: ['foo'])
      Fabricate(:gram, tags: ['bar'])
      grams = client.grams(tag: 'foo')
      expect(grams.count).to eq 1
      expect(grams.first.id).to eq gram_foo.id.to_s
    end
  end

  context 'grams' do
    before do
      11.times { Fabricate(:gram) }
    end

    it 'returns 10 grams by default' do
      expect(client.grams({}).count).to eq 10
    end

    it 'returns 2 grams' do
      expect(client.grams(size: 2).count).to eq 2
    end

    it 'returns pagination' do
      response = client.grams(size: 2, page: 2)
      expect(response._links.next._url).to start_with 'http://example.org/api/grams?cursor='
      expect(response._links.self._url).to eq 'http://example.org/api/grams?page=2&size=2'
    end

    it 'returns all unique ids' do
      grams = client.grams({})
      expect(grams.map(&:id).uniq.count).to eq 10
    end
  end

  context 'gram' do
    let!(:gram) { Fabricate(:gram) }
    it 'returns a gram' do
      result = client.gram(id: gram.id)
      expect(result).to_not be nil
      expect(result.id).to eq gram.id.to_s
    end
  end
end
