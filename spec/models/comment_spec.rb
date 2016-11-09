require 'rails_helper'

RSpec.describe Comment, type: :model do
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
    @comment = Comment.create(commentable: @oreilly, title: "Great", body: "Low price, great service")
  end

  context "comment creation" do
    it "creates the comment(s) we need" do
      expect(Comment.all).to eq([@comment])
    end

    it "commentable_type is accessible" do
      expect(@comment.commentable_type).to eq("Shop")
    end

    it "- maintenance comment" do
      @test = Comment.new(commentable: @oil_change, title: "Great", body: "Low price, great service")
      expect(@test.valid?).to eq(true)
      expect(@test.commentable_type).to eq("Maintenance")
    end

    it "- repair comment" do
      @test = Comment.new(commentable: @tail_light_fix, title: "Great", body: "Low price, great service")
      expect(@test.valid?).to eq(true)
      expect(@test.commentable_type).to eq("Repair")
    end

    # TODO Ticket comment
  end

end
