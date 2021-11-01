require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    it { should have_many(:customer_subscriptions) }
    it { should have_many(:customers).through(:customer_subscriptions) }
    it { should have_many(:tea_subscriptions) }
    it { should have_many(:teas).through(:tea_subscriptions) }
  end

  describe 'validations' do
    it { should define_enum_for(:status).with([:subscribed, :cancelled, :paused]) }
    it { should define_enum_for(:frequency).with([:weekly, :bi_weekly, :monthly]) }
  end
end
