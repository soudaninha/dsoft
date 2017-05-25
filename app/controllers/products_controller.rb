class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :show_supplier_name, only: [:new, :edit, :update, :create, :index]
  before_action :must_login

  #relatorio
  def report_product
    @products = Product.order(:name).includes(:supplier)
    @total_products = Product.count
    #render layout: false
  end

  # GET /products
  # GET /products.json
  def index
    @products = Product.includes(:supplier).limit(10)
    @total_products = Product.count
    
        if params[:search] && params[:tipo_consulta] == "1"
            @products = Product.where("name like ?", "%#{params[:search]}%")
    
        end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    #mostra o nome ao inves do id
    @supplier = Supplier.find(@product.supplier_id)
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Produto criado com sucesso.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Produto atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Produto excluido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :check_stock, :qnt, :cost_value, :cost_sale, :supplier_id)
    end
    #mostra o nome do fornecedor
    def show_supplier_name
      @suppliers = Supplier.order(:name)
    end
end
