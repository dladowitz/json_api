require 'rails_helper'

describe UsersController do
  describe "POST #create" do
    subject { post :create, user: { email_address: "aiko@gmail.com", birthdate: Date.parse("2006-01-01") }}

    it "creates a new user in the database" do
      expect{ subject }.to change{ User.count }.by 1
    end

    it "returns status code of 201" do
      subject
      expect(response.status).to eq 201
    end

    it "returns the created user" do
      subject
      expect(JSON.parse(response.body)["email_address"]).to eq "aiko@gmail.com"
    end
  end

  describe "GET #index" do
    subject { get :index, format: :JSON }
    before do
      User.create email_address: "aiko@gmail.com", birthdate: Date.parse("2006-01-01")
      User.create email_address: "dusty@gmail.com", birthdate: Date.parse("2006-02-01")
      subject
      @users = JSON.parse response.body
    end

    it "returns all the users in the database" do
      expect(@users.count).to eq 2
    end

    it "returns a list of users" do
      expect(@users.first["email_address"]).to be_present
      expect(@users.first["birthdate"]).to be_present
    end
  end
end
