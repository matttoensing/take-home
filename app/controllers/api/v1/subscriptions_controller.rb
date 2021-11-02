class Api::V1::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.create(customer_subscription_params)

    json_response(SubscriptionSerializer.new(subscription), :created)
  end

  private

  def customer_subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id)
  end
end
