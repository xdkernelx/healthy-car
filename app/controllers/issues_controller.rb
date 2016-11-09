class IssuesController < ApplicationController
  include SpecialsHelper
  
  before_action :find_car_and_issue, only: [:show, :edit, :update, :destroy]
  before_action :find_car_and_new_issue, only: [:new]

  def index
    @car = Car.find(params[:car_id])
    @issues = @car.issues
  end

  def show
    @repairs = @issue.repairs 
  end

  def new
  end 

  def edit
  end

  def create
    @issue = Issue.new(issue_params)
    @car = Car.find(params[:car_id])
      if @issue.save
        redirect_to car_issues_path(@car)
      else
        @errors = @issue.errors.full_messages
      render 'new'
    end
  end

  def update
    if @issue.update(issue_params)
	     redirect_to car_issues_path(@car)
    else
	     @errors = @issue.errors.full_messages
	     render 'edit'
    end
  end

  def destroy 
    @issue.destroy
    redirect_to car_issues_path(@car)
  end 
	
  private

  def issue_params
    params.require(:issue).permit(:title, :description, :urgency, :open, :car_id)
  end

  def find_car_and_issue
    @issue = Issue.find(params[:id])
    @car = Car.find(params[:car_id])
  end 

  def find_car_and_new_issue
    @issue = Issue.new
    @car = Car.find(params[:car_id])
  end

end
