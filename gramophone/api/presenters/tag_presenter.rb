module Gramophone
  module Api
    module Presenters
      module TagPresenter
        include Roar::JSON::HAL
        include Roar::Hypermedia
        include Grape::Roar::Representer

        property :id, type: String
        property :name, type: String
        property :created_at, type: DateTime

        link :self do |opts|
          request = Grape::Request.new(opts[:env])
          "#{request.base_url}/api/tags/#{id}"
        end
      end
    end
  end
end
