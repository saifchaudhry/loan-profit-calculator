class LoanApplication < ApplicationRecord
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
	before_save :assign_loan_amount

	def full_name
		"#{first_name} #{last_name}"
	end

	def assign_loan_amount
		self.loan_amount = [(0.90 * purchase_price), (0.70 * after_repair_value)].min
	end
end
