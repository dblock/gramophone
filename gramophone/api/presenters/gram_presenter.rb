module Gramophone
  module Api
    module Presenters
      module GramPresenter
        include Roar::JSON::HAL
        include Roar::Hypermedia
        include Grape::Roar::Representer

        property :id, type: String

        link :self do |opts|
          request = Grape::Request.new(opts[:env])
          "#{request.base_url}/api/grams/#{id}"
        end
      end
    end
  end
end
