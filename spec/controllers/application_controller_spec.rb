require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "returns the correct JSON response" do
      get :index
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["message"]).to eq("Travis OrbStack Rails Stack is running!")
      expect(parsed_response["status"]).to eq("ok")
    end
  end
end
