class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  before_action :show_supplier_name, only: [:new, :edit, :update, :create, :index]
  before_action :must_login

  #relatorio
  def report_payment
    
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
    
    @payments = Payment.includes(:supplier).where(due_date: Date.today).order(:due_date)
    @total_payments = Payment.limit(10).sum(:value_doc)
    
    if params[:date1] && params[:date2] && params[:tipo_data] == "POR DATA VENCIMENTO" && params[:tipo_consulta] == "Á PAGAR"
       @payments = Payment.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).order(:due_date)
       @total_payments = Payment.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).sum(:value_doc)   
    
    elsif params[:date1] && params[:date2] && params[:tipo_data] == "POR DATA PAGAMENTO" && params[:tipo_consulta] == "Á PAGAR"
       @payments = Payment.where("payment_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).order(:due_date)
       @total_payments = Payment.where("payment_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).sum(:value_doc)   
    
    elsif params[:date1] && params[:date2] && params[:tipo_data] == "POR DATA VENCIMENTO" && params[:tipo_consulta] == "PAGA"
       @payments = Payment.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).order(:due_date)
       @total_payments = Payment.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).sum(:value_doc)   
    
    elsif params[:date1] && params[:date2] && params[:tipo_data] == "POR DATA PAGAMENTO" && params[:tipo_consulta] == "PAGA"
       @payments = Payment.where("payment_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).order(:due_date)
       @total_payments = Payment.where("payment_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).sum(:value_doc)   
    
    
    elsif params[:date1] && params[:date2] && params[:tipo_data].blank? && params[:tipo_consulta].blank?
       @payments = Payment.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).order(:due_date)
       @total_payments = Payment.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).sum(:value_doc)   

    end
    
      #render layout: false
  end

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.includes(:supplier).where(due_date: Date.today).order(:due_date)
    @total_payments = Payment.where(due_date: Date.today).sum(:value_doc)
    
    if params[:date1] && params[:date2] && params[:tipo_consulta] == "Á PAGAR"
       @payments = Payment.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).order(:due_date)
       @total_payments = Payment.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).sum(:value_doc)   
    
    elsif params[:date1] && params[:date2] && params[:tipo_consulta] == "PAGA"
       @payments = Payment.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).order(:due_date)
       @total_payments = Payment.where("due_date BETWEEN ? AND ?", params[:date1], params[:date2]).where(status: params[:tipo_consulta]).sum(:value_doc)   
    end
        
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
     #mostra o nome ao inves do id
    @supplier = Supplier.find(@payment.supplier_id)
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)
    @qnt_parcela = payment_params[:installments].to_i
    
    #se for somente uma parcela ele só salva uma vez
    if @qnt_parcela == 1
    
            respond_to do |format|
              if @payment.save
                format.html { redirect_to @payment, notice: 'Pagamento cadastrado com sucesso.' }
                format.json { render :show, status: :created, location: @payment }
              else
                format.html { render :new }
                format.json { render json: @payment.errors, status: :unprocessable_entity }
              end
            end
     else
          #se tiver mais de uma parcela ele lança a quantidade de vezes no sistema
          if @qnt_parcela > 1
            @valor_total = payment_params[:value_doc].to_f
            @resultado = @valor_total / @qnt_parcela
            @resultado = (@resultado).round(2)
            @data_vencto = payment_params[:due_date]
          end
    
        while @qnt_parcela > 0
         @conta_parc = @conta_parc.to_i + 1 
         @data_vencto = @data_vencto.to_date + 1.month 
         @payment.description = payment_params[:description] + ' Parc. ' + @conta_parc.to_s
         @payment.due_date = @data_vencto
         @payment.payment_date = Date.today
         @payment.value_doc = @resultado
                   
            if @payment.save
              #só vai fazer o redirect quando finalizar
            else
              format.html { render :new }
              format.json { render json: @payment.errors, status: :unprocessable_entity }
            end
         @qnt_parcela = @qnt_parcela - 1
         @payment = Payment.new(payment_params)   
        end 
      redirect_to payments_path
      flash[:success] = 'Parcelamento realizado com sucesso!'
     end  
          
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
     
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Pagamento atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Pagamento excluido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:doc_number, :description, :due_date, :payment_date, :installments, :value_doc, :supplier_id, :type_doc, :status)
    end
    
    #mostra o nome do fornecedor
    def show_supplier_name
      @suppliers = Supplier.order(:name)
    end
end
