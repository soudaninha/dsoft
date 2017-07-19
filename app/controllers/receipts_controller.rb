class ReceiptsController < ApplicationController
  before_action :set_receipt, only: [:show, :edit, :update, :destroy]
  before_action :show_client_name, only: [:new, :edit, :update, :create, :index]
  before_action :must_login
  
  # relatorio
  def report_receipt
    
      if params[:date1].blank?
        params[:date1] = Date.today
        @datainicial = Date.today
       else
        @datainicial = Date.strptime(params[:date1], '%Y-%m-%d').strftime("%d/%m/%Y")
      end

      if params[:date2].blank?
        params[:date2] = Date.today
      @datafinal = Date.today
      else
       @datafinal = Date.strptime(params[:date2], '%Y-%m-%d').strftime("%d/%m/%Y")
      end    
    
      @receipts = Receipt.includes(:client).limit(10).order(:due_date)
      @total_receipts = Receipt.limit(10).sum(:value_doc)
      
        if params[:date1] && params[:date2] && params[:tipo_data] == 'POR DATA VENCIMENTO' && params[:tipo_consulta] == 'Á RECEBER'
           @receipts = Receipt.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).order(:due_date)
           @total_receipts = Receipt.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).sum(:value_doc)   
        
        elsif params[:date1] && params[:date2] && params[:tipo_data] == 'POR DATA RECEBIMENTO' && params[:tipo_consulta] == 'Á RECEBER'
           @receipts = Receipt.where("receipt_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).order(:due_date)
           @total_receipts = Receipt.where("receipt_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).sum(:value_doc)   

        
        elsif params[:date1] && params[:date2] && params[:tipo_data] == 'POR DATA VENCIMENTO' && params[:tipo_consulta] == 'RECEBIDA'
           @receipts = Receipt.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).order(:due_date)
           @total_receipts = Receipt.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).sum(:value_doc)   
        
        elsif params[:date1] && params[:date2] && params[:tipo_data] == 'POR DATA RECEBIMENTO' && params[:tipo_consulta] == 'RECEBIDA'
           @receipts = Receipt.where("receipt_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).order(:due_date)
           @total_receipts = Receipt.where("receipt_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).sum(:value_doc)   

        
        elsif params[:date1] && params[:date2] && params[:tipo_data].blank? && params[:tipo_consulta].blank?
           @receipts = Receipt.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2])
           @total_receipts = Receipt.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).sum(:value_doc)   
        end
       
    #render layout: false
  end
  # GET /receipts
  # GET /receipts.json

    def index
      @receipts = Receipt.includes(:client).where(due_date: Date.today).order(:due_date)
      @total_receipts = Receipt.where(due_date: Date.today).sum(:value_doc)
      
        if params[:date1] && params[:date2] && params[:tipo_consulta] == 'Á RECEBER'
           @receipts = Receipt.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).order(:due_date)
           @total_receipts = Receipt.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).sum(:value_doc)   
        elsif params[:date1] && params[:date2] && params[:tipo_consulta] == 'RECEBIDA'
           @receipts = Receipt.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).order(:due_date)
           @total_receipts = Receipt.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).sum(:value_doc)   
        end
          
    end
  
  # GET /receipts/1
  # GET /receipts/1.json
  def show
    @client = Client.find(@receipt.client_id)
  end

  # GET /receipts/new
  def new
    @receipt = Receipt.new
  end

  # GET /receipts/1/edit
  def edit
    
  end

  # POST /receipts
  # POST /receipts.json
  def create
    @receipt = Receipt.new(receipt_params)
    @qnt_parcela = receipt_params[:installments].to_i
    
    #se for somente uma parcela ele só salva uma vez
    if @qnt_parcela == 1
      
    
          respond_to do |format|
            
            if @receipt.save
              format.html { redirect_to @receipt, notice: 'Recebimento criado com sucesso.' }
              format.json { render :show, status: :created, location: @receipt }
            else
              format.html { render :new }
              format.json { render json: @receipt.errors, status: :unprocessable_entity }
            end
          end
     else
          #se tiver mais de uma parcela ele lança a quantidade de vezes no sistema
          if @qnt_parcela > 1
            @valor_total = receipt_params[:value_doc].to_f
            @resultado = @valor_total / @qnt_parcela
            @resultado = (@resultado).round(2)
            @data_vencto = receipt_params[:due_date]
          end
        
              while @qnt_parcela > 0
                   @conta_parc = @conta_parc.to_i + 1 
                   @data_vencto = @data_vencto.to_date + 1.month 
                   @receipt.discription = receipt_params[:discription] + ' Parc. ' + @conta_parc.to_s
                   @receipt.due_date = @data_vencto
                   @receipt.value_doc = @resultado
                             
                      if @receipt.save
                        #só vai fazer o redirect quando finalizar
                      else
                        format.html { render :new }
                        format.json { render json: @receipt.errors, status: :unprocessable_entity }
                      end
                   @qnt_parcela = @qnt_parcela - 1
                   @receipt = Receipt.new(receipt_params)   
               end 
         redirect_to receipts_path
         flash[:success] = 'Parcelamento realizado com sucesso!'
     end     
  end

  # PATCH/PUT /receipts/1
  # PATCH/PUT /receipts/1.json
  def update
    
    #verifica se foi marcado como recebida e se foi atualiza a invoice amarrada á essa conta
    if @receipt.status == "Á RECEBER" 
       @invoice = Invoice.where(id: @receipt.invoice_id)
       if @invoice.present?
         @novostatus = 'RECEBIDA'
         Invoice.update(@invoice, status: @novostatus)
       end
    end
    
    respond_to do |format|
         
      if @receipt.update(receipt_params)
        format.html { redirect_to @receipt, notice: 'Recebimento atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @receipt }
      else
        format.html { render :edit }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receipts/1
  # DELETE /receipts/1.json
  def destroy
    @receipt.destroy
    respond_to do |format|
      format.html { redirect_to receipts_url, notice: 'Recebimento excluido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_receipt
      @receipt = Receipt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def receipt_params
      params.require(:receipt).permit(:doc_number, :type_doc, :discription, :due_date, :receipt_date, :installments, :value_doc, :client_id, :status)
    end
    #mostra os clientes cadastrados
    def show_client_name
      @clients = Client.order(:name)
    end
          
end
