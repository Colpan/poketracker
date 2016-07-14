class StaticController < ApplicationController
  require 'bigdecimal'

  def home
  end

  def allnear
    debugger
    latitude_start = BigDecimal.new(params[:bottom])
    latitude_end = BigDecimal.new(params[:top])
    longitude_start = BigDecimal.new(params[:right])
    longitude_end = BigDecimal.new(params[:left])
    @pokespawns = Pokespawn.where(latitude: latitude_start..latitude_end, longitude: longitude_start..longitude_end)
    @pokestops = Pokestop.where(latitude: latitude_start..latitude_end, longitude: longitude_start..longitude_end)
    @gyms = Gym.where(latitude: latitude_start..latitude_end, longitude: longitude_start..longitude_end)
    respond_to do |format|
      format.json { render json: {gyms: @gyms, stops: @pokestops, spawns: @pokespawns}, status: :ok }
    end
  end
end
