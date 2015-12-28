require "rails_helper"

RSpec.describe WebinarsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/webinars").to route_to("webinars#index")
    end

    it "routes to #new" do
      expect(:get => "/webinars/new").to route_to("webinars#new")
    end

    it "routes to #show" do
      expect(:get => "/webinars/1").to route_to("webinars#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/webinars/1/edit").to route_to("webinars#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/webinars").to route_to("webinars#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/webinars/1").to route_to("webinars#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/webinars/1").to route_to("webinars#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/webinars/1").to route_to("webinars#destroy", :id => "1")
    end

  end
end
