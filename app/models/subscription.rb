class Subscription < ApplicationRecord
  # has_many :customer_subscriptions
  belongs_to :customer
  # has_many :tea_subscriptions
  has_many :teas

  validates :title, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates :frequency, presence: true

  enum status: { :subscribed => 0, :cancelled => 1, :paused => 2 }
  enum frequency: { :weekly => 0, :bi_weekly => 1, :monthly => 2 }
end
