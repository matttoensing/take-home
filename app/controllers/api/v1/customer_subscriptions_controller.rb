class Api::V1::CustomerSubscriptionsController < ApplicationController
  def show
    json_response(CustomerSubscriptionSerializer.new(Customer.find(params[:id]))) 
  end
end
