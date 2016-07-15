class StaticController < ApplicationController

  def home
  end

  def about
  end

  def donate
  end

  def allnear
    latitude_start = params[:bottom].to_f
    latitude_end = params[:top].to_f
    longitude_start = params[:right].to_f
    longitude_end = params[:left].to_f
    @pokespawns = Pokespawn.all
    @pokestops = Pokestop.all
    @gyms = Gym.all
    #@pokespawns = Pokespawn.where(latitude: latitude_end..latitude_start, longitude: longitude_start..longitude_end, created_at: 30.minutes.ago..Time.now)
    #@pokestops = Pokestop.where(latitude: latitude_end..latitude_start, longitude: longitude_start..longitude_end)
    #@gyms = Gym.where(latitude: latitude_end..latitude_start, longitude: longitude_start..longitude_end)
    respond_to do |format|
      format.json { render json: {gyms: @gyms, stops: @pokestops, spawns: @pokespawns}, status: :ok }
    end
  end
end
