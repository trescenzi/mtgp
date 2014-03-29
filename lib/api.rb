require 'net/http'
require 'json'

class MtgCard

  def initialize(cname_set)
    unless cname_set.nil?
      cname_set = URI.unescape(cname_set)
      @card_name = cname_set.split(";")[0].strip
      @card_set = cname_set.split(";")[1]
      unless @card_set.nil?
        @card_set.strip!
      end
    end
    @card_name = URI.escape(@card_name) unless @card_name.nil?
    @card_set = URI.escape(@card_set) unless @card_set.nil?
  end

  def tcgPrice
    base_url = "http://magictcgprices.appspot.com/api/tcgplayer/price.json?cardname="
    base_url += @card_name unless @card_name.nil?
    base_url += "&cardset=" + @card_set unless @card_set.nil?
    uri = URI.parse(base_url)
    res = Net::HTTP.get_response(uri)
    prices = JSON.parse(res.body)
    if prices.nil?
      prices = ["", "", ""]
    end
    return prices
  end
end
