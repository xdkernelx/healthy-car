class SpecialsController < ApplicationController
	def index
		@report_type = params[:report_type] if params[:report_type]
		@issue_id = params[:issue_id] if params[:issue_id]
		@car_id = params[:car_id] if params[:car_id]
		@token = params[:token] if params[:token]
		if @report_type == "Issue"
			@repair = Repair.new
			@repair.repairable = Issue.find(params[:issue_id])
		elsif @report_type == "Maintenance"
			@maintenance = Maintenance.new
		end

	end

	def create
		
	end


end