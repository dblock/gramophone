module Gramophone
  module Api
    module Endpoints
      class GramsEndpoint < Grape::API
        format :json
        helpers Gramophone::Api::Helpers::CursorHelpers
        helpers Gramophone::Api::Helpers::SortHelpers
        helpers Gramophone::Api::Helpers::PaginationParameters

        namespace :grams do
          desc 'Get a gram.'
          params do
            requires :id, type: String, desc: 'Gram ID.'
          end
          get ':id' do
            gram = Gramophone::Models::Gram.find(params[:id]) || error!(404, 'Not Found')
            present gram, with: Gramophone::Api::Presenters::GramPresenter
          end

          desc 'Get all the grams.'
          params do
            optional :tag, type: String, desc: 'Only return grams with this tag.'
            use :pagination
          end
          get do
            query = Gramophone::Models::Gram
            query = query.where(tags: params[:tag]) if params[:tag]
            grams = paginate_and_sort_by_cursor(query, default_sort_order: '-created_at')
            present grams, with: Gramophone::Api::Presenters::GramsPresenter
          end
        end
      end
    end
  end
end
