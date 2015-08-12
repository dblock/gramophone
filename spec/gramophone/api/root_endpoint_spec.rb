require 'spec_helper'

describe Gramophone::Api::Endpoints::RootEndpoint do
  include Rack::Test::Methods

  def app
    Gramophone::App.instance
  end

  it 'hypermedia root' do
    get '/api'
    expect(last_response.status).to eq 200
    links = JSON.parse(last_response.body)['_links']
    expect(links.keys.sort).to eq(%w(gram grams self swagger_doc tag tags))
  end
  it 'follows all links' do
    get '/api'
    expect(last_response.status).to eq 200
    links = JSON.parse(last_response.body)['_links']
    links.each_pair do |_key, h|
      href = h['href']
      next if href.include?('{') # templated link
      get href.gsub('http://example.org', '')
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to_not eq({})
    end
  end
end
