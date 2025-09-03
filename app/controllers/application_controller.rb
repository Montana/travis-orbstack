class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern  # Commented out - not available in this Rails version

  def index
    render json: { message: "Travis OrbStack Rails Stack is running!", status: "ok" }
  end
end
