Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_page#index'

  get     'sign_up',            to: 'sign#show_sign_up_page'      # 展示注册界面
  post    'sign_up',            to: 'sign#do_sign_up'             # 执行注册操作

  get     'sign_in',            to: 'sign#show_sign_in_page'      # 展示登录界面
  post    'sign_in',            to: 'sign#do_sign_in'             # 执行登录操作

  get     'sign_out',           to: 'sign#do_sign_out'            # 退出登录

  get     'search',             to: 'search#show_search_page'     # 根据关键字?key_word搜索商品

  get     'items/:item_id',     to: 'item#show'                   # 展示某个商品的详细信息

  get     'cart',               to: 'cart#show_carts'             # 展示当前用户购物车中的所有物品
  post    'cart',               to: 'cart#new_cart'               # 新建一条购物车记录
  delete  'cart',               to: 'cart#remove_cart'            # 删除一条购物车记录

  post    'parches',            to: 'cart#pay_cart'               # 结算当前用户购物车中的所有物品

  get     'orders',             to: 'order#show_all_orders'       # 展示当前用户的所有订单

  get     'stores',             to: 'store#show_all_stores'        # 展示当前用户拥有的所有店铺

  get     'stores/:store_id/orders', to: 'store#store_orders'      # 展示当前商店的所有待处理订单
  get     'stores/:store_id/items',  to: 'store#store_items'       # 展示当前商店的所有上架商品

  get     'store/new',          to: 'store#show_create_store_page' # 展示新建商店界面
  post    'store/new',          to: 'store#create_store'           # 执行新建商店逻辑，保存数据到数据库

  post    'order/send',         to: 'order#send_order'             # 将指定订单的状态改为待评价

  get     'items/:item_id/edit',  to: 'item#show_edit_page'        # 展示商品编辑页面
  post    'items/:item_id/edit',  to: 'item#edit'                  # 执行商品编辑逻辑


  get     'items/:item_id/delete', to: 'item#delete'               # 删除指定商品

end
