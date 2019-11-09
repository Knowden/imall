Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_page#index'

  get  'sign_up',   to: 'sign#show_sign_up_page'
  post 'sign_up',   to: 'sign#do_sign_up'

  get  'sign_in',   to: 'sign#show_sign_in_page'
  post 'sign_in',   to: 'sign#do_sign_in'

  get  'sign_out',  to: 'sign#do_sign_out'

  get  'search',    to: 'search#show_search_page'

  get  'items/:item_id', to: 'item#show'
end
