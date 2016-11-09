class UsersController < ApplicationController
	def index
    @car = Car.find(params[:car_id])
    @maintenances = @car.maintenances 
    @issues = @car.issues
	end
end