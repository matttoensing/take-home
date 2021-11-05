class Tea < ApplicationRecord
  # has_many :tea_subscriptions
  belongs_to :subscription

  validates :title, presence: true
  validates :description, presence: true
  validates :temperature, presence: true
  validates :brew_time, presence: true
end
