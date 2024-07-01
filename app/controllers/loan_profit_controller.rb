class LoanProfitController < ApplicationController
  before_action :format_phone_number, only: [:create]

  def create
    loan_profit = LoanProfit.new(loan_profit_params)
    loan_profit.phone_number = @format_phone_number

    if loan_profit.save!
      # profit = LoanProft::CalculateProfitService.new(calculator_params).call
      redirect_to loan_profit_show_path(loan_profit), notice: 'Record was successfully created.'
    end
  end

  def new
    @loan_profit = LoanProfit.new
  end

  def show
    @loan_profit = LoanProfit.find(params[:id])
    @profit = Loan::CalculateProfitService.new(@loan_profit).call
    # @profit = params[:profit]
  end

  private

    def loan_profit_params
      params.require(:loan_profit).permit(:target_property, :loan_term, :purchase_price, :estimated_budget_repair, :after_repair_value, :first_name, :last_name, :email, :phone_number)
    end

    def calculator_params
      loan_profit_params.slice(:loan_term, :purchase_price, :estimated_budget_repair, :after_repair_value)
    end

    def format_phone_number
      country_code = delete_country_code
      @format_phone_number = "#{country_code}#{loan_profit_params[:phone_number]}"
    end

    def delete_country_code
      params.require(:loan_profit).delete(:country_code)
    end
end
