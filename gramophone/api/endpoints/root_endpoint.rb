module Gramophone
  module Api
    module Endpoints
      class RootEndpoint < Grape::API
        prefix 'api'
        format :json
        formatter :json, Grape::Formatter::Roar

        desc 'Gramophone API.'
        get do
          present self, with: Gramophone::Api::Presenters::RootPresenter
        end

        mount Gramophone::Api::Endpoints::GramsEndpoint
        mount Gramophone::Api::Endpoints::TagsEndpoint

        add_swagger_documentation api_version: 'v1'
      end
    end
  end
end
