module LoanProft
	class CalculateProfitService
		MONTHLY_INTEREST = 0.13/12

		def initialize(params)
			@loan_term = params[:loan_term].to_i
			@purchase_price = params[:purchase_price].to_i
			@estimated_budget_repair = params[:estimated_budget_repair].to_i
			@after_repair_value = params[:after_repair_value].to_i
		end

		def call
			{
				estimated_profit: estimated_profit,
				return_rate: return_rate
			}
		end

		private

			attr_reader :loan_term, :purchase_price, :estimated_budget_repair, :after_repair_value

			def estimated_profit
				(after_repair_value - loan_amount - total_interest_expense).round(2)
			end

			def return_rate
				(estimated_profit/total_expense * 100).round(2)
			end

			def total_interest_expense
				MONTHLY_INTEREST * loan_amount * loan_term
			end

			def loan_amount
				[max_loan_amount_by_purchase_price, max_loan_amount_by_arv].min
			end

			def total_expense
				loan_amount + total_interest_expense
			end

			def max_loan_amount_by_purchase_price
				0.90 * purchase_price
			end

			def max_loan_amount_by_arv
				0.70 * after_repair_value
			end
	end
end