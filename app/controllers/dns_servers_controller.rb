class DnsServersController < ApplicationController
  before_action :set_dns_server, only: [:show, :edit, :update, :destroy]
  #para trocar o id do cliente cadastrado na tabela pelo nome dela nas views show e index
  before_action :show_name_client, only: [:new, :edit, :update, :create, :index]
  before_action :must_login

  #gerando o relatório
  def report_dns
    @dns_servers = DnsServer.includes(:client).all
            
    @total_dns_servers = DnsServer.count
    #pra poder carregar o css somente que está no proprio relatório
    #render layout: false
  end
  
  
  def index
    @dns_servers = DnsServer.includes(:client).order(:email)
            
    @total_dns_servers = DnsServer.count
    
        if params[:search] && params[:tipo_consulta] == "1"
    @dns_servers = DnsServer.where("email like ?", "%#{params[:search]}%")
      
      elsif params[:search] && params[:tipo_consulta] == "2"
          @dns_servers = DnsServer.where("dns like ?", "%#{params[:search]}%")
 
    end
    
  end

  # GET /dns_servers/1
  # GET /dns_servers/1.json
  def show
    #exibe o nome do cliente ao inves do id
    @client = Client.find(@dns_server.client_id)
  end

  # GET /dns_servers/new
  def new
    @dns_server = DnsServer.new
  end

  # GET /dns_servers/1/edit
  def edit
  end

  # POST /dns_servers
  # POST /dns_servers.json
  def create
    @dns_server = DnsServer.new(dns_server_params)

    respond_to do |format|
      if @dns_server.save
        format.html { redirect_to @dns_server, notice: 'Servidor DNS criado com sucesso.' }
        format.json { render :show, status: :created, location: @dns_server }
      else
        format.html { render :new }
        format.json { render json: @dns_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dns_servers/1
  # PATCH/PUT /dns_servers/1.json
  def update
    respond_to do |format|
      if @dns_server.update(dns_server_params)
        format.html { redirect_to @dns_server, notice: 'Sevidor DNS atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @dns_server }
      else
        format.html { render :edit }
        format.json { render json: @dns_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dns_servers/1
  # DELETE /dns_servers/1.json
  def destroy
    @dns_server.destroy
    respond_to do |format|
      format.html { redirect_to dns_servers_url, notice: 'Servidor DNS excluido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dns_server
      @dns_server = DnsServer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dns_server_params
      params.require(:dns_server).permit(:email, :password, :dns, :client_id)
    end
    # pra mostrar o nome do client
    def show_name_client
      @clients = Client.order(:name)
    end
end
