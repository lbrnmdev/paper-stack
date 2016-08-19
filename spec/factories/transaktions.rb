FactoryGirl.define do
  factory :transaktion do
    amount "9.99"
    description "MyString"
    transaktion_type 1
    account nil
  end
end
