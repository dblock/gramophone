module Gramophone
  module Api
    module Endpoints
      class TagsEndpoint < Grape::API
        format :json
        helpers Gramophone::Api::Helpers::CursorHelpers
        helpers Gramophone::Api::Helpers::SortHelpers
        helpers Gramophone::Api::Helpers::PaginationParameters

        namespace :tags do
          desc 'Get a tag.'
          params do
            requires :id, type: String, desc: 'Gram ID.'
          end
          get ':id' do
            tag = Gramophone::Models::GramTag.find(params[:id]) || error!(404, 'Not Found')
            redirect! "/api/tags/#{tag.id}" if tag.id.to_s != params[:id]
            present tag, with: Gramophone::Api::Presenters::TagPresenter
          end

          desc 'Get all the tags.'
          params do
            use :pagination
          end
          get do
            tags = paginate_and_sort_by_cursor(Gramophone::Models::GramTag)
            present tags, with: Gramophone::Api::Presenters::TagsPresenter
          end
        end
      end
    end
  end
end
