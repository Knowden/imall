Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_page#index'

  get     'sign_up',   to: 'sign#show_sign_up_page'      # 展示注册界面
  post    'sign_up',   to: 'sign#do_sign_up'             # 执行注册操作

  get     'sign_in',   to: 'sign#show_sign_in_page'      # 展示登录界面
  post    'sign_in',   to: 'sign#do_sign_in'             # 执行登录操作

  get     'sign_out',  to: 'sign#do_sign_out'            # 退出登录

  get     'search',    to: 'search#show_search_page'     # 根据关键字?key_word搜索商品

  get     'items/:item_id', to: 'item#show'              # 展示某个商品的详细信息

  get     'cart',      to: 'cart#show_carts'             # 展示当前用户购物车中的所有物品
  post    'cart',      to: 'cart#new_cart'               # 新建一条购物车记录
  delete  'cart',      to: 'cart#remove_cart'            # 删除一条购物车记录

  post    'parches',   to: 'cart#pay_cart'               # 结算当前用户购物车中的所有物品

end
