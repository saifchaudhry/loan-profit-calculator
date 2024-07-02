# spec/services/calculate_profit_service_spec.rb

require 'rails_helper'

RSpec.describe Loan::CalculateProfitService do
  let(:loan_application) { create(:loan_application, loan_term: 12, purchase_price: 100000, estimated_budget_repair: 5000, after_repair_value: 120000, loan_amount: 70000) }

  subject { described_class.new(loan_application) }

  describe '#call' do
    it 'calculates estimated profit' do
      expect(subject.call[:estimated_profit]).to eq(25080.0)
    end

    it 'calculates return rate' do
      expect(subject.call[:return_rate]).to eq(26.42)
    end
  end
end
