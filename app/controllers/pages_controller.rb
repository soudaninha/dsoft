class PagesController < ApplicationController

  def dashboard_servproject
    
  end
  
  def report_call
    @datainicial = params[:date1]
    @datafinal = params[:date2]
    
    if params[:date1].blank?
      params[:date1] = Date.today
      @datainicial = params[:date1]
    else
      @datainicial = Date.strptime(params[:date1], '%Y-%m-%d').strftime("%d/%m/%Y")
    end
    
    
    if params[:date2].blank?
      params[:date2] = Date.today
      @datafinal = params[:date2]
    else
      @datafinal = Date.strptime(params[:date2], '%Y-%m-%d').strftime("%d/%m/%Y")
    end
    
        
    #relatorio analitico
    if params[:analitico].present?
    @callcenters = Callcenter.where("created_at::date between ? AND ?", params[:date1], params[:date2]).order('created_at Desc')
    end
    
     #GRÁFICO ANUAL DE CHAMADOS
      call_annual = Callcenter.select("date_trunc( 'month', created_at ) as month, count(id) as total_quantity").group('month').order('month')
      call_by_month = []
      
      call_annual.each do |
      callcenter |
      call_by_month.push({
          :label => callcenter.month.strftime("%B"),
          :value => callcenter.total_quantity
      })
      end

      @call_annual = Fusioncharts::Chart.new({
          :height => '20%',
          :width => '100%',
          :type => 'column2d',
          :renderAt => 'chart-container-m',
          :dataSource => {
              :chart => {
                  :xAxisname => 'Representação gráfica por mês',
                  :yAxisName => 'Total',
                  :numberPrefix => 'Quantidade: ',
                  :theme => 'fint',
                  :formatNumberScale=> '0',
                  :decimalSeparator=> ',',
                  :thousandSeparator=> '.',
              },
              :data => call_by_month
          }
      })
    
  end
    
  def index
    @date = DateTime.now.year
    
    #verifica se tem contas á pagar vencendo hoje
    @payments = Payment.where('due_date <= ?', Date.today).where(status: 'Á PAGAR').order(:due_date)
    @total_payments = Payment.where('due_date <= ?', Date.today).where(status: 'Á PAGAR').sum(:value_doc)
    
    #verifica se tem contas á receber vencendo hoje
    @receipts = Receipt.where('due_date <= ?', Date.today).where(status: 'Á RECEBER').order(:due_date)
    @total_receipts = Receipt.where('due_date <= ?', Date.today).where(status: 'Á RECEBER').sum(:value_doc)
    
    #verifica se tem hospedagem vencendo no mes corrente
    @extra_sales = ExtraSale.where(:due_date => Time.now.beginning_of_month..Time.now.end_of_month).order(:due_date)
    @total_geral = ExtraSale.where(:due_date => Time.now.beginning_of_month..Time.now.end_of_month).sum(:value)
    
    #verifica se tem algum cliente em aberto
    @clients = Client.where('due_date <= ?', Date.today).where(status: 'CONTRATO').order(:due_date)
  end
end
