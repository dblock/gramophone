module Gramophone
  module Models
    class GramTag
      field :artist_id, type: String
      index artist_id: -1
    end
  end
end
