class VillesController < ApplicationController
  before_action :set_ville, only: [:show, :edit, :update, :destroy]

  # GET /villes
  # GET /villes.json
  def index
    @villes = Ville.all
  end

  # GET /villes/1
  # GET /villes/1.json
  def show
    forecast = ForecastIO.forecast(@ville.latitude, @ville.longitude)
    weatherCheck = false
    temperatureCheck = false
    
    if forecast
      todayForecast = forecast.currently
      if todayForecast
        if todayForecast.icon
          @weatherSummary = todayForecast.icon
          weatherCheck = true
        end
      if todayForecast.temperature
          @weatherTemperature = toCelsus(todayForecast.temperature)
          temperatureCheck = true
        end
      end
    end
  if !weatherCheck
      @weatherSummary =nil
    end
  if !temperatureCheck
      @weatherTemperature = nil
    end
    
    @temperatureColor = colorTemperature(@weatherTemperature)
    
  end

# Convertion Fahrenheit en Celsus
   def toCelsus(fahrenheitTemperature)
      if fahrenheitTemperature
        return (fahrenheitTemperature - 32.0) * 5.0 / 9.0
      else
        return nil
      end
    end




  # GET /villes/new
  def new
    @ville = Ville.new
  end

  # GET /villes/1/edit
  def edit
  end

  # POST /villes
  # POST /villes.json
  def create
    @ville = Ville.new(ville_params)

    respond_to do |format|
      if @ville.save
        format.html { redirect_to @ville, notice: 'Ville was successfully created.' }
        format.json { render :show, status: :created, location: @ville }
      else
        format.html { render :new }
        format.json { render json: @ville.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /villes/1
  # PATCH/PUT /villes/1.json
  def update
    respond_to do |format|
      if @ville.update(ville_params)
        format.html { redirect_to @ville, notice: 'Ville was successfully updated.' }
        format.json { render :show, status: :ok, location: @ville }
      else
        format.html { render :edit }
        format.json { render json: @ville.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /villes/1
  # DELETE /villes/1.json
  def destroy
    @ville.destroy
    respond_to do |format|
      format.html { redirect_to villes_url, notice: 'Ville was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ville
      @ville = Ville.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ville_params
      params.require(:ville).permit(:nom, :latitude, :longitude)
    end
end

# Color for display temperature
  def colorTemperature(celsusTemperature)
    if celsusTemperature.nil?
      return ""
    elsif celsusTemperature < 0
      return "text-info"
    elsif celsusTemperature < 15
      return "text-primary"
    elsif celsusTemperature < 30
      return "text-warning"
    else
      return "text-danger"
    end
  end
  
