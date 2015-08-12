module Gramophone
  module Api
    module Presenters
      module GramsPresenter
        include Roar::JSON::HAL
        include Roar::Hypermedia
        include Grape::Roar::Representer
        include Gramophone::Api::Presenters::PaginatedPresenter

        collection :results, extend: GramPresenter, as: :grams, embedded: true
      end
    end
  end
end
