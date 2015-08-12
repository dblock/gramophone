module Gramophone
  module Api
    module Presenters
      module TagsPresenter
        include Roar::JSON::HAL
        include Roar::Hypermedia
        include Grape::Roar::Representer
        include Gramophone::Api::Presenters::PaginatedPresenter

        collection :results, extend: TagPresenter, as: :tags, embedded: true
      end
    end
  end
end
