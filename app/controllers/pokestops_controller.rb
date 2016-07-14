class PokestopsController < ApplicationController
  before_action :set_pokestop, only: [:show, :edit, :update, :destroy]

  # GET /pokestops
  # GET /pokestops.json
  def index
    latitude_start = params[:bottom].to_f
    latitude_end = params[:top].to_f
    longitude_start = params[:right].to_f
    longitude_end = params[:left].to_f
    @pokespawns = Pokespawn.none
    @pokestops = Pokestop.all
    @gyms = Gym.none
    #@pokespawns = Pokespawn.where(latitude: latitude_end..latitude_start, longitude: longitude_start..longitude_end, created_at: 30.minutes.ago..Time.now)
    #@pokestops = Pokestop.where(latitude: latitude_end..latitude_start, longitude: longitude_start..longitude_end)
    #@gyms = Gym.where(latitude: latitude_end..latitude_start, longitude: longitude_start..longitude_end)
    respond_to do |format|
      format.json { render json: {gyms: @gyms, stops: @pokestops, spawns: @pokespawns}, status: :ok }
    end
  end

  # GET /pokestops/1
  # GET /pokestops/1.json
  def show
  end

  # GET /pokestops/new
  def new
    @pokestop = Pokestop.new
    respond_to do |format|
      format.json { render json: {attachmentPartial: render_to_string('/pokestops/_form.html.erb', layout: false, locals: {pokestop: @pokestop})}, status: :ok }
    end
  end

  # GET /pokestops/1/edit
  def edit
  end

  # POST /pokestops
  # POST /pokestops.json
  def create
    @pokestop = Pokestop.new(pokestop_params)

    respond_to do |format|
      if @pokestop.save
        format.html { redirect_to root_url, notice: 'Pokestop was successfully created.' }
        format.json { render :show, status: :created, location: @pokestop }
      else
        format.html { render :new }
        format.json { render json: @pokestop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pokestops/1
  # PATCH/PUT /pokestops/1.json
  def update
    respond_to do |format|
      if @pokestop.update(pokestop_params)
        format.html { redirect_to @pokestop, notice: 'Pokestop was successfully updated.' }
        format.json { render :show, status: :ok, location: @pokestop }
      else
        format.html { render :edit }
        format.json { render json: @pokestop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pokestops/1
  # DELETE /pokestops/1.json
  def destroy
    @pokestop.destroy
    respond_to do |format|
      format.html { redirect_to pokestops_url, notice: 'Pokestop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokestop
      @pokestop = Pokestop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokestop_params
      params.require(:pokestop).permit(:name, :latitude, :longitude, :user_id)
    end
end
