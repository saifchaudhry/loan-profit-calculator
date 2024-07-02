class CreateLoanApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :loan_applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :target_property
      t.integer :loan_term
      t.integer :purchase_price
      t.integer :estimated_budget_repair
      t.integer :after_repair_value
      t.integer :loan_amount
      t.string :phone_number

      t.timestamps
    end
  end
end
