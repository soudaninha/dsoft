class Item < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :product
  
  validates :qnt, :total_value, :product_id, presence: true

  #action criadas para fazer a baixa dos produtos no estoque e voltar os produtos quando for feito uma exclusão
  after_save :remove_from_stock
  after_destroy :return_to_stock
    
  #faz a baixa do produto
  def remove_from_stock
    @invoice = Invoice.find_by_id(invoice_id)
    @product = Product.find_by_id(product_id)
    if @invoice.type_invoice == 'Ordem de Serviço' && @product.check_stock == !false
    product.qnt -= self.qnt
    product.save
    end
  end
  #retorna o produto para o estoque quando acontece uma exclusão
  def return_to_stock
    @invoice = Invoice.find_by_id(invoice_id)
    @product = Product.find_by_id(product_id)
    if @invoice.type_invoice == 'Ordem de Serviço' && @product.check_stock == !false
    product.qnt += self.qnt
    product.save
    end
  end
  

end
