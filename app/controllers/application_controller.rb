class ApplicationController < ActionController::Base
  def index
    render json: { message: "Travis OrbStack Rails Stack is running!", status: "ok" }
  end
end
