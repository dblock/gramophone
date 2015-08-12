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
    let!(:gram) { Fabricate(:gram) }
    it 'returns a tag via name' do
      result = client.tag(id: gram.tags.first)
      expect(result).to_not be nil
      expect(result.to_s).to end_with "tags/#{gram.tags.first}"
    end
    it 'returns a tag via id' do
      tag = Gramophone::Models::GramTag.first
      result = client.tag(id: tag.id)
      expect(result).to_not be nil
      expect(result.to_s).to end_with "tags/#{tag.id}"
      expect(result.name).to eq tag.name
    end
  end
end
