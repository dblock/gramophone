module Gramophone
  module Models
    class Gram
      include Mongoid::Document
      include Mongoid::Timestamps

      field :instagram_id, type: String
      index instagram_id: 1

      field :data, type: Hash
    end
  end
end
