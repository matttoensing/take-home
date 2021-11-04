class Api::V1::CustomersController < ApplicationController
  def show
    json_response(CustomerSerializer.new(Customer.find(params[:id])))
  end

  def create
    json_response(CustomerSerializer.new(Customer.create!(customer_params)), :created)
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :address)
  end
end
