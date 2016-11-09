class MechanicsController < ApplicationController
  def index
  	@mechanic = current_user
  	@available_issues = Issue.where(open: true)
  end 
end 