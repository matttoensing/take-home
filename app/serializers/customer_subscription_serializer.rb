class CustomerSubscriptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :subscriptions
end
