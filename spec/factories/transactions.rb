FactoryGirl.define do
  factory :transaction do
    description "MyString"
    amount "9.99"
    type 1
    account nil
  end
end
