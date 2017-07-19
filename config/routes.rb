Rails.application.routes.draw do


  resources :monthly_accounts
  resources :extra_sales
  resources :licencas
  resources :patrimonios
  resources :ad_users
  resources :cad_emails
  resources :callcenters
  resources :licences
  resources :documents
resources :invoices do
 member do
   post 'baixar'
   get 'convert_invoice'
  
 end 
  resources :items
end


  #resources :items
  #resources :invoices
  resources :receipts
  resources :payments
  resources :products
  resources :dns_servers
  resources :suppliers
  resources :heritages
  resources :clients do
    member do
      get 'download'
      post 'baixa_comprovante'
    end
  end
  
  resources :users
  
  #para exibir a imagem que foi feito o upload
  get 'show_file' => 'documents#show_file'
 
      
  #rota para consultar produto selecionado no combobox na Ordem de serviço
  get 'consulta_prod', to: 'invoices#consulta_prod'
  
  #rota para consultar a descriçao do patrimonio com base no codigo selecionado
  get 'consulta_patrimonio', to: 'patrimonios#consulta_patrimonio'
  
  root 'pages#index'

  get 'sessions/new'
  
  #rotas para o login
  get 'pages/index'
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
  post 'login', to: 'sessions#create'
  #---------------------------------------------
  
  #rotas para contato
  get 'contact', to: 'messages#new', as: 'contact'
  post 'contact', to: 'messages#create'
  #---------------------------------------------
  #somente para chamar a edição do usuario quando for um membro logado
  get 'editar_user', to: 'users#chama_edicao'
  #---------------------------------------------
  #para relatório de clientes
  get 'report_client', to: 'clients#report_client'
  #----------------------------------------------
  #para relatório de servidores DNS
  get 'report_dns', to: 'dns_servers#report_dns'
  #----------------------------------------------
  #para relatório de heritages
  get 'report_heritage', to: 'heritages#report_heritage'
  #----------------------------------------------
  #para relatório de contas á pagar
  get 'report_payment', to: 'payments#report_payment'
  #----------------------------------------------
 
  #para relatório de produtos
  get 'report_product', to: 'products#report_product'
  #----------------------------------------------
  #para relatório de contas a receber
  get 'report_receipt', to: 'receipts#report_receipt'
  #----------------------------------------------
  #para relatório de fornecedores
  get 'report_supplier', to: 'suppliers#report_supplier'
  #----------------------------------------------
  #para relatório de Invoices
  get 'report_invoice', to: 'invoices#report_invoice'
  #----------------------------------------------
  
  #DASHBOARD PARA OS CLIENTES, CALLCENTER
  get 'dashboard_servproject', to: 'pages#dashboard_servproject'
  get 'report_call', to: 'pages#report_call'

  get 'report_call', to: 'pages#report_call'

  #----------------------------------------------
  
  #para mensagens de erro quando existe relação entre tabelas
  get 'message_error_relation_tables', to: 'messages#message_error_relation_tables'
  end


