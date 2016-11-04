require "rails_helper"

RSpec.describe User, :type => :model do

  before(:each) do
    User.destroy_all
    @lindeman = User.create!(first_name: "Andy", last_name: "Lindeman", password: "password", email: "tester@test.com")
    @chelimsky = User.create!(first_name: "David", last_name: "Chelimsky", password: "password", email: "tester2@test.com")
  end

  it "allows the phone entry to be blank" do
    expect(@lindeman.phone).to eq(nil)
  end

end