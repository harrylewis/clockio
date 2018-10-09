class WelcomeController < ApplicationController
  def index
    redirect_to clock_events_path
  end
end
