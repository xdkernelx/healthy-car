require "rails_helper"

RSpec.describe User, :type => :model do

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

  context "user creation" do
    it "makes sures that our before(:all) model is created" do
      expect(@lindeman).to eq(@lindeman)
    end

    it "allows the phone entry to be blank (default status)" do
      expect(@lindeman.phone).to eq("")
    end
  end

  context "associations" do
    it "has an association with the cars that it has" do
      expect(@lindeman.cars).to match_array([@star, @dust])
    end

    it "has an association with it's issues through a specific car" do
      expect(@lindeman.cars.find(@star.id).issues).to match_array([@engine, @tail_light])
    end

    it "differentiates the child association of issues non-specific to a car" do
      expect(@lindeman.issues).to match_array([@engine, @tail_light, @back_light])
    end

    it "has an association with it's repairs through issues specific to a car" do
      expect(@lindeman.cars.find(@star.id).issues.find(@tail_light.id).repairs).to match_array([@tail_light_fix])
    end

    it "differentiates the child association of repairs non-specific to a car" do
      expect(@lindeman.repairs).to match_array([@tail_light_fix, @engine_fix])
    end

    it "has an association with it's maintenances specific to a car" do
      expect(@lindeman.cars.find(@star.id).maintenances).to match_array([@oil_change, @alignment])
    end

    it "differentiates the child associations non-specific to a car" do
      expect(@lindeman.maintenances).to match_array([@oil_change, @alignment, @tire_change])
    end
  end

  context "devise validations" do
    it "is invalid if the email is already taken" do
      @test = User.new(first_name: "Andy", last_name: "Lindeman", password: "password", email: "tester@test.com")
      expect(@test.valid?).to eq(false)
    end

    it "is invalid if the password is below 6" do
      @test = User.new(first_name: "Andy", last_name: "Lindeman", password: "12345", email: "different@test.com")
      expect(@test.valid?).to eq(false)
    end
  end

  context "phone validations" do
    it "checks if the phone integer is 10" do
      @test = User.new(first_name: "Andy", last_name: "Lindeman", phone: 1234567891, password: "123456", email: "different@test.com")
      expect(@test.valid?).to eq(true)
    end

    it "check if the phone integer is non-10" do
      @test = User.new(first_name: "Andy", last_name: "Lindeman", phone: "123456789", password: "123456", email: "different@test.com")
      expect(@test.valid?).to eq(false)
    end

    it "check if the phone can be entered as a string" do
      @test = User.new(first_name: "Andy", last_name: "Lindeman", phone: "1234567891", password: "123456", email: "different@test.com")
      expect(@test.valid?).to eq(true)
    end

    it "check if invalid is thrown with a non-numeric phone" do
      @test = User.new(first_name: "Andy", last_name: "Lindeman", phone: "123456789s", password: "123456", email: "different@test.com")
      expect(@test.valid?).to eq(false)
    end

  end

  context "zip_code validations" do
    it "check if the zip_code is length: 5 " do
      @test = User.new(first_name: "Andy", last_name: "Lindeman", zip_code: "09233", password: "123456", email: "different@test.com")
      expect(@test.valid?).to eq(true)
    end

    it "check if invalid is thrown with anything higher or lower than size: 5" do
      @test = User.new(first_name: "Andy", last_name: "Lindeman", zip_code: "123456", password: "123456", email: "different@test.com")
      expect(@test.valid?).to eq(false)
      @test = User.new(first_name: "Andy", last_name: "Lindeman", zip_code: "1234", password: "123456", email: "different@test.com")
      expect(@test.valid?).to eq(false)
    end
  end

end
