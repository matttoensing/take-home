require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    # it { should have_many(:customer_subscriptions) }
    it { should belong_to(:customer) }
    # it { should have_many(:tea_subscriptions) }
    it { should have_many(:teas) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:frequency) }
    it { should define_enum_for(:status).with([:subscribed, :cancelled, :paused]) }
    it { should define_enum_for(:frequency).with([:weekly, :bi_weekly, :monthly]) }
  end
end
