class Day < ApplicationRecord
  validates :count, presence: true
  validates :target_id, presence: true
  validates :entryday, presence: true
  belongs_to :target
end
