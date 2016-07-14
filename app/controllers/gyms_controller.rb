class GymsController < ApplicationController
  before_action :set_gym, only: [:show, :edit, :update, :destroy]

  # GET /gyms
  # GET /gyms.json
  def index
    latitude_start = params[:bottom].to_f
    latitude_end = params[:top].to_f
    longitude_start = params[:right].to_f
    longitude_end = params[:left].to_f
    @pokespawns = Pokespawn.none
    @pokestops = Pokestop.none
    @gyms = Gym.all
    #@pokespawns = Pokespawn.where(latitude: latitude_end..latitude_start, longitude: longitude_start..longitude_end, created_at: 30.minutes.ago..Time.now)
    #@pokestops = Pokestop.where(latitude: latitude_end..latitude_start, longitude: longitude_start..longitude_end)
    #@gyms = Gym.where(latitude: latitude_end..latitude_start, longitude: longitude_start..longitude_end)
    respond_to do |format|
      format.json { render json: {gyms: @gyms, stops: @pokestops, spawns: @pokespawns}, status: :ok }
    end
  end

  # GET /gyms/1
  # GET /gyms/1.json
  def show
  end

  # GET /gyms/new
  def new
    @gym = Gym.new
    respond_to do |format|
      format.json { render json: {attachmentPartial: render_to_string('/gyms/_form.html.erb', layout: false, locals: {gym: @gym})}, status: :ok }
    end
  end

  # GET /gyms/1/edit
  def edit
  end

  # POST /gyms
  # POST /gyms.json
  def create
    @gym = Gym.new(gym_params)

    respond_to do |format|
      if @gym.save
        format.html { redirect_to @gym, notice: 'Gym was successfully created.' }
        format.json { render :show, status: :created, location: @gym }
      else
        format.html { render :new }
        format.json { render json: @gym.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gyms/1
  # PATCH/PUT /gyms/1.json
  def update
    respond_to do |format|
      if @gym.update(gym_params)
        format.html { redirect_to @gym, notice: 'Gym was successfully updated.' }
        format.json { render :show, status: :ok, location: @gym }
      else
        format.html { render :edit }
        format.json { render json: @gym.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gyms/1
  # DELETE /gyms/1.json
  def destroy
    @gym.destroy
    respond_to do |format|
      format.html { redirect_to gyms_url, notice: 'Gym was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gym
      @gym = Gym.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gym_params
      params.require(:gym).permit(:name, :latitude, :longitude, :user_id)
    end
end
