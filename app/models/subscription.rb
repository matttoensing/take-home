class Subscription < ApplicationRecord
  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions

  validates :title, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates :frequency, presence: true

  enum status: { :subscribed => 0, :cancelled => 1, :paused => 2 }
  enum frequency: { :weekly => 0, :bi_weekly => 1, :monthly => 2 }
end
