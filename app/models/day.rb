class Day < ApplicationRecord
  validates :count, presence: true
  validates :target_id, presence: true
  validates :User_id, presence: true
  validates :entryday, presence: true
  belongs_to :target

  def self.day_last(user)
    user.targets.last.day.last
  end
end
