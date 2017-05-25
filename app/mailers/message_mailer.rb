class MessageMailer < ApplicationMailer
  
  default from: "Mensagem enviada - Site D&D Support Service"
  default to: "contato@ddti.com.br"

  def new_message(message)
    @message = message
    
    mail subject: "Mensagem de #{message.name}"
  end
end
