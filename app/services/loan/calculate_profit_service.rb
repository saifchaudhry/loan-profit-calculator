module Loan
	class CalculateProfitService
		MONTHLY_INTEREST = 0.13/12

		def initialize(loan_profit)
			@loan_term = loan_profit.loan_term
			@purchase_price = loan_profit.purchase_price
			@estimated_budget_repair = loan_profit.estimated_budget_repair
			@after_repair_value = loan_profit.after_repair_value
			@loan_amount = loan_profit.loan_amount
		end

		def call
			{
				estimated_profit: estimated_profit,
				return_rate: return_rate
			}
		end

		private

			attr_reader :loan_term, :purchase_price, :estimated_budget_repair, :after_repair_value, :loan_amount

			def estimated_profit
				@estimated_profit ||= (after_repair_value - loan_amount - total_interest_expense).round(2)
			end

			def total_interest_expense
				@total_interest_expense ||= MONTHLY_INTEREST * loan_amount * loan_term
			end

			def total_expense
				loan_amount + total_interest_expense
			end

			def return_rate
				(estimated_profit/total_expense * 100).round(2)
			end
	end
end