class HeritagesController < ApplicationController
  before_action :set_heritage, only: [:show, :edit, :update, :destroy]
  #para trocar o id do cliente cadastrado na tabela pelo nome dele nas views show e index
  before_action :show_name_client, only: [:new, :edit, :update, :create, :index]
  before_action :must_login

  #relatório
  def report_heritage
    @heritages = Heritage.includes(:client).all
    @total_heritages = Heritage.count
    #render layout: false
  end
  
  # GET /heritages
  # GET /heritages.json
  def index
    @heritages = Heritage.includes(:client).limit(10)
             
    @total_heritages = Heritage.count
    
        if params[:search] && params[:tipo_consulta] == "1"
            @heritages = Heritage.where("description like ?", "%#{params[:search]}%")
      
        elsif params[:search] && params[:tipo_consulta] == "2"
            @heritages = Heritage.where("type_contract like ?", "%#{params[:search]}%")
        end
    
  end

  # GET /heritages/1
  # GET /heritages/1.json
  def show
    #exibe o nome do cliente ao invés do id na view show
    @client = Client.find(@heritage.client_id)
        
  end

  # GET /heritages/new
  def new
    @heritage = Heritage.new
  end

  # GET /heritages/1/edit
  def edit
  end

  # POST /heritages
  # POST /heritages.json
  def create
    @heritage = Heritage.new(heritage_params)

    respond_to do |format|
      if @heritage.save
        format.html { redirect_to @heritage, notice: 'patrimonio criado com sucesso.' }
        format.json { render :show, status: :created, location: @heritage }
      else
        format.html { render :new }
        format.json { render json: @heritage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heritages/1
  # PATCH/PUT /heritages/1.json
  def update
    respond_to do |format|
      if @heritage.update(heritage_params)
        format.html { redirect_to @heritage, notice: 'patrimonio atualizado com sucesso' }
        format.json { render :show, status: :ok, location: @heritage }
      else
        format.html { render :edit }
        format.json { render json: @heritage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heritages/1
  # DELETE /heritages/1.json
  def destroy
    @heritage.destroy
    respond_to do |format|
      format.html { redirect_to heritages_url, notice: 'patrimonio excluido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heritage
      @heritage = Heritage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def heritage_params
      params.require(:heritage).permit(:description, :type_contract, :client_id)
    end
    
    #mostra o nome do cliente ao invés do id
    def show_name_client
      @clients = Client.order(:name)
    end
    
end
