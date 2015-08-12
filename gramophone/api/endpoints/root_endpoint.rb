module Gramophone
  module Api
    module Endpoints
      class RootEndpoint < Grape::API
        prefix 'api'
        format :json
        formatter :json, Grape::Formatter::Roar

        desc 'Gramophone Reticulated Grams Api.'
        get do
          present self, with: Gramophone::Api::Presenters::RootPresenter
        end

        mount Gramophone::Api::Endpoints::GramsEndpoint

        add_swagger_documentation api_version: 'v1'
      end
    end
  end
end
