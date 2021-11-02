require 'rails_helper'

RSpec.describe 'subscription API' do
  describe 'happy path' do
    it 'can create a customer subscription' do
      customer = create(:customer)
      subscription_params = {
        title: 'Green Tea Subscription',
        price: 29.99,
        status: 'subscribed',
        frequency: 'weekly',
        customer_id: customer.id
      }

      post '/api/v1/subscriptions', params: { subscription: subscription_params }

      expect(response).to be_successful
      expect(response.status).to eq(201)

      new_subscription = Subscription.last

      expect(new_subscription.title).to eq(subscription_params[:title])
      expect(new_subscription.price).to eq(subscription_params[:price])
      expect(new_subscription.status).to eq(subscription_params[:status])
      expect(new_subscription.frequency).to eq(subscription_params[:frequency])
      expect(new_subscription.customer_id).to eq(customer.id)

      subscription = JSON.parse(response.body, symbolize_names: true)

      expect(subscription).to have_key(:data)
      expect(subscription[:data]).to have_key(:id)
      expect(subscription[:data]).to have_key(:type)
      expect(subscription[:data]).to have_key(:attributes)
      expect(subscription[:data][:attributes]).to have_key(:title)
      expect(subscription[:data][:attributes]).to have_key(:price)
      expect(subscription[:data][:attributes]).to have_key(:status)
      expect(subscription[:data][:attributes]).to have_key(:frequency)
    end
  end
end
