require "rails_helper"

RSpec.describe Issue, :type => :model do

  before(:all) do
    User.destroy_all
    Car.destroy_all
    Issue.destroy_all
    Repair.destroy_all
    Maintenance.destroy_all
    Permission.destroy_all
    Shop.destroy_all
    Ticket.destroy_all
    Comment.destroy_all
    @lindeman = User.create(first_name: "Andy", last_name: "Lindeman", password: "password", email: "tester@test.com")
    @travis = User.create(first_name: "Bob", last_name: "Builder", password: "password", email: "tester2@test.com", mech_status: true)
    @star = Car.create(user_id: @lindeman.id, mileage: 100, vin: "11111111111111111")
    @dust = Car.create(user_id: @lindeman.id, mileage: 20, vin: "11111111111111119")
    @engine = Issue.create(car_id: @star.id, title: "Tail Light Problem", description: "The light will not turn on")
    @tail_light = Issue.create(car_id: @star.id, title: "Engine won't turn on", description: "See Title", open: true)
    @back_light = Issue.create(car_id: @dust.id, title: "Engine won't turn on", description: "See Title")
    @oreilly = Shop.create(name: "O'Reilly", mechanic_id: @travis.id, address: "636 Spruce St.", city: "San Francisco", state: "CA", zip_code: "94118")
    @tail_light_fix = Repair.create(repairable: @tail_light, shop_id: @oreilly.id, title: "Tail Light Wiring", description: "Tail light wiring messing with the engine", mileage: 3200, date_completed: "11/04/2016")
    @engine_fix = Repair.create(repairable: @engine, shop_id: @oreilly.id, title: "Engine dead", description: "Engine is dead. Please buy a new one", mileage: 3200, date_completed: "11/04/2016")
    @oil_change = Maintenance.create(car_id: @star.id, shop_id: @oreilly.id, title: "Scheduled Oil Change", description: "See Title", mileage: 200, date_completed: "11/04/2016")
    @alignment = Maintenance.create(car_id: @star.id, shop_id: @oreilly.id, title: "Scheduled Alignment", description: "Off by 1 degree", mileage: 200, date_completed: "11/04/2016")
    @tire_change = Maintenance.create(car_id: @dust.id, shop_id: @oreilly.id, title: "Scheduled Alignment", description: "Off by 1 degree", mileage: 200, date_completed: "11/04/2016")
  end

  context "issue creation" do
    it "Check to see if our Issues are saved" do
      expect(Issue.all).to match_array([@engine, @tail_light, @back_light])
    end
  end

  context "parent assocations" do
    it "It associates to a car" do
      expect(@tail_light.car).to eq(@star)
    end

    it "It associates to a car to a user" do
      expect(@tail_light.car.user).to eq(@lindeman)
    end
  end

  context "child association" do
    it "associates repairs specific to this issue" do
      expect(@engine.repairs).to match_array([@engine_fix])
      expect(@tail_light.repairs).to match_array([@tail_light_fix])
    end
  end

  context "urgency validation" do
    it "does not allow an urgency level at 0 or below" do
      @dashboard_light = Issue.new(car_id: @star.id, title: "Engine won't turn on", description: "See Title", open: true, urgency: 0)
      expect(@dashboard_light.valid?).to eq(false)
      @dashboard_light = Issue.new(car_id: @star.id, title: "Engine won't turn on", description: "See Title", open: true, urgency: -1)
      expect(@dashboard_light.valid?).to eq(false)
    end

    it "does not allow an urgency level at 6 or above" do
      @dashboard_light = Issue.new(car_id: @star.id, title: "Engine won't turn on", description: "See Title", open: true, urgency: 6)
      expect(@dashboard_light.valid?).to eq(false)
      @dashboard_light = Issue.new(car_id: @star.id, title: "Engine won't turn on", description: "See Title", open: true, urgency: 20)
      expect(@dashboard_light.valid?).to eq(false)
    end

    it "does allow a number between 1 and 5, inclusively" do
      @dashboard_light = Issue.new(car_id: @star.id, title: "Engine won't turn on", description: "See Title", open: true, urgency: 5)
      expect(@dashboard_light.valid?).to eq(true)
      @dashboard_light = Issue.new(car_id: @star.id, title: "Engine won't turn on", description: "See Title", open: true, urgency: 1)
      expect(@dashboard_light.valid?).to eq(true)
    end
  end

end
