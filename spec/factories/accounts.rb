FactoryGirl.define do
  factory :account do
    name "example account"
    balance 10
    user nil

    factory :account_with_transaktion do
      after(:create) do |account|
        create(:transaktion, account: account)
      end
    end
  end
end
