require "rubygems"
require "sinatra/base"
require 'haml'
require 'net/http'
require 'json'


class Mtgp < Sinatra::Base
set :bind, '0.0.0.0'
set :haml, :format => :html5
  get '/' do
    cname = params[:cardname]
    unless cname.nil? 
      uri = URI.parse("http://magictcgprices.appspot.com/api/tcgplayer/price.json?cardname="+URI.escape(cname))
      res = Net::HTTP.get_response(uri)
      prices = JSON.parse(res.body)
    end
    if prices.nil?
      prices = ["", "", ""]
    end
    haml :index, :locals => {:low => prices[0], :mid => prices[1], :high => prices[2]}
  end

  get '/search' do
    cname = params[:cardname]
    redirect 'http://store.tcgplayer.com/magic/product/show?productname='+cname
  end
end
