module Gramophone
  module Models
    class Gram
      include Mongoid::Document
      include Mongoid::Timestamps
      include Mongoid::TagCollectible::Tagged

      before_validation :downcase_tags

      field :instagram_id, type: String
      index instagram_id: 1

      field :data, type: Hash

      private

      def downcase_tags
        tags = tags.map(&:downcase) if tags
      end
    end
  end
end
