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
  end

  describe 'sad paths' do
    it 'will not send a list of customer subscriptions if the customer ID is invalid' do
      customer = create(:customer)
      subscription1 = create(:subscription, customer: customer)
      subscription2 = create(:subscription, customer: customer)

      get '/api/v1/customer_subscriptions/1234'

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
    end

    it 'will not send a list of customer subscriptions if the customer ID is a string' do
      customer = create(:customer)
      subscription1 = create(:subscription, customer: customer)
      subscription2 = create(:subscription, customer: customer)

      get '/api/v1/customer_subscriptions/NOTVALID'

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
    end
  end
end
