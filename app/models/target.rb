class Target < ApplicationRecord
  validates :body, presence: true
  validates :user_id, presence: true
  belongs_to :user
  has_many :day, dependent: :destroy
  has_many :point, dependent: :destroy
end
