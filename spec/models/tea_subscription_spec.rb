require 'rails_helper'

RSpec.describe TeaSubscription, type: :model do
  describe 'relationships' do
    it { should belong_to(:teas) }
    it { should belong_to(:subscriptions) }
  end
end
