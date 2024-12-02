class Recommendation < ApplicationRecord
  belongs_to :recommendable, polymorphic: true
end
