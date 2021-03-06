module Gramophone
  module Api
    module Presenters
      module RootPresenter
        include Roar::JSON::HAL
        include Roar::Hypermedia
        include Grape::Roar::Representer

        link :self do |opts|
          "#{base_url(opts)}/api"
        end

        link :swagger_doc do |opts|
          "#{base_url(opts)}/api/swagger_doc"
        end

        link :grams do |opts|
          {
            href: "#{base_url(opts)}/api/grams{?page,size,tag}",
            templated: true
          }
        end

        link :gram do |opts|
          {
            href: "#{base_url(opts)}/api/grams/{id}",
            templated: true
          }
        end

        link :tags do |opts|
          {
            href: "#{base_url(opts)}/api/tags{?page,size}",
            templated: true
          }
        end

        link :tag do |opts|
          {
            href: "#{base_url(opts)}/api/tags/{id}",
            templated: true
          }
        end

        private

        def base_url(opts)
          request = Grape::Request.new(opts[:env])
          request.base_url
        end
      end
    end
  end
end
