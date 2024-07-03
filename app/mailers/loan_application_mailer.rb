class LoanApplicationMailer < ApplicationMailer

  def estimated_profit_mail(loan_application)
    @loan_application = loan_application
    attachments["loan_application_#{@loan_application.id}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(pdf: "loan_application_#{loan_application.id}", template: 'loan_application/_estimated_profit',
                       locals: { loan_application: @loan_application })
    )
    mail(to: @loan_application.email, subject: 'Estimated profit email')
  end
end
