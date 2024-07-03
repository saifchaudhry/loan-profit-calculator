class LoanApplicationController < ApplicationController
  before_action :set_loan_application, only: [:show] 

  def create
    @loan_application = LoanApplication.new(loan_application_params)

    if @loan_application.save
      LoanApplicationMailer.estimated_profit_mail(@loan_application).deliver
      flash[:success] = ['Loan application was successfully created.']
      redirect_to loan_application_show_path(@loan_application)
    else
      flash.now[:error] = @loan_application.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @loan_application = LoanApplication.new
  end

  def show
    redirect_to root_path, flash: { error: ['Loan application not found.'] } unless @loan_application
  end

  private

  def loan_application_params
    params.require(:loan_application).permit(:target_property, :loan_term, :purchase_price,
                                             :estimated_budget_repair, :after_repair_value,
                                             :first_name, :last_name, :email, :phone_number,
                                             :country_code)
  end

  def set_loan_application
    @loan_application = LoanApplication.find_by(id: params[:id])
  end
end
