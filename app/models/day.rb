class Day < ApplicationRecord
  validates :count, presence: true
  validates :possible, presence: true
  validates :target_id, presence: true
  belongs_to :target
end
