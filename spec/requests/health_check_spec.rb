require 'rails_helper'

RSpec.describe "Health Checks", type: :request do
  describe "GET /up" do
    it "returns success" do
      get "/up"
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /" do
    it "returns success" do
      get "/"
      expect(response).to have_http_status(200)
    end

    it "returns the correct JSON response" do
      get "/"
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["message"]).to eq("Travis OrbStack Rails Stack is running!")
      expect(parsed_response["status"]).to eq("ok")
    end
  end
end
