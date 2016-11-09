class RepairsController < ApplicationController

  include RepairsHelper

  before_action :find_car_and_issue_and_repair, only: [:edit, :destroy]
  before_action :find_car_and_issue_and_new_repair, only: [:new]


  def edit
  end

  def new
  end

  def create
    @repair = Repair.new(repair_params)
    @repair.repairable = Issue.find(params[:issue_id])
    @car = Car.find(params[:car_id])
    @issue = Issue.find(params[:issue_id])

    if current_user.mech_status
      @repair.mechanic_id = current_user.id
    end

    if @repair.save
      update_mileage(@car, @repair.mileage)
      if current_user.mech_status == true
        render 'thanks'
      else
        redirect_to car_issue_path(@car, @issue)
      end
    else
      @errors = @repair.errors.full_messages
      render 'new'
    end
  end

  def update
    @repair = Repair.find(params[:id])
    @repair.repairable = Issue.find(params[:issue_id])
    @car = Car.find(params[:car_id])
    @issue = Issue.find(params[:issue_id])
    if @repair.update(repair_params)
     update_mileage(@car, @repair.mileage)
	   redirect_to car_issues_path(@car)
    else
	   @errors = @issue.errors.full_messages
	   render 'edit'
    end
  end

  def destroy
    @repair.destroy
    redirect_to car_issue_path(@car, @issue)
  end

private

  def repair_params
    params.require(:repair).permit(:title, :description, :mileage, :date_completed, :repairable)
  end

  def find_car_and_issue_and_repair
    @repair = Repair.find(params[:id])
    @car = Car.find(params[:car_id])
    @issue = Issue.find(params[:issue_id])
  end

  def find_car_and_issue_and_new_repair
    @repair = Repair.new
    @car = Car.find(params[:car_id])
    @issue = Issue.find(params[:issue_id])
  end

end
