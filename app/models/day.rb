class Day < ApplicationRecord
  validates :count, presence: true
  validates :target_id, presence: true
  validates :entryday, presence: true
  belongs_to :target

  def time_now
    Time.now.strftime('%Y%m%d')
  end
  def continuous_registration(day)
    (time_now.to_i - day.entryday.strftime("%Y%m%d").to_i) == 1
  end
end
