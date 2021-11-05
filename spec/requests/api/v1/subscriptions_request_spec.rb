require 'rails_helper'

RSpec.describe 'subscription API' do
  describe 'happy path' do
    it 'can create a customer subscription' do
      customer = create(:customer)
      subscription_params = {
        title: 'Green Tea Subscription',
        price: 29.99,
        frequency: 'weekly',
        customer_id: customer.id
      }

      post '/api/v1/subscriptions', params: { subscription: subscription_params }

      expect(response).to be_successful
      expect(response.status).to eq(201)

      new_subscription = Subscription.last

      expect(new_subscription.title).to eq(subscription_params[:title])
      expect(new_subscription.price).to eq(subscription_params[:price])
      expect(new_subscription.status).to eq('subscribed')
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

    it 'can update/cancel the status of a subscription' do
      customer = create(:customer)
      subscription = create(:subscription, status: :subscribed, customer: customer)
      updated_params = {
        status: 'cancelled'
      }

      patch "/api/v1/subscriptions/#{subscription.id}", params: { subscription: updated_params}

      expect(response).to be_successful
      expect(response.status).to eq(200)

      updated_subscription = Subscription.find(subscription.id)

      expect(updated_subscription.status).to eq(updated_params[:status])

      json = JSON.parse(response.body, symbolize_names: true)\

      expect(json).to have_key(:data)
      expect(json[:data]).to have_key(:id)
      expect(json[:data]).to have_key(:type)
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to have_key(:title)
      expect(json[:data][:attributes]).to have_key(:price)
      expect(json[:data][:attributes]).to have_key(:status)
      expect(json[:data][:attributes]).to have_key(:frequency)
    end
  end
end
