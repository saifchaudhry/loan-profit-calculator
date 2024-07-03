class LoanApplication < ApplicationRecord
	MAX_LOAN_AMOUNT_ON_PURCHASE_PRICE = 0.90 # 90% of Purchase Price
	MAX_LOAN_AMOUNT_ON_ARV = 0.70 # 70% of ARV

	# Extesnsions
	strip_attributes

	# Validations
	validates :target_property, :loan_term, :purchase_price, :estimated_budget_repair,
  					:after_repair_value, :first_name, :email, :phone_number, presence: true

  validates :loan_term, numericality: { only_integer: true, greater_than: 0,
                                        less_than_or_equal_to: 12 }

  validates :purchase_price, :estimated_budget_repair, :after_repair_value,
            numericality: { only_integer: true, greater_than: 0 }

  validates :phone_number, presence: true, format: {
	  with: /\A(\+\d{1,3}\s?)?\(?\d{1,4}\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}\z/,
	  message: "should be a valid phone number"
	}

	# callbacks
	before_save :initiate_loan_and_profit

	def full_name
		"#{first_name} #{last_name}"
	end

	def max_loan_on_purchase_price
		MAX_LOAN_AMOUNT_ON_PURCHASE_PRICE * purchase_price
	end

	def max_loan_on_arv
		MAX_LOAN_AMOUNT_ON_ARV * after_repair_value
	end

	def initiate_loan_and_profit
		self.loan_amount = [max_loan_on_purchase_price, max_loan_on_arv].min
		calculated_proft = Loan::CalculateProfitService.new(self).call
		self.estimated_profit = calculated_proftc[:estimated_profit]
		self.return_rate = calculated_proft[:return_rate]
	end

	def phone_number_with_country_code
		"#{country_code}#{phone_number}"
	end
end
