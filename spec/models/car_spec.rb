require "rails_helper"

RSpec.describe Car, :type => :model do

  before(:all) do
    User.destroy_all
    Car.destroy_all
    Maintenance.destroy_all
    @lindeman = User.create(first_name: "Andy", last_name: "Lindeman", password: "password", email: "tester@test.com")
    @travis = User.create(first_name: "Bob", last_name: "Builder", password: "password", email: "tester2@test.com", mech_status: true)
    @star = Car.create(user_id: @lindeman.id, mileage: 100, vin: "11111111111111111")
    @dust = Car.create(user_id: @lindeman.id, mileage: 20, vin: "11111111111111119")
    @engine = Issue.create(car_id: @star.id, title: "Tail Light Problem", description: "The light will not turn on")
    @tail_light = Issue.create(car_id: @star.id, title: "Engine won't turn on", description: "See Title", open: true)
    @back_light = Issue.create(car_id: @dust.id, title: "Engine won't turn on", description: "See Title")
    @tail_light_fix = Repair.create(issue_id: @tail_light.id, mechanic_id: @travis.id, title: "Tail Light Wiring", description: "Tail light wiring messing with the engine", mileage: 3200, date_completed: "11/04/2016")
    @engine_fix = Repair.create(issue_id: @engine.id, mechanic_id: @travis.id, title: "Engine dead", description: "Engine is dead. Please buy a new one", mileage: 3200, date_completed: "11/04/2016")
    @oil_change = Maintenance.create(car_id: @star.id, mechanic_id: @travis.id, title: "Scheduled Oil Change", description: "See Title", mileage: 200, date_completed: "11/04/2016")
    @alignment = Maintenance.create(car_id: @star.id, mechanic_id: @travis.id, title: "Scheduled Alignment", description: "Off by 1 degree", mileage: 200, date_completed: "11/04/2016")
    @tire_change = Maintenance.create(car_id: @dust.id, mechanic_id: @travis.id, title: "Scheduled Alignment", description: "Off by 1 degree", mileage: 200, date_completed: "11/04/2016")
  end

  context "parent assocation" do
    it "correctly associates the user" do
      expect(@star.user).to eq(@lindeman)
    end

    it "return false when the user is having an existential crisis" do
      @test = Car.new(user_id: 0, mileage: 1, vin: "333333FFFFFF66667")
      expect( @test.valid? ).to eq(false)
    end
  end

  context "child assocations" do
    it "has an assocation with maintenances" do
      expect(@star.maintenances).to match_array([@oil_change, @alignment])
    end

    it "has an assocation with issues" do
      expect(@star.issues).to match_array([@engine, @tail_light])
    end

    it "has an associaton with repairs specific to an issue" do
      expect(@star.issues.find(@tail_light.id).repairs).to match_array([@tail_light_fix])
    end

    it "differentiates between repairs non-specific to an issue" do
      expect(@star.repairs).to match_array([@tail_light_fix, @engine_fix])
    end
  end

  context "mileage validations" do
    it "checks to see that anything lower than 0 is invalid for mileage" do
        @test = Car.new(user_id: @lindeman.id, mileage: -1, vin: "333333FFFFFF66667")
        expect( @test.valid? ).to eq(false)
        @test = Car.new(user_id: @lindeman.id, mileage: 0, vin: "333333FFFFFF66667")
        expect( @test.valid? ).to eq(false)
      end

    it "checks to see if a positive integer is valid" do
      @test = Car.new(user_id: @lindeman.id, mileage: 1, vin: "333333FFFFFF66667")
      expect( @test.valid? ).to eq(true)
    end
  end

  context "VIN validation" do
    it "is invalid if the VIN is not alphanumeric" do
      @test = Car.new(user_id: @lindeman.id, mileage: 100, vin: "333333FFFFFF6666$")
      expect( @test.valid? ).to eq(false)
    end

    it "is valid if the VIN is alphanumeric" do
      @test = Car.new(user_id: @lindeman.id, mileage: 100, vin: "333333FFFFFF66667")
      expect( @test.valid? ).to eq(true)
    end
  end

end
