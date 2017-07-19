class ItemsController < ApplicationController
  #before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :must_login
     
  def create
   @invoice = Invoice.find(params[:invoice_id])
   
    
    #verifica se já existe o mesmo item adicionado na venda
    check_item = Item.where(invoice_id: @invoice.id, product_id: item_params[:product_id])
    if check_item.present?
      flash[:warning] = 'Este produto já foi adicionado!'
      redirect_to invoice_path(@invoice) and return
    end
    
      
      if item_params[:qnt].blank?
     flash[:warning] = 'Informe uma quantidade para o produto!'
     redirect_to invoice_path(@invoice) and return
     else 
      @item = @invoice.items.create(item_params)
      redirect_to invoice_path(@invoice)
     end
  end
  
  def edit
    #nada aqui ainda
  end
  
  def destroy
    @invoice = Invoice.find(params[:invoice_id])
    @item = @invoice.items.find(params[:id])
    @item.destroy
    redirect_to invoice_path(@invoice)
  end
  

private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:qnt, :total_value, :product_id)
    end
    

end