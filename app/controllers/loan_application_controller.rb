class LoanApplicationController < ApplicationController
  before_action :format_phone_number, only: [:create]

  def create
    loan_application = LoanApplication.new(loan_application_params)
    loan_application.phone_number = @format_phone_number

    if loan_application.save!
      # profit = LoanProft::CalculateProfitService.new(calculator_params).call
      redirect_to loan_application_show_path(loan_application), notice: 'Record was successfully created.'
    end
  end

  def new
    @loan_application = LoanApplication.new
  end

  def show
    @loan_application = LoanApplication.find(params[:id])
    @profit = Loan::CalculateProfitService.new(@loan_application).call
    # @profit = params[:profit]
  end

  private

    def loan_application_params
      params.require(:loan_application).permit(:target_property, :loan_term, :purchase_price, :estimated_budget_repair, :after_repair_value, :first_name, :last_name, :email, :phone_number)
    end

    def calculator_params
      loan_application_params.slice(:loan_term, :purchase_price, :estimated_budget_repair, :after_repair_value)
    end

    def format_phone_number
      country_code = delete_country_code
      @format_phone_number = "#{country_code}#{loan_application_params[:phone_number]}"
    end

    def delete_country_code
      debugger
      params.require(:loan_application).delete(:country_code)
    end
end
