# Loan Application Calculator README
=======================

# Setup Using Docker
	docker-compose up --build

# Manual local Setup
	1. Install Ruby 3.2.1
	2. bundle install
	3. rails db:create db:migrate
	4. bundle exec sidekiq
-----------------------

# Root Path
	localhost:3000
-----------------------

# Developer Guideline

# What we Build?
	Built an application that takes user input regarding their loan application and then we calculated profit for them based on the formula provided in task.

# How I Built and organised it?
	It is a simple MVC application that followed, basic CRUD operations.

	I saved user input into a database model called LoanApplication. I did all initial validation and assignment in this model. To make sure everything is working fine I wrote the rspec for model as well. 
	Model can be found here: app/models/loan_application.rb
	Rspec can be found here: spec/models/loan_application_spec.rb

	Upon creation of LoanApplication. I'm sending email to user that have PDF attached.

	Created a calculator Service for calculation of profit:
	You can find the service here: app/services/loan/calculate_profit_service.rb
	Spec for service can be found here: spec/services/calculate_profit_service_spec.rb

	Controller that controls the request can be found here: 
	app/controllers/loan_application_controller.rb
-----------------------

