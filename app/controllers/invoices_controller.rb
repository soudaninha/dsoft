class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  before_action :show_client_name, only: [:new, :edit, :update, :create, :index]
  before_action :must_login
  
  #relatório
  def report_invoice
    
    if params[:tipo_consulta].blank?
      params[:tipo_consulta] = 'Orçamento'
    end
    
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
                     
                
          if params[:tipo_consulta] == "Orçamento" && params[:date1] && params[:date2]
             @invoices = Invoice.where(type_invoice: params[:tipo_consulta]).where("created_at::date BETWEEN ? AND ?", params[:date1], params[:date2]).order(:created_at)
          elsif params[:tipo_consulta] == "Ordem de Serviço" && params[:date1] && params[:date2]
             @invoices = Invoice.where(type_invoice: params[:tipo_consulta]).where("created_at::date BETWEEN ? AND ?", params[:date1], params[:date2]).order(:created_at)
          end
          
    #render layout: false
  end
  
   
  
  #CONVERTE O ORÇAMENTO EM UMA INVOICE PASSANDO A BAIXA DOS PRODUTOS PARA O ESTOQUE
  def convert_invoice
      
    @invoice = Invoice.find(params[:id])
    #verifica se já existe algum item lançado, caso contrário não faz nada
    check_item = Item.find_by(invoice_id: @invoice.id)
       #VERIFICA SE O PRODUTO É AVALIADO E FAZ A BAIXA DA QUANTIDADE NO ESTOQUE SE TIVER QUANTIDADE SUFICIENTE
    
      if check_item.present?
         
           Item.where(invoice_id: @invoice.id).find_each do |item|
              #VERIFICA SE O PRODUTO TEM ESTOQUE PARA FAZER A BAIXA NO ESTOQUE PRIMEIRO
              check_product = Product.find_by(id: item.product_id)
              
              if check_product.check_stock == true && check_product.qnt >= item.qnt
              check_product.update_attributes(qnt: (check_product.qnt.to_i - item.qnt.to_i))
              end  
           
           end     
      else
       flash[:warning] = 'Insira pelo menos 1 item primeiro!'
       redirect_to invoice_path(@invoice) and return       
      end
    
    
    Invoice.update(@invoice.id, type_invoice: 'Ordem de Serviço', status: 'FINALIZADA', form_receipt: params[:form_receipt])
    
      
     
    #FAZENDO A SOMA DE TODOS OS ITENS PARA EXIBIR NA IMPRESSÃO 
    @total_items = Item.where(invoice_id: @invoice.id).sum(:total_value)
    
    #ENVIANDO PARA O CONTAS Á RECEBER
                 cta_receber = Receipt.new(params[:receipt])
                 cta_receber.doc_number = @invoice.id
                 cta_receber.client_id = @invoice.client_id
                 cta_receber.type_doc = "O.S"
                 cta_receber.discription = 'Referente a O.S: ' + params[:id].to_s
                 cta_receber.value_doc = @total_items
                 cta_receber.due_date = Date.today
                 cta_receber.installments = @invoice.installments
                 cta_receber.status = "Á RECEBER"
                 cta_receber.invoice_id = @invoice.id
                 cta_receber.form_receipt = @invoice.form_receipt
                 cta_receber.save!
    
    redirect_to invoices_path
    flash[:success] = 'Orçamento convertido em O.S com sucesso!'
 
  end
   
    
  #EFETUA A BAIXA DA INVOICE e envia os dados para o contas á Receber automaticamente gerando o PDF
  def baixar
    @invoice = Invoice.find(params[:id])
    
    #FAZENDO A SOMA DE TODOS OS ITENS PARA EXIBIR NA IMPRESSÃO 
    @total_items = Item.where(invoice_id: @invoice.id).sum(:total_value)  
    
    #verifica se foi adicionado algum item na Invoice
    @qnt_items = Item.where(invoice_id: @invoice.id).count
    if @qnt_items == 0
      flash[:warning] = 'Selecione pelo menos 1 item!'
     redirect_to invoice_path(@invoice) and return 
    end
    
    #verifica se foi informada a forma de pagamento no caso de O.S
    if @invoice.type_invoice == 'Ordem de Serviço' && invoice_params[:form_receipt] == ""
      flash[:warning] = 'Selecione uma forma de pagamento válida!'
      redirect_to invoice_path(@invoice) and return
    end
    
   #PRIMEIRA COISA QUE É VISTA É SE É UMA O.S OU UM ORÇAMENTO
   #se for orçamento ele só gera a view para impressão
   if @invoice.type_invoice == 'Orçamento'
   render layout: 'reports/rpt_invoice' and return
   end
                  
    # SE JÁ FOI RECEBIDA A O.S. não enviará para o contar á Receber
     if @invoice.status == "RECEBIDA"  || @invoice.status == "FINALIZADA"
      #renderiza a view para carregar o PDF dentro da pasta Layouts/reports  
         render layout: 'reports/rpt_invoice'
  
       else
       #finalizando a O.S e salvando a forma de pagamento e quantidade de parcelas da venda
       @novostatus = 'FINALIZADA'
       Invoice.update(@invoice.id, status: @novostatus, form_receipt: invoice_params[:form_receipt], installments: invoice_params[:installments])
       
       #FAZENDO A SOMA DE TODOS OS ITENS PARA JOGAR NO CONTAS Á RECEBER
       @total_items = Item.where(invoice_id: @invoice.id).sum(:total_value)
       
       #verifica se já foi enviado para o contas á receber
              
       if Receipt.exists?(invoice_id: @invoice.id)
         #renderiza a view para carregar o PDF dentro da pasta Layouts/reports
         render layout: 'reports/rpt_invoice'
      
         else
           
           #verifica a quantidade de parcelas e faz a divisão para enviar para o contas á receber
           @qnt_parcela = invoice_params[:installments].to_i
           
           #se tiver somente uma parcela é lançado uma vez só
           if @qnt_parcela == 1
                
                #ENVIANDO PARA O CONTAS Á RECEBER
                 cta_receber = Receipt.new(params[:receipt])
                 cta_receber.doc_number = @invoice.id
                 cta_receber.client_id = @invoice.client_id
                 cta_receber.type_doc = "O.S"
                 cta_receber.discription = 'Referente á O.S: ' + params[:id].to_s
                 cta_receber.value_doc = @total_items
                 cta_receber.due_date = Date.today
                 cta_receber.installments = invoice_params[:installments]
                 cta_receber.status = "Á RECEBER"
                 cta_receber.invoice_id = @invoice.id
                 cta_receber.form_receipt = invoice_params[:form_receipt]
                 cta_receber.save!
            #caso contrário é feito um loop para lançar parcela por parcela
            else
                if @qnt_parcela > 1
                #@valor_total = Item.find_by[invoice_id: @invoice.id].sum(:total_value).to_f
                @resultado = @total_items.to_f / @qnt_parcela
                @resultado = (@resultado).round(2)
                @data_vencto = Date.today
                end
                
                    while @qnt_parcela > 0
                          @conta_parc = @conta_parc.to_i + 1 
                          @data_vencto = @data_vencto.to_date + 1.month 
                     #inserindo cada parcela no contas á receber
                     cta_receber = Receipt.new(params[:receipt])
                     cta_receber.doc_number = @invoice.id
                     cta_receber.client_id = @invoice.client_id
                     cta_receber.type_doc = "O.S"
                     cta_receber.discription = 'Referente a O.S: #{@invoice.id}' + ' Parc. ' + @conta_parc.to_s
                     cta_receber.value_doc = @resultado
                     cta_receber.due_date = @data_vencto
                     cta_receber.installments = invoice_params[:installments]
                     cta_receber.status = "Á RECEBER"
                     cta_receber.invoice_id = @invoice.id
                     cta_receber.form_receipt = invoice_params[:form_receipt]
                     cta_receber.save!     
                         
                     @qnt_parcela = @qnt_parcela - 1
                         
                    end 
             
            end     
        
        #Atualiza a forma de pagamento  na visualização do form        
        @invoice = Invoice.find(params[:id])         
                       
        #renderiza a view para carregar o PDF dentro da pasta Layouts/reports
         render layout: 'reports/rpt_invoice'
        
        end
      end
  end
  
  
    #consultando e carregando os dados do produto selecionado que será adicionado na venda
  def consulta_prod
    @product = Product.select('qnt,cost_sale,check_stock').where(name: params[:name]).first
    respond_to do |format|
    format.html
    format.json { render :json => @product }
    end
    #------------DEU CERTO GLORIA Á DEUS!!!-----------------------------------------------
  end
  
  
  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.includes(:client).limit(10).order('created_at Desc')
          
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
       
    @client = Client.find(@invoice.client_id)
    @total_items = Item.where(invoice_id: @invoice.id).sum(:total_value)
        
    @products = Product.order(:name)

  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
    if @invoice.status == 'RECEBIDA'
      flash[:danger] = 'Você não pode editar uma O.S. já recebida!'
      redirect_to invoices_path
    end
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      @invoice.status = 'ABERTA'
      @invoice.form_receipt = 'NÃO INFORMADO'
      @invoice.installments = '1'
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Criado com sucesso.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    
    Receipt.destroy_all(invoice_id: @invoice)
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Excluido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:type_invoice, :client_id, :form_receipt, :installments)
    end
    
    #mostra o nome dos clientes ao invés do id
    def show_client_name
      @clients = Client.order(:name)
    end
end
