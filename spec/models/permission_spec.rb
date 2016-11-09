require 'rails_helper'

RSpec.describe Permission, type: :model do
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
    @token1 = Permission.create(car_id: @star.id, issue_id: @engine.id, report_type: "maintenance", token: "password")
    @token2 = Permission.create(car_id: @dust.id, issue_id: @back_light.id, report_type: "maintenance", token: "password")
  end

  context "permission creation" do
    it "creates our needed permissions" do
      expect(Permission.all).to match_array([@token1, @token2])
    end

    it "creates without an issue_id" do
      @test = Permission.new(car_id: @dust.id, report_type: "maintenance", token: "password")
      expect(@test.valid?).to eq(true)
    end
  end

  context "associations" do
    it "has an association with it's car" do
      expect(@token1.car).to eq(@star)
    end

    it "has an assocation with it's issue if an issue_id is given" do
      expect(@token1.issue).to eq(@engine)
    end
  end

  context "validations" do
    it "is invalid if a issue_id is invalid" do
      @test = Permission.new(car_id: @dust.id, issue_id: 0, report_type: "maintenance", token: "password")
      @test.valid?
      expect(@test.errors[:issue_id]).to match_array(["does not exist."])
    end

    it "is invalid if a issue_id is invalid" do
      @test = Permission.new(car_id: @star.id, issue_id: @back_light.id, report_type: "maintenance", token: "password")
      @test.valid?
      expect(@test.errors[:issue_id]).to match_array(["does not match the car."])
    end
  end
end
