# spec/controllers/loan_application_controller_spec.rb
require 'rails_helper'

RSpec.describe LoanApplicationController, type: :controller do
  let(:valid_attributes) {
    FactoryBot.attributes_for(:loan_application).merge(
      loan_term: 5, purchase_price: 1000, estimated_budget_repair: 500,
      after_repair_value: 2500 )
  }

  let(:invalid_attributes) {
    { target_property: nil, loan_term: nil, purchase_price: nil, estimated_budget_repair: nil, after_repair_value: nil, first_name: nil, email: nil, phone_number: nil }
  }

 describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end

    it "assigns a new loan_application as @loan_application" do
      get :new
      expect(assigns(:loan_application)).to be_a_new(LoanApplication)
    end
  end

  describe "GET #show" do
    let(:loan_application) { create(:loan_application, loan_term: 5, purchase_price: 1000, estimated_budget_repair: 500,
                                    after_repair_value: 2500 ) }

    it "returns a success response" do
      get :show, params: { id: loan_application.to_param }
      expect(response).to be_successful
    end

    it "assigns the requested loan_application as @loan_application" do
      get :show, params: { id: loan_application.to_param }
      expect(assigns(:loan_application)).to eq(loan_application)
    end

    it "assigns the profit calculation as @profit" do
      profit = { estimated_profit: 1551.25, return_rate: 163.5 }
      get :show, params: { id: loan_application.to_param }
      expect(assigns(:profit)).to eq(profit)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new LoanApplication" do
        expect {
          post :create, params: { loan_application: valid_attributes }
        }.to change(LoanApplication, :count).by(1)
      end

      it "redirects to the created loan_application" do
        post :create, params: { loan_application: valid_attributes }
        expect(response).to redirect_to(loan_application_show_path(LoanApplication.last))
      end
    end

    context "with invalid params" do
      it "does not create a new LoanApplication" do
        expect {
          post :create, params: { loan_application: invalid_attributes }
        }.to change(LoanApplication, :count).by(0)
      end

      it "re-renders the 'new' template" do
        post :create, params: { loan_application: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "private methods" do
    let(:country_code) { '+1' }

    describe "#formatted_phone_number" do
      it "formats the phone number correctly" do
        controller.params = ActionController::Parameters.new(loan_application: valid_attributes.merge(country_code: country_code))
        formatted_phone_number = controller.send(:formatted_phone_number)
        expect(formatted_phone_number).to eq("#{country_code}#{valid_attributes[:phone_number]}")
      end
    end

    describe "#load_loan_application" do
      let(:loan_application) { create(:loan_application, loan_term: 5, purchase_price: 1000, estimated_budget_repair: 500,
                                      after_repair_value: 2500 ) }

      it "loads the requested loan_application" do
        get :show, params: { id: loan_application.to_param }
        expect(assigns(:loan_application)).to eq(loan_application)
      end

      it "redirects to root_path if loan application is not found" do
        get :show, params: { id: 'invalid_id' }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to be_present
      end
    end
  end
end