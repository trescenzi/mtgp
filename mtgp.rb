require "rubygems"
require "sinatra/base"
require 'haml'
require 'net/http'
require 'json'
require './lib/api.rb'


class Mtgp < Sinatra::Base
set :bind, '0.0.0.0'
set :haml, :format => :html5
  get '/' do
    input = params[:cardname]
    card = MtgCard.new(input)
    prices = card.tcgPrice
    haml :index, :locals => {:low => prices[0], :mid => prices[1], :high => prices[2]}
  end

  get '/search' do
    cname = params[:cardname]
    redirect 'http://store.tcgplayer.com/magic/product/show?productname='+cname
  end
end
