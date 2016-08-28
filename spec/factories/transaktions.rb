FactoryGirl.define do
  factory :transaktion do
    description "MyString"
    amount "9.99"
    transaktion_type 1
    account nil
  end
end
