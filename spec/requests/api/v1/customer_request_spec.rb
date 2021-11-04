require 'rails_helper'

RSpec.describe 'customers api' do
  describe 'happy path' do
    it 'can send information about a single customer' do
      customer = create(:customer)

      get "/api/v1/customers/#{customer.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:data)
      expect(json[:data]).to have_key(:type)
      expect(json[:data]).to have_key(:id)
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to have_key(:first_name)
      expect(json[:data][:attributes][:first_name]).to eq(customer.first_name)
      expect(json[:data][:attributes]).to have_key(:last_name)
      expect(json[:data][:attributes][:last_name]).to eq(customer.last_name)
      expect(json[:data][:attributes]).to have_key(:email)
      expect(json[:data][:attributes][:email]).to eq(customer.email)
      expect(json[:data][:attributes]).to have_key(:address)
      expect(json[:data][:attributes][:address]).to eq(customer.address)
    end

    it 'can create a new customer' do
      customer_params = {
        first_name: 'Example',
        last_name: 'Last Name',
        email: 'example@example.com',
        address: '1234 Main st'
      }

      expect(Customer.count).to eq(0)

      post '/api/v1/customers', params: { customer: customer_params }

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(Customer.count).to eq(1)

      new_customer = Customer.last

      expect(new_customer.first_name).to eq(customer_params[:first_name])
      expect(new_customer.last_name).to eq(customer_params[:last_name])
      expect(new_customer.email).to eq(customer_params[:email])
      expect(new_customer.address).to eq(customer_params[:address])

      customer = JSON.parse(response.body, symbolize_names: true)

      expect(customer).to have_key(:data)
      expect(customer[:data]).to have_key(:type)
      expect(customer[:data]).to have_key(:id)
      expect(customer[:data]).to have_key(:attributes)
      expect(customer[:data][:attributes]).to have_key(:first_name)
      expect(customer[:data][:attributes]).to have_key(:last_name)
      expect(customer[:data][:attributes]).to have_key(:email)
      expect(customer[:data][:attributes]).to have_key(:address)
    end
  end

  describe 'sad paths' do
    it 'will not send a response if the customer id is invalid' do
      customer = create(:customer)

      get '/api/v1/customers/1234'

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
    end

    it 'will not send a response if the customer id is a string' do
      customer = create(:customer)

      get '/api/v1/customers/NOTVALID'

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
    end

    it 'will not create a customer if some of the information is missing' do
      customer_params = {
        first_name: 'Example',
        last_name: 'Last Name',
        email: 'example@example.com'
      }

      expect(Customer.count).to eq(0)

      post '/api/v1/customers', params: { customer: customer_params }

      expect(Customer.count).to eq(0)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
    end
  end
end
