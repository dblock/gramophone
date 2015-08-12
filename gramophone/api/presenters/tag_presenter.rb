module Gramophone
  module Api
    module Presenters
      module TagPresenter
        include Roar::JSON::HAL
        include Roar::Hypermedia
        include Grape::Roar::Representer

        property :id, type: String
        property :name, type: String
        property :count, as: :gram_count, type: Integer
        property :created_at, type: DateTime

        link :artist do |_opts|
          "https://api.artsy.net/api/artists/#{artist_id || name}"
        end

        link :self do |opts|
          request = Grape::Request.new(opts[:env])
          "#{request.base_url}/api/tags/#{id}"
        end

        link :grams do |opts|
          request = Grape::Request.new(opts[:env])
          "#{request.base_url}/api/grams?tag=#{name}"
        end
      end
    end
  end
end
