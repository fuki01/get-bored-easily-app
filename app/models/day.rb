class Day < ApplicationRecord
  validates :count, presence: true
  validates :target_id, presence: true
  validates :entryday, presence: true
  belongs_to :target

  def test(user)
    if !set_day_last.nil?
      @previous_day  =user.target.day.last
      @previous_day_cunt = user.target.day.last.count
      if (Time.now.strftime('%Y%m%d').to_i - @previous_day.entryday.strftime("%Y%m%d").to_i) == 1
        @day_count = @previous_day_cunt + 1
      else
        @day.count = 1
      end
    else
      @day.count = 1
    end
  end
end
