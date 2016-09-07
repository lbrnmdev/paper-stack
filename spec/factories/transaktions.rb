FactoryGirl.define do
  factory :transaktion do
    amount 5.0
    description "deposit of five"
    transaktion_type 0 
    account nil
  end
end
