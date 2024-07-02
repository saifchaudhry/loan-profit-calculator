require 'rails_helper'

RSpec.describe LoanApplication, type: :model do
  let(:loan_application) { build(:loan_application, loan_term: 5, purchase_price: 1000, estimated_budget_repair: 500,
                                 after_repair_value: 2500 ) }
  context 'validations' do
    it 'is valid with valid attributes' do
      expect(loan_application).to be_valid
    end

    it 'is not valid without a target_property' do
      loan_application.target_property = nil
      expect(loan_application).not_to be_valid
    end

    it 'is not valid without a loan_term' do
      loan_application.loan_term = nil
      expect(loan_application).not_to be_valid
    end

    it 'is not valid without a purchase_price' do
      loan_application.purchase_price = nil
      expect(loan_application).not_to be_valid
    end

    it 'is not valid without an estimated_budget_repair' do
      loan_application.estimated_budget_repair = nil
      expect(loan_application).not_to be_valid
    end

    it 'is not valid without an after_repair_value' do
      loan_application.after_repair_value = nil
      expect(loan_application).not_to be_valid
    end

    it 'is not valid without a first_name' do
      loan_application.first_name = nil
      expect(loan_application).not_to be_valid
    end

    it 'is not valid without an email' do
      loan_application.email = nil
      expect(loan_application).not_to be_valid
    end

    it 'is not valid without a phone_number' do
      loan_application.phone_number = nil
      expect(loan_application).not_to be_valid
    end

    it 'is not valid with a non-integer loan_term' do
      loan_application.loan_term = 1.5
      expect(loan_application).not_to be_valid
    end

    it 'is not valid with a loan_term less than or equal to 0' do
      loan_application.loan_term = 0
      expect(loan_application).not_to be_valid
    end

    it 'is not valid with a loan_term greater than 12' do
      loan_application.loan_term = 13
      expect(loan_application).not_to be_valid
    end

    it 'is not valid with a non-integer purchase_price' do
      loan_application.purchase_price = 1.5
      expect(loan_application).not_to be_valid
    end

    it 'is not valid with a purchase_price less than or equal to 0' do
      loan_application.purchase_price = 0
      expect(loan_application).not_to be_valid
    end

    it 'is not valid with a non-integer estimated_budget_repair' do
      loan_application.estimated_budget_repair = 1.5
      expect(loan_application).not_to be_valid
    end

    it 'is not valid with an estimated_budget_repair less than or equal to 0' do
      loan_application.estimated_budget_repair = 0
      expect(loan_application).not_to be_valid
    end

    it 'is not valid with a non-integer after_repair_value' do
      loan_application.after_repair_value = 1.5
      expect(loan_application).not_to be_valid
    end

    it 'is not valid with an after_repair_value less than or equal to 0' do
      loan_application.after_repair_value = 0
      expect(loan_application).not_to be_valid
    end

    it 'is not valid with an improperly formatted phone_number' do
      loan_application.phone_number = 'invalid_phone_number'
      expect(loan_application).not_to be_valid
    end
  end

  context 'callbacks' do
    it 'assigns loan_amount before saving' do
      loan_application.save
      expected_loan_amount = [(0.90 * loan_application.purchase_price), (0.70 * loan_application.after_repair_value)].min
      expect(loan_application.loan_amount).to eq(expected_loan_amount)
    end
  end

  context 'instance methods' do
    it 'returns the full name' do
      expect(loan_application.full_name).to eq("#{loan_application.first_name} #{loan_application.last_name}")
    end
  end
end
