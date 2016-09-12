require 'rails_helper'

describe UsersController do
  describe "POST #create" do

  end

  describe "GET #index" do
    subject { get :index, format: :JSON }
    before do
      User.create email_address: "aiko@gmail.com", birthdate: Date.parse("2006-01-01")
      User.create email_address: "dusty@gmail.com", birthdate: Date.parse("2006-02-01")
      subject
    end

    it "returns all the users in the database" do
      users = JSON.parse response.body
      expect(users.count).to eq 2
    end

    it "returns a list of users" do
      users = JSON.parse response.body
      expect(users.first["email_address"]).to be_present
      expect(users.first["birthdate"]).to be_present
    end
  end
end
