require 'rails_helper'

RSpec.describe 'customer subscription API' do
  describe 'happy path' do
    it 'can send a list of customer subscriptions' do
      customer = create(:customer)
      subscription1 = create(:subscription, customer: customer)
      subscription2 = create(:subscription, customer: customer)

      get "/api/v1/customer_subscriptions/#{customer.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      customer_subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(customer_subscriptions).to have_key(:data)
      expect(customer_subscriptions[:data]).to have_key(:type)
      expect(customer_subscriptions[:data]).to have_key(:id)
      expect(customer_subscriptions[:data]).to have_key(:attributes)
      expect(customer_subscriptions[:data][:attributes]).to have_key(:subscriptions)

      customer_subscriptions[:data][:attributes][:subscriptions].each do |subscription|
        expect(subscription).to have_key(:title)
        expect(subscription).to have_key(:price)
        expect(subscription).to have_key(:status)
      end
    end

    it 'can create a customer subscription' do
      customer = create(:customer)
      subscription = create(:subscription, customer: customer)
      customer_sub_params = {
        customer_id: customer.id,
        subscription_id: subscription.id
      }

      post '/api/v1/customer_subscriptions', params: { customer_subscription: customer_sub_params }

      expect(response).to be_successful
      expect(response.status).to eq(201)

      # new_customer_subscription = CustomerSubscription.last

      expect(new_customer_subscription.customer_id).to eq(customer.id)
      expect(new_customer_subscription.subscription_id).to eq(subscription.id)

      customer_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(customer_subscription).to have_key(:data)
      expect(customer_subscription[:data]).to have_key(:id)
      expect(customer_subscription[:data]).to have_key(:type)
      expect(customer_subscription[:data]).to have_key(:attributes)
      expect(customer_subscription[:data][:attributes]).to have_key(:subscriptions)

      customer_subscription[:data][:attributes][:subscriptions].each do |subscription|
        expect(subscription).to have_key(:title)
        expect(subscription).to have_key(:price)
        expect(subscription).to have_key(:status)
      end
    end
  end
end
