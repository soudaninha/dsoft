class LicencesController < ApplicationController
  before_action :set_licence, only: [:show, :edit, :update, :destroy]
  before_action :show_client_name, only: [:new, :edit, :update, :create, :index]
  before_action :must_login
  
  # GET /licences
  # GET /licences.json
  def index
    @licences = Licence.includes(:client).all
  end

  # GET /licences/1
  # GET /licences/1.json
  def show
    @client = Client.find(@licence.client_id)
  
  end

  # GET /licences/new
  def new
    @licence = Licence.new
  end

  # GET /licences/1/edit
  def edit
  end

  # POST /licences
  # POST /licences.json
  def create
    @licence = Licence.new(licence_params)

    respond_to do |format|
      if @licence.save
        format.html { redirect_to @licence, notice: 'Licença criada com sucesso.' }
        format.json { render :show, status: :created, location: @licence }
      else
        format.html { render :new }
        format.json { render json: @licence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /licences/1
  # PATCH/PUT /licences/1.json
  def update
    respond_to do |format|
      if @licence.update(licence_params)
        format.html { redirect_to @licence, notice: 'Licença atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @licence }
      else
        format.html { render :edit }
        format.json { render json: @licence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /licences/1
  # DELETE /licences/1.json
  def destroy
    @licence.destroy
    respond_to do |format|
      format.html { redirect_to licences_url, notice: 'Licença excluida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_licence
      @licence = Licence.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def licence_params
      params.require(:licence).permit(:client_id, :serial_bios, :type_licence, :price)
    end
    
    def show_client_name
      @clients = Client.order(:name)
      
    end
end
