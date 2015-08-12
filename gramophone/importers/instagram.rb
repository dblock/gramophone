module Gramophone
  module Importers
    module Instagram
      def self.import_tag!(tag)
        client_id = ENV['INSTAGRAM_CLIENT_ID'] || fail('Missing ENV[INSTAGRAM_CLIENT_ID]!')
        client = ::Instagram.client(client_id: client_id)
        results = client.tag_recent_media(tag)
        grams = []
        results.each do |result|
          gram = Gramophone::Models::Gram.where(instagram_id: result.id).first
          gram ||= Gramophone::Models::Gram.new(instagram_id: result.id)
          gram.created_at = Time.at(result.created_time.to_i)
          gram.tags << tag unless gram.tags.include?(tag)
          gram.data = result
          gram.save!
          grams << gram
        end
        grams
      end
    end
  end
end
