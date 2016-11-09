class SpecialsController < ApplicationController

	def index
		@report_type = params[:report_type] if params[:report_type]
		@issue_id = params[:issue_id] if params[:issue_id]
		@car_id = params[:car_id] if params[:car_id]
		@token = params[:token] if params[:token]
		if @report_type == "Issue"
			@repair = Repair.new
			@repair.repairable = Issue.find(params[:issue_id])
			p '*' * 100
			p @repair.repairable
		elsif @report_type == "Maintenance"
			@maintenance = Maintenance.new
		end
	end

	def show
	end

	def create
		@car = Car.find(params[:repair][:car_id])
		@issue = Issue.find(params[:repair][:issue_id])
		p '*' * 80
		p @issue
		p '*' * 80
		@repair = Repair.new(repair_params)
		@repair.repairable = @issue
		
		if @repair.save
			render 'thanks'
		else
			@errors = @repair.errors.full_messages
			redirect_to request.original_url
		end
	end

	private
	def repair_params
    params.require(:repair).permit(:title, :description, :mileage, :date_completed)
  end

end