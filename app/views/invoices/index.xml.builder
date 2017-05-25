xml.instruct!
xml.invoices do
  @invoices.each do |invoice|
    xml.invoice do
    xml.id invoice.id
    xml.created_at invoice.created_at
      xml.type_invoice invoice.type_invoice
      xml.client invoice.client.name
      xml.form_receipt invoice.form_receipt
      
      xml.items do
        invoice.items.each do |item|
          xml.item do
              xml.product item.product.name
              xml.qnt item.qnt
              xml.total_value number_to_currency item.total_value
          end
        end
      end
    end
  end
end