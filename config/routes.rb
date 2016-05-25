Rails.application.routes.draw do
  get 'users/login'
  put 'users/validate_login'
  get 'users/logout'
  get 'users/dashboard'
  get 'users/index_purchase'
  get 'users/add_purchase'
  post 'users/get_purchase'
  get 'users/show_purchase'
  patch 'users/update_purchase'
  get 'users/edit_purchase'
  get 'users/delete_purchase'
  get 'users/index_issues'
  get 'users/add_issues'
  post 'users/get_issues'
  get 'users/show_issues'
  patch 'users/update_issues'
  get 'users/edit_issues'
  get 'users/delete_issues'
  get 'users/index_productionForLabour'
  get 'users/index_labour'
  get 'users/add_labour'
  post 'users/get_labour'
  get 'users/show_labour'
  patch 'users/update_labour'
  get 'users/edit_labour'
  get 'users/delete_labour'
  get 'users/add_orderSummary'
  post 'users/get_order'
  get 'users/show_orderSummary'
  patch 'users/update_orderSummary'
  get 'users/edit_orderSummary'
  get 'users/index_orderSummary'
  get 'users/delete_orderSummary'
   get 'users/index_orderSummayForIssue'
  get 'users/add_productionReport'
  post'users/get_production'
  get 'users/index_issuesForProduction'
  get 'users/index_productionReport'
  post 'users/update_productionReport' 
  patch 'users/update_productionReport'
  get 'users/edit_productionReport' 
  get 'users/show_productionReport'
  get 'users/delete_productionReport'
  get 'users/machine_maintenance'
  post 'users/get_machine'
  patch 'users/update_machine'
  get 'users/edit_machine'
  get 'users/show_machine'
  get 'users/delete_machine'
  get 'users/index_machineMaintenance'


 
  get 'users/index_admin'
  post 'users/index_admin'

  patch 'users/index_admin'
  get 'users/admin_create'
  post 'users/admin_create'

  get 'users/insert_material_new'
  post 'users/insert_material_new'
  get 'users/insert_material_create'
  post 'users/insert_material_create'
  get 'users/insert_material_delete'
  post 'users/insert_material_delete'


  get 'users/purchase_type_new'
  post 'users/purchase_type_new'
  get 'users/purchase_type_create'
  post 'users/purchase_type_create'
  get 'users/purchase_type_delete'
  post 'users/purchase_type_delete'

  get 'users/reground_new'
  post 'users/reground_new'
  get 'users/reground_create'
  post 'users/reground_create'
  get 'users/reground_delete'
  post 'users/reground_delete'

  get 'users/chemical_new'
  post 'users/chemical_new'
  get 'users/chemical_create'
  post 'users/chemical_create'
  get 'users/chemical_delete'
  post 'users/chemical_delete'

  get 'users/chemical_type_new'
  post 'users/chemical_type_new'
  get 'users/chemical_type_delete'
  post 'users/chemical_type_delete'
  get 'users/chemical_type_create'
  post 'users/chemical_type_create'

  get 'users/raw_material_new'
  post 'users/raw_material_new'
  get 'users/raw_create'
  post 'users/raw_create'
  get 'users/raw_delete'
  post 'users/raw_delete'

  get 'users/party_order_new'
  post 'users/party_order_new'
  get 'users/party_order_create'
  post 'users/party_order_create'
  get "users/party_order_delete"
  post "users/party_order_delete"

  get 'users/party_purchase_new'
  post 'users/party_purchase_new'
  get 'users/party_purchse_create'
  post 'users/party_purchse_create'
  get 'users/party_purchse_delete'
  post 'users/party_purchse_delete'
 
  get 'users/mach_use_new'
  post 'users/mach_use_new'
  get 'users/machine_use_create'
  post 'users/machine_use_create'
  get 'users/machine_use_delete'
  post 'users/machine_use_delete'


  get 'users/mould_new'
  post 'users/mould_new'
  get 'users/mould_create'
  post 'users/mould_create'
  get 'users/mould_delete'
  post 'users/mould_delete'

   get 'users/supervisor_new'
  post 'users/supervisor_new'
  get 'users/supervisor_create'
  post 'users/supervisor_create'
  get 'users/supervisor_delete'
  post 'users/supervisor_delete'


  get 'users/cost_new'
  post 'users/cost_new'
  get 'users/cost_create'
  post 'users/cost_create'
  get 'users/edit_cost'
  patch 'users/update_cost'
  post 'users/update_cost'
  get 'users/cost_delete'
  post 'users/cost_delete'

  get 'users/goods_new'
  post 'users/goods_new'
  get 'users/goods_create'
  post 'users/goods_create'
   get 'users/goods_delete'
  post 'users/goods_delete'

  get 'users/nature_new'
  post 'users/nature_new'
  get 'users/nature_create'
  post 'users/nature_create'
  get 'users/nature_delete'
  post 'users/nature_delete'

  get 'users/reason_for_idle_new'
  post 'users/reason_for_idle_new'
  get 'users/reasonforidle_create'
  post 'users/reasonforidle_create'
  get 'users/reasonforidle_delete'
  post 'users/reasonforidle_delete'

  get 'users/rejection_reason_new'
  post 'users/rejection_reason_new'
  get 'users/rejection_reason_create'
  post 'users/rejection_reason_create'
  get 'users/rejection_reason_delete'
  post 'users/rejection_reason_delete'


  get 'users/new'
  post 'users/create'
  post 'users/new'
  get 'users/user_index'
  post 'users/user_index'
  get 'users/user_destroy'
  post 'users/user_destroy' 

 


  get 'users/trash_orderSummary'
  get 'users/trash_labour'
  get 'users/trash_issue'
  get 'users/trash_purchase'
  get 'users/trash_production'
  get 'users/trash_finished'
  get 'users/trash_return'
  get 'users/trash_machine_maintenance'

  get 'users/trash_showOrderSummary'
  get 'users/trash_showLabour'
  get 'users/trash_showIssue'
  get 'users/trash_showPurchase'
  get 'users/trash_showProduction'
  get 'users/trash_showFinished'
  get 'users/trash_showReturn'
  get 'users/trash_showMachineMaintenance'


  get 'users/delete_trashOrderSummary'
  get 'users/restore_trashOrderSummary'
  get 'users/delete_trashIssue'
  get 'users/restore_trashIssue'
  get 'users/delete_trashLabour'
  get 'users/restore_trashLabour'
  get 'users/delete_trashPurchase'
  get 'users/restore_trashPurchase'
  get 'users/delete_trashProduction'
  get 'users/restore_trashProduction'
  get 'users/delete_trashFinished'
  get 'users/restore_trashFinished'
  get 'users/delete_trashReturn'
  get 'users/restore_trashReturn'
  get 'users/delete_trashMachine'
  get 'users/restore_trashMachine'

  get 'users/yield_cost'
  post 'users/yield_cost_report'
  get 'users/yield_cost_report_xls'

  get 'users/idle_time_report'
  post 'users/idle_time_report'

     get 'users/idle_time_report_xls'

  get 'users/finished_goods_report'
  post 'users/finished_goods_report'
 
  get 'users/finished_goods_xls_report'

  get 'users/supervisor_name_report'
  post 'users/supervisor_name_report'

  get 'users/supervisor_xls_report'

  get 'users/report_page'
  post 'users/report_page'

  get 'users/party_production'
  post 'users/party_production'
   
 get 'users/party_production_xls_report'
   
   get 'users/finished_production'
  post 'users/finished_production'
  
  get 'users/finished_xls_report'

  get 'users/rate_per_kgs_report'
  post 'users/rate_per_kgs_report'

  get 'users/rate_per_kgs_xls_report'

  get 'users/report_rejection_analysis'
  get 'users/report_rejection_analysis'
  
  get 'users/rejection_analysis'
  post 'users/rejection_analysis'

  get 'users/rejection_analysis_xls_report'

  get 'users/order_summary_report'
  post 'users/order_summary_report'

  get 'users/order_sum_report'
  post 'users/order_sum_report'
  
  get 'users/party_order_qty_report'
  post 'users/party_order_qty_report'

 get 'users/finished_order_qty_report'

   get 'users/purchase_report'
  post 'users/purchase_report'

  get 'users/purchase_sum_report'
  post 'users/purchase_sum_report'

  get 'users/issues_report'
  post 'users/issues_report'

  get 'users/issue_report'
  post 'users/issue_report'

  get 'users/productn_report'
  post 'users/productn_report'

  get 'users/product_report'
  post 'users/product_report'

  get 'users/party_order_qty'
  post 'users/party_order_qty'

  get 'users/finished_order_qty'
  post 'users/finished_order_qty'  

  get 'users/finished'
  post 'users/get_finished'
  get 'users/index_finished'
  get 'users/index_productionForFinished'
  get 'users/show_finished'
  patch 'users/update_finished'
  post 'users/update_finished'
  get 'users/edit_finished'
  get 'users/delete_finished'
  
  get 'users/supervisor_name'
  post 'users/supervisor_name'

  get 'users/index_issuesForReturn'
  get 'users/index_return'
  get 'users/add_return'
  post 'users/get_return'  
  get 'users/show_return'
  patch 'users/update_return'
  post 'users/update_return'
  get 'users/edit_return'
  get 'users/delete_return'

  get 'users/return_report'
  post 'users/return_report'
  get 'users/return_xls_report'

  get 'users/report_purchase'
  post 'users/report_purchase'

  get 'users/report_order_summary'
  post 'users/report_order_summary'

  get 'users/report_issues'
  post 'users/report_issues'

  get 'users/report_production'
  post 'users/report_production'

  get 'users/lab_report'
  post 'users/lab_report'

  get 'users/labour_report'
  post 'users/labour_report'

  get 'users/report_labour'
  post 'users/report_labour'

  get 'users/report_idle_time'
  post 'users/report_idle_time'

  get 'users/report_machine_maintenance'
  post 'users/report_machine_maintenance'

  get 'users/machine_maintenance_report'
  post 'users/machine_maintenance_report'
  get 'users/machine_maintenance_xls_report'


  resources :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#login'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
