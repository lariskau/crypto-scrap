require 'nokogiri'
require 'open-uri'
require 'csv'

class StartScrap

  def initialize(name)
    @name = name
    @page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
  end


  #Création d'une méthode
  def perform
  #Création de deux tableau pour le nom de la money et leur valeur
  		noms = []
  		prix = []
  #Scrapping des noms
  		@page.css('a.currency-name-container').each do |nom|
  			noms << nom.text
  		end
  #Scrapping des valeurs des moneys
  		@page.css('a.price').each do |i|
  			prix << i.text
  		end
      @crypto_hash = Hash[noms.zip(prix)]
      save
  end

  def save
    a = Crypto.all.ids
    if a.length == 1
      Crypto.last.destroy
    end
    Crypto.create(name: "#{@name}", value: "#{@crypto_hash.values_at("#{@name}")}")
  end
end
