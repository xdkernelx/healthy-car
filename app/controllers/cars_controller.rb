class CarsController < ApplicationController
	include SpecialsHelper

	before_action :find_car, only: [:show, :edit, :update, :destroy]

	def index
		if user_signed_in?
			@user = current_user
			@cars = @user.cars
		else
			@errors = 'sign in first'
		end
	end

	def show
	end

	def new
		@car = Car.new
	end

	def edit
	end

	def create
		@car = Car.new(car_params)
		@user = current_user
		@car.user_id = @user.id
		if @car.save
			redirect_to cars_path
		else
			render 'new'
		end
	end

	def update
		if @car.update(car_params)
			redirect_to @car
		else
			render 'edit'
		end
	end

	def destroy
		@car.destroy

		redirect_to cars_path
	end

	private
	def car_params
		params.require(:car).permit(:user_id, :mileage, :vin, :year, :make, :model, :color, :transmission, :engine, :image)
	end

	def find_car
		@car = Car.find(params[:id])
		@car.oil_change? ? @oil_change = @car.oil_change? : @oil_change = @car.mileage
	end
end
