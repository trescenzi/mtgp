require 'sinatra'
require 'haml'

set :bind, '0.0.0.0'
set :haml, :format => :html5

get '/' do
  haml :index
end

get '/search' do
  cname = params[:cardname]
  redirect 'http://store.tcgplayer.com/magic/product/show?productname='+cname
end
