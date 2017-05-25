class LicencasController < ApplicationController
  before_action :set_licenca, only: [:show, :edit, :update, :destroy]
  before_action :show_patrimonio_name, only: [:new, :edit, :update, :create, :index]
  before_action :must_login

  # GET /licencas
  # GET /licencas.json
  def index

      if params[:exportar] == 'SIM'
      @licencas = Licenca.joins(:patrimonio).select('produto as Produto, serial as Serial, patrimonios.numero_patrimonio as Numero_patrimonio, patrimonios.descricao as Descrição, status as Status').order('produto, status')
      else
      @licencas = Licenca.order(:produto)
      @conta_licencas = Licenca.count
      
      @em_uso = Licenca.where('status = ?', 'OK - Em uso').count
      @sem_utilizar = Licenca.where('status = ?', 'OK - Sem utilização').count
      @sem_doc = Licenca.where('status = ?', 'Sem documentação').count
        
      end
        
      respond_to do |format|
      format.html # don't forget if you pass html
      #format.xls { send_data(@clients.to_xls) }
      #renomeando o arquivo
      format.xls {
       
         filename = "Cadastro de Licenças-#{Time.now.strftime("%d%m%Y%H%M%S")}.xlsx"
         send_data(@licencas.to_xls, :type => "text/xls; charset=utf-8; header=present", :filename => filename)
         }
      end
       
    @licencas = Licenca.order(:produto)
    @conta_licencas = Licenca.count

    @licencas = Licenca.order(:produto)
    @conta_licencas = Licenca.count

  end

  # GET /licencas/1
  # GET /licencas/1.json
  def show
  end

  # GET /licencas/new
  def new
    @licenca = Licenca.new
  end

  # GET /licencas/1/edit
  def edit
  end

  # POST /licencas
  # POST /licencas.json
  def create
    @licenca = Licenca.new(licenca_params)

    respond_to do |format|
      if @licenca.save
        format.html { redirect_to @licenca, notice: 'Licença criada com sucesso.' }
        format.json { render :show, status: :created, location: @licenca }
      else
        format.html { render :new }
        format.json { render json: @licenca.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /licencas/1
  # PATCH/PUT /licencas/1.json
  def update
    respond_to do |format|
      if @licenca.update(licenca_params)
        format.html { redirect_to @licenca, notice: 'Licença atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @licenca }
      else
        format.html { render :edit }
        format.json { render json: @licenca.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /licencas/1
  # DELETE /licencas/1.json
  def destroy
    @licenca.destroy
    respond_to do |format|
      format.html { redirect_to licencas_url, notice: 'Licença excluida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_licenca
      @licenca = Licenca.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def licenca_params
      params.require(:licenca).permit(:produto, :serial, :patrimonio_id, :descricao, :status)
    end
    
        def show_patrimonio_name
      @patrimonios = Patrimonio.order(:numero_patrimonio)
    end
end
