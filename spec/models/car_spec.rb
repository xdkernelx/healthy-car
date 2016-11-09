require "rails_helper"

RSpec.describe Car, :type => :model do

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
    @matter = Car.create(user_id: @lindeman.id, mileage: 20, vin: "11111111111111119")
    @engine = Issue.create(car_id: @star.id, title: "Tail Light Problem", description: "The light will not turn on")
    @tail_light = Issue.create(car_id: @star.id, title: "Engine won't turn on", description: "See Title", open: true)
    @back_light = Issue.create(car_id: @dust.id, title: "Engine won't turn on", description: "See Title")
    @engine2 = Issue.create(car_id: @dust.id, title: "1", description: "The light will not turn on")
    @engine3 = Issue.create(car_id: @dust.id, title: "2", description: "The light will not turn on")
    @engine4 = Issue.create(car_id: @dust.id, title: "3", description: "The light will not turn on")
    @engine5 = Issue.create(car_id: @dust.id, title: "4", description: "The light will not turn on")
    @engine6 = Issue.create(car_id: @dust.id, title: "5", description: "The light will not turn on")
    @engine7 = Issue.create(car_id: @dust.id, title: "6", description: "The light will not turn on")
    @oreilly = Shop.create(name: "O'Reilly", mechanic_id: @travis.id, address: "636 Spruce St.", city: "San Francisco", state: "CA", zip_code: "94118")
    Issue.update(@back_light.id, title: "7")
    @tail_light_fix = Repair.create(repairable: @tail_light, shop_id: @oreilly.id, title: "Tail Light Wiring", description: "Tail light wiring messing with the engine", mileage: 3200, date_completed: "11/03/2016")
    @engine_fix2 = Repair.create(repairable: @engine, shop_id: @oreilly.id, title: "Engine dead", description: "Engine is dead. Please buy a new one", mileage: 3200, date_completed: "11/05/2016")
    @engine_fix = Repair.create(repairable: @engine, shop_id: @oreilly.id, title: "Engine dead", description: "Engine is dead. Please buy a new one", mileage: 3200, date_completed: "11/04/2016")
    @oil_change = Maintenance.create(car_id: @star.id, shop_id: @oreilly.id, title: "Scheduled Oil Change", description: "See Title", mileage: 200, date_completed: "11/04/2016")
    @oil_change2 = Maintenance.create(car_id: @star.id, shop_id: @oreilly.id, title: "oil change", description: "See Title", mileage: 2000, date_completed: "11/04/2016")
    @oil_change3 = Maintenance.create(car_id: @star.id, shop_id: @oreilly.id, title: "oil change", description: "See Title", mileage: 2000, date_completed: "11/04/2016")
    @oil_change4 = Maintenance.create(car_id: @star.id, shop_id: @oreilly.id, title: "oil change", description: "See Title", mileage: 2000, date_completed: "11/05/2016")
    @oil_change5 = Maintenance.create(car_id: @star.id, shop_id: @oreilly.id, title: "oil change", description: "See Title", mileage: 9000, date_completed: "11/06/2016")
    @alignment = Maintenance.create(car_id: @star.id, shop_id: @oreilly.id, title: "Scheduled Alignment", description: "Off by 1 degree", mileage: 200, date_completed: "11/04/2016")
    @alignment2 = Maintenance.create(car_id: @star.id, shop_id: @oreilly.id, title: "Scheduled Alignment", description: "Off by 1 degree", mileage: 200, date_completed: "12/04/2016")
    @tire_change = Maintenance.create(car_id: @dust.id, shop_id: @oreilly.id, title: "Scheduled Alignment", description: "Off by 1 degree", mileage: 200, date_completed: "11/04/2016")
    @oil_pressure = Maintenance.create(car_id: @matter.id, shop_id: @oreilly.id, title: "Scheduled Alignment", description: "Off by 1 degree", mileage: 200, date_completed: "11/04/2016")
    @oil_pressure2 = Maintenance.create(car_id: @matter.id, shop_id: @oreilly.id, title: "Scheduled Alignment", description: "Off by 1 degree", mileage: 200, date_completed: "11/04/2016")
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
      expect(@star.maintenances).to match_array([@oil_change, @alignment, @alignment2, @oil_change2, @oil_change3, @oil_change4, @oil_change5])
    end

    it "has an assocation with issues" do
      expect(@star.issues).to match_array([@engine, @tail_light])
    end

    it "has an associaton with repairs specific to an issue" do
      expect(@star.issues.find(@tail_light.id).repairs).to match_array([@tail_light_fix])
    end

    it "differentiates between repairs non-specific to an issue" do
      expect(@star.repairs).to match_array([@tail_light_fix, @engine_fix, @engine_fix2])
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

  context "Car.recent_issues" do
    it "- correctly orders by updated_at" do
      expect(@dust.recent_issues(5)).to eq([@back_light, @engine7, @engine6, @engine5, @engine4])
    end

    it "- gives the maximum orders even if under the given limit" do
      expect(@star.recent_issues(5)).to eq([@tail_light, @engine])
    end

    it "- returns an empty array if the car has no issues" do
      expect(@matter.recent_issues(5)).to eq([])
    end
  end

  context "Car.recent_maintenances" do
    it "- correctly order by date_completed" do
      expect(@star.recent_maintenances(2)).to eq([@oil_change5, @oil_change4])
    end
  end

  context "Car.recent_repairs" do
    it "- correctly orders by date_completed" do
      # Seemingly, if the dates match, it will sort by updated_at
      expect(@star.recent_repairs(2)).to eq([@engine_fix2, @engine_fix])
    end

    it "- returns an empty array if the car has no repairs" do
      expect(@matter.recent_issues(5)).to eq([])
    end
  end

  context "Car.oil_change?" do
    it "- returns true when the most recent 'oil change' maintenances are above the threshold" do
      expect(@star.oil_change?).to eq(5000)
    end

    it "- returns nil when the there are not enough maintenances" do
      expect(@dust.oil_change?).to eq(nil)
    end

    it "- returns nil when the there are not enough 'oil change' maintenances" do
      expect(@matter.oil_change?).to eq(nil)
    end
  end

end
