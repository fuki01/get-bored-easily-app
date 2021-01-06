class Point < ApplicationRecord
  validates :sum, presence: true
  validates :target_id, presence: true
  belongs_to :target
  belongs_to :user
end
