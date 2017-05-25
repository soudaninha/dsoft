class ExtraSalesController < ApplicationController
  before_action :set_extra_sale, only: [:show, :edit, :update, :destroy]
  before_action :show_client_name, only: [:new, :edit, :update, :create, :index]
  before_action :must_login

  # GET /extra_sales
  # GET /extra_sales.json
  def index
    @extra_sales = ExtraSale.all
    @total_geral = ExtraSale.sum(:value)
  end

  # GET /extra_sales/1
  # GET /extra_sales/1.json
  def show
  end

  # GET /extra_sales/new
  def new
    @extra_sale = ExtraSale.new
  end

  # GET /extra_sales/1/edit
  def edit
  end

  # POST /extra_sales
  # POST /extra_sales.json
  def create
    @extra_sale = ExtraSale.new(extra_sale_params)

    respond_to do |format|
      if @extra_sale.save
        format.html { redirect_to @extra_sale, notice: 'Serviço extra criada com sucesso.' }
        format.json { render :show, status: :created, location: @extra_sale }
      else
        format.html { render :new }
        format.json { render json: @extra_sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extra_sales/1
  # PATCH/PUT /extra_sales/1.json
  def update
    respond_to do |format|
      if @extra_sale.update(extra_sale_params)
        format.html { redirect_to @extra_sale, notice: 'Serviço extra atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @extra_sale }
      else
        format.html { render :edit }
        format.json { render json: @extra_sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extra_sales/1
  # DELETE /extra_sales/1.json
  def destroy
    @extra_sale.destroy
    respond_to do |format|
      format.html { redirect_to extra_sales_url, notice: 'Serviço extra excluida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extra_sale
      @extra_sale = ExtraSale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extra_sale_params
      params.require(:extra_sale).permit(:client_id, :product, :value, :due_date, :obs)
    end
    
    #mostra o nome dos clientes ao invés do id
    def show_client_name
      @clients = Client.order(:name)
    end
    
end
