class PokespawnsController < ApplicationController
  before_action :set_pokespawn, only: [:show, :edit, :update, :destroy]

  # GET /pokespawns
  # GET /pokespawns.json
  def index
    @pokespawns = Pokespawn.all
  end

  # GET /pokespawns/1
  # GET /pokespawns/1.json
  def show
  end

  # GET /pokespawns/new
  def new
    @pokespawn = Pokespawn.new
    respond_to do |format|
      format.json { render json: {attachmentPartial: render_to_string('/pokespawns/_form.html.erb', layout: false, locals: {pokespawn: @pokespawn})}, status: :ok }
    end
  end

  # GET /pokespawns/1/edit
  def edit
  end

  # POST /pokespawns
  # POST /pokespawns.json
  def create
    @pokespawn = Pokespawn.new(pokespawn_params)

    respond_to do |format|
      if @pokespawn.save
        format.html { redirect_to @pokespawn, notice: 'Pokespawn was successfully created.' }
        format.json { render :show, status: :created, location: @pokespawn }
      else
        format.html { render :new }
        format.json { render json: @pokespawn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pokespawns/1
  # PATCH/PUT /pokespawns/1.json
  def update
    respond_to do |format|
      if @pokespawn.update(pokespawn_params)
        format.html { redirect_to @pokespawn, notice: 'Pokespawn was successfully updated.' }
        format.json { render :show, status: :ok, location: @pokespawn }
      else
        format.html { render :edit }
        format.json { render json: @pokespawn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pokespawns/1
  # DELETE /pokespawns/1.json
  def destroy
    @pokespawn.destroy
    respond_to do |format|
      format.html { redirect_to pokespawns_url, notice: 'Pokespawn was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokespawn
      @pokespawn = Pokespawn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokespawn_params
      params.require(:pokespawn).permit(:name, :latitude, :longitude, :user_id)
    end
end
