# spec/factories/loan_application.rb
require 'securerandom'

FactoryBot.define do
  factory :loan_application do
    target_property { '1234 Elm Street, Apt. 56, Springfield, IL 62704' }
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'john.doe@example.com' }
    phone_number {'+10309406865'}
  end
end
