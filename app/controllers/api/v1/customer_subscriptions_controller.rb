class Api::V1::CustomerSubscriptionsController < ApplicationController
  def show
    json_response(CustomerSubscriptionSerializer.new(Customer.find(params[:id])))
  end

  def create
    customer_subscription = CustomerSubscription.create(customer_subscription_params)

    json_response(CustomerSubscriptionSerializer.new(customer_subscription.customer), :created)
  end

  private

  def customer_subscription_params
    params.require(:customer_subscription).permit(:customer_id, :subscription_id)
  end
end
