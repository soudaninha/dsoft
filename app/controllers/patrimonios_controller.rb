class PatrimoniosController < ApplicationController
  before_action :set_patrimonio, only: [:show, :edit, :update, :destroy]
  before_action :show_ad_user_name, only: [:new, :edit, :update, :create, :index]
  before_action :must_login
  
  
  #para carregar a descrição do patrimonio selecionado
  def consulta_patrimonio
    @product = Patrimonio.select('descricao').where(numero_patrimonio: params[:name]).first
    respond_to do |format|
    format.html
    format.json { render :json => @product }
    end
    #------------DEU CERTO GLORIA Á DEUS!!!-----------------------------------------------
  end

  # GET /patrimonios
  # GET /patrimonios.json
  def index
      
    if params[:exportar] == 'SIM'
      @patrimonios = Patrimonio.joins(:ad_user).select('numero_patrimonio as Nº_patrimonio, descricao as Descrição, ad_users.colaborador as Colaborador').order('numero_patrimonio')
      else
      @patrimonios = Patrimonio.order(:numero_patrimonio)
      @conta_patrimonios = Patrimonio.count
      end
        
      respond_to do |format|
      format.html # don't forget if you pass html
      #format.xls { send_data(@clients.to_xls) }
      #renomeando o arquivo
      format.xls {
       
         filename = "Cadastro de Patrimonios-#{Time.now.strftime("%d%m%Y%H%M%S")}.xls"
         send_data(@patrimonios.to_xls, :type => "text/xls; charset=utf-8; header=present", :filename => filename)
         }
      end
    
    @patrimonios = Patrimonio.order(:numero_patrimonio)
    @conta_patrimonios = Patrimonio.count

    @patrimonios = Patrimonio.order(:numero_patrimonio)
    @conta_patrimonios = Patrimonio.count

  end

  # GET /patrimonios/1
  # GET /patrimonios/1.json
  def show
  end

  # GET /patrimonios/new
  def new
    @patrimonio = Patrimonio.new
  end

  # GET /patrimonios/1/edit
  def edit
  end

  # POST /patrimonios
  # POST /patrimonios.json
  def create
    @patrimonio = Patrimonio.new(patrimonio_params)

    respond_to do |format|
      if @patrimonio.save
        format.html { redirect_to @patrimonio, notice: 'Patrimonio criado com sucesso.' }
        format.json { render :show, status: :created, location: @patrimonio }
      else
        format.html { render :new }
        format.json { render json: @patrimonio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patrimonios/1
  # PATCH/PUT /patrimonios/1.json
  def update
    respond_to do |format|
      if @patrimonio.update(patrimonio_params)
        format.html { redirect_to @patrimonio, notice: 'Patrimonio atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @patrimonio }
      else
        format.html { render :edit }
        format.json { render json: @patrimonio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patrimonios/1
  # DELETE /patrimonios/1.json
  def destroy
    @patrimonio.destroy
    respond_to do |format|
      format.html { redirect_to patrimonios_url, notice: 'Patrimonio excluido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patrimonio
      @patrimonio = Patrimonio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patrimonio_params
      params.require(:patrimonio).permit(:numero_patrimonio, :descricao, :ad_user_id)
    end
    
    def show_ad_user_name
      @ad_users = AdUser.order(:colaborador)
    end
end
