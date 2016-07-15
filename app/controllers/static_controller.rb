class StaticController < ApplicationController

  def home
    @pokemon = Pokemon.all
  end

  def about
  end

  def donate
  end

  def poll
  end

  def allnear
    latitude_start = params[:bottom].to_f
    latitude_end = params[:top].to_f
    longitude_start = params[:right].to_f
    longitude_end = params[:left].to_f
    @pokespawns = Pokespawn.where(latitude: latitude_start..latitude_end, longitude: longitude_end..longitude_start, created_at: 30.minutes.ago..Time.now)
    @pokestops = Pokestop.where(latitude: latitude_start..latitude_end, longitude: longitude_end..longitude_start)
    @gyms = Gym.where(latitude: latitude_start..latitude_end, longitude: longitude_end..longitude_start)
    respond_to do |format|
      format.json { render json: {gyms: @gyms, stops: @pokestops, spawns: @pokespawns}, status: :ok }
    end
  end
end
