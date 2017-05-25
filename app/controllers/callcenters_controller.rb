class CallcentersController < ApplicationController
  before_action :set_callcenter, only: [:show, :edit, :update, :destroy]
  before_action :show_client_name, only: [:new, :edit, :update, :create, :index]
  before_action :must_login

  # GET /callcenters
  # GET /callcenters.json
  def index
    @callcenters = Callcenter.where(status: 'ABERTO').order(:created_at)
  end

  # GET /callcenters/1
  # GET /callcenters/1.json
  def show
  end

  # GET /callcenters/new
  def new
    @callcenter = Callcenter.new
  end

  # GET /callcenters/1/edit
  def edit
  end

  # POST /callcenters
  # POST /callcenters.json
  def create
    @callcenter = Callcenter.new(callcenter_params)
    
    if callcenter_params[:date_finish].present?
      @callcenter.status = 'FINALIZADO'
    else
      @callcenter.status = 'ABERTO'
    end

    respond_to do |format|
      if @callcenter.save
                
        format.html { redirect_to new_callcenter_path, notice: 'Chamado criado com sucesso.' }
        format.json { render :show, status: :created, location: @callcenter }
      else
        format.html { render :new }
        format.json { render json: @callcenter.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /callcenters/1
  # PATCH/PUT /callcenters/1.json
  def update
    respond_to do |format|
      
    if callcenter_params[:date_finish].present?
      @callcenter.status = 'FINALIZADO'
    end
      if @callcenter.update(callcenter_params)
        format.html { redirect_to @callcenter, notice: 'Chamado atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @callcenter }
      else
        format.html { render :edit }
        format.json { render json: @callcenter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /callcenters/1
  # DELETE /callcenters/1.json
  def destroy
    @callcenter.destroy
    respond_to do |format|
      format.html { redirect_to callcenters_url, notice: 'Chamado excluido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_callcenter
      @callcenter = Callcenter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def callcenter_params
      params.require(:callcenter).permit(:client_id, :employee, :problem, :solution, :date_finish, :department, :status)
    end
    #mostra o nome dos clientes ao invés do id
    def show_client_name
      @clients = Client.where(status: 'CONTRATO').order(:name)
    end
end
