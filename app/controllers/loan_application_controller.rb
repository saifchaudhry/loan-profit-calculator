class LoanApplicationController < ApplicationController
  def create
    phone_number = formatted_phone_number
    @loan_application = LoanApplication.new(loan_application_params)
    @loan_application.phone_number = phone_number

    if @loan_application.save
      flash[:success] = 'Loan application was successfully created.'
      redirect_to loan_application_show_path(@loan_application)
    else
      flash.now[:error] = @loan_application.errors.full_messages
      render :new
    end
  end

  def new
    @loan_application = LoanApplication.new
  end

  def show
    @loan_application = LoanApplication.find_by(id: params[:id])
    if @loan_application
      @profit = Loan::CalculateProfitService.new(@loan_application).call
    else
      flash[:alert] = 'Loan application not found.'
      redirect_to root_path
    end
  end

  private

  def loan_application_params
    params.require(:loan_application).permit(:target_property, :loan_term, :purchase_price,
                                             :estimated_budget_repair, :after_repair_value,
                                             :first_name, :last_name, :email, :phone_number)
  end

  def formatted_phone_number
    country_code = params.require(:loan_application).delete(:country_code)
    "#{country_code}#{loan_application_params[:phone_number]}"
  end
end
