Rails.application.routes.draw do
  root 'main#index'
  get  'slides'  => 'main#slides'
  get  'reflect'  => 'main#reflect'
  get  'redirect' => 'main#redirect'
  post 'post'     => 'main#post'
  get  'etag'     => 'main#etag'
end
