class CadEmailsController < ApplicationController
  before_action :set_cad_email, only: [:show, :edit, :update, :destroy]
  before_action :must_login

  # GET /cad_emails
  # GET /cad_emails.json
  def index
       
    if params[:exportar] == 'SIM'
      @cad_emails = CadEmail.select('email as Email, senha_email as Senha_email, skype as Skype, senha_skype as Senha_skype').order('email')
      else
      @cad_emails = CadEmail.order(:email)
          @conta_emails = CadEmail.count
      end
        
      respond_to do |format|
      format.html # don't forget if you pass html
      #format.xls { send_data(@clients.to_xls) }
      #renomeando o arquivo
      format.xls {
       
         filename = "Cadastro de Emails / Skype -#{Time.now.strftime("%d%m%Y%H%M%S")}.xls"
         send_data(@cad_emails.to_xls, :type => "text/xls; charset=utf-8; header=present", :filename => filename)
         }
      end
    

    @cad_emails = CadEmail.order(:email)
    @conta_emails = CadEmail.count

    @cad_emails = CadEmail.order(:email)
    @conta_emails = CadEmail.count

  end

  # GET /cad_emails/1
  # GET /cad_emails/1.json
  def show
  end

  # GET /cad_emails/new
  def new
    @cad_email = CadEmail.new
  end

  # GET /cad_emails/1/edit
  def edit
  end

  # POST /cad_emails
  # POST /cad_emails.json
  def create
    @cad_email = CadEmail.new(cad_email_params)

    respond_to do |format|
      if @cad_email.save
        format.html { redirect_to @cad_email, notice: 'Criado com sucesso.' }
        format.json { render :show, status: :created, location: @cad_email }
      else
        format.html { render :new }
        format.json { render json: @cad_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cad_emails/1
  # PATCH/PUT /cad_emails/1.json
  def update
    respond_to do |format|
      if @cad_email.update(cad_email_params)
        format.html { redirect_to @cad_email, notice: 'Atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @cad_email }
      else
        format.html { render :edit }
        format.json { render json: @cad_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cad_emails/1
  # DELETE /cad_emails/1.json
  def destroy
    @cad_email.destroy
    respond_to do |format|
      format.html { redirect_to cad_emails_url, notice: 'Excluido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cad_email
      @cad_email = CadEmail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cad_email_params
      params.require(:cad_email).permit(:email, :senha_email, :skype, :senha_skype)
    end
end
