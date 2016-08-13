FactoryGirl.define do
  factory :user do
    email "user@example.com"
    password "password"
    password_confirmation "password"

    factory :user_with_account do
      after(:create) do |user|
        create(:account, user: user)
      end
    end
  end
end
