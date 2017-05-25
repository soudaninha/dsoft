class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy, :download]
  before_action :must_login
  
  
  #efetua a baixa do cliente no caso de clientes com contrato
  def baixa_comprovante
    
    @client = Client.find(params[:id])
       
    @new_date = @client.due_date + 1.month
    Client.update(@client.id, due_date: @new_date)
    
    render layout: 'reports/baixa_comprovante'
    
  end
  
  
  #donwload do contrato do cliente
  def download
    
    #verifica se tem contrato primeiro
    if @client.file_contents.present?
    #para fazer o download do contrato do cliente
    send_data(@client.file_contents,
              type: @client.content_type,
              filename: @client.filename)
            else
              flash[:warning] = 'Não existe contrato para esse cliente'
              redirect_to client_path(@client)
    end

  end
  
  # relatorio de clientes
  def report_client
    @clients = Client.where(status: 'CONTRATO').order(:due_date)
    @total_clients = Client.count
    @total_contract = Client.where(status: 'CONTRATO').count
    
    @total_value = Client.where(status: 'CONTRATO').sum(:value)
    #pra poder carregar o css somente que está no proprio relatório
    #render :layout => false
    
  end
  
  def index
   @clients = Client.includes(:cidade, :estado).limit(20).order(:name)  
      
    @total_clients = Client.count
    
        if params[:search] && params[:tipo_consulta] == "1"
          @clients = Client.where("name like ?", "%#{params[:search]}%")
          
          #aqui é para gerar o resultado da query em pdf na tela
          #html = render_to_string(:action => '../clients/index', :layout => false)
          #pdf = PDFKit.new(html)
          #send_data(pdf.to_pdf, :filename => 'report.pdf', :type => 'application/pdf', :disposition => 'inline')
                       
            elsif params[:search] && params[:tipo_consulta] == "2"
                @clients = Client.where("cnpj like ?", "%#{params[:search]}%")
            
            elsif params[:search] && params[:tipo_consulta] == "3"
          @clients = Client.where("email like ?", "%#{params[:search]}%")
        end
       
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Cliente criado com sucesso.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Cliente atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Cliente foi excluido.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :address, :neighborhood, :zipcode, :phone, :cnpj, :cellphone, :email, :cidade_id, :estado_id, :status, :description, :value, :due_date, :obs, :file)
    end
        
end
