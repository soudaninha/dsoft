class MonthlyAccountsController < ApplicationController
  before_action :set_monthly_account, only: [:show, :edit, :update, :destroy]

  # GET /monthly_accounts
  # GET /monthly_accounts.json
  def index
    @monthly_accounts = MonthlyAccount.all
  end

  # GET /monthly_accounts/1
  # GET /monthly_accounts/1.json
  def show
  end

  # GET /monthly_accounts/new
  def new
    @monthly_account = MonthlyAccount.new
  end

  # GET /monthly_accounts/1/edit
  def edit
  end

  # POST /monthly_accounts
  # POST /monthly_accounts.json
  def create
    @monthly_account = MonthlyAccount.new(monthly_account_params)

    respond_to do |format|
      if @monthly_account.save
        format.html { redirect_to @monthly_account, notice: 'Monthly account was successfully created.' }
        format.json { render :show, status: :created, location: @monthly_account }
      else
        format.html { render :new }
        format.json { render json: @monthly_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /monthly_accounts/1
  # PATCH/PUT /monthly_accounts/1.json
  def update
    respond_to do |format|
      if @monthly_account.update(monthly_account_params)
        format.html { redirect_to @monthly_account, notice: 'Monthly account was successfully updated.' }
        format.json { render :show, status: :ok, location: @monthly_account }
      else
        format.html { render :edit }
        format.json { render json: @monthly_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monthly_accounts/1
  # DELETE /monthly_accounts/1.json
  def destroy
    @monthly_account.destroy
    respond_to do |format|
      format.html { redirect_to monthly_accounts_url, notice: 'Monthly account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monthly_account
      @monthly_account = MonthlyAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monthly_account_params
      params.require(:monthly_account).permit(:due_date, :description, :value_doc)
    end
end
