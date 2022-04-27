FactoryBot.define do
  factory :user do
    sequence(:account) { |number| "s_ochi+test-#{number}@ga-tech.co.jp" }
    password { "password" }
    password_confirmation { "password" }
  end
end

