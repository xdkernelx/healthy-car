class Permission < ApplicationRecord

  belongs_to :car
  belongs_to :issue, optional: true

  validates :report_type, :token, { presence: true }
  validates :report_type, format: { with: /\A[a-zA-Z]{1,11}\z/ }
  validate :authenticate_issue

  def authenticate_issue
    if self.issue_id
      begin
        issue = Issue.find(self.issue_id)
      rescue
        errors.add(:issue_id, "does not exist.")
      else
        issue = Issue.find(self.issue_id)
        if (issue.car.id != Car.find(self.car_id).id)
          errors.add(:issue_id, "does not match the car.")
        end
      end
    end
  end


end
