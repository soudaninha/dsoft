class AdUsersController < ApplicationController
  before_action :set_ad_user, only: [:show, :edit, :update, :destroy]
  before_action :must_login

  # GET /ad_users
  # GET /ad_users.json
  def index
        
      if params[:exportar] == 'SIM'
      @ad_users = AdUser.select('colaborador as Colaborador, departamento as Departamento, user_ad as Usuário_AD, senha as Senha_AD, ip as IP, pastas as Pastas').order('colaborador')
      else
        @ad_users = AdUser.order(:colaborador)
        @conta_users = AdUser.count
      end
        
      respond_to do |format|
      format.html # don't forget if you pass html
      #format.xls { send_data(@clients.to_xls) }
      #renomeando o arquivo
      format.xls {
       
         filename = "Cadastro de Usuários AD-#{Time.now.strftime("%d%m%Y%H%M%S")}.xls"
         send_data(@ad_users.to_xls, :type => "text/xls; charset=utf-8; header=present", :filename => filename)
         }
      end

    @ad_users = AdUser.order(:colaborador)
    @conta_users = AdUser.count

    @ad_users = AdUser.order(:colaborador)
    @conta_users = AdUser.count

  end

  # GET /ad_users/1
  # GET /ad_users/1.json
  def show
  end

  # GET /ad_users/new
  def new
    @ad_user = AdUser.new
  end

  # GET /ad_users/1/edit
  def edit
  end

  # POST /ad_users
  # POST /ad_users.json
  def create
    @ad_user = AdUser.new(ad_user_params)

    respond_to do |format|
      if @ad_user.save
        format.html { redirect_to @ad_user, notice: 'Criado com sucesso.' }
        format.json { render :show, status: :created, location: @ad_user }
      else
        format.html { render :new }
        format.json { render json: @ad_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ad_users/1
  # PATCH/PUT /ad_users/1.json
  def update
    respond_to do |format|
      if @ad_user.update(ad_user_params)
        format.html { redirect_to @ad_user, notice: 'Atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @ad_user }
      else
        format.html { render :edit }
        format.json { render json: @ad_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ad_users/1
  # DELETE /ad_users/1.json
  def destroy
    @ad_user.destroy
    respond_to do |format|
      format.html { redirect_to ad_users_url, notice: 'Excluido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad_user
      @ad_user = AdUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_user_params
      params.require(:ad_user).permit(:colaborador, :departamento, :user_ad, :senha, :ip, :pastas)
    end
end
