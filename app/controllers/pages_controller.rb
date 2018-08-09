class PagesController < ApplicationController
  def home
    @cryptos = Crypto.all
  end

  def punition
    redirect_to '/home'
  end

  def create
    @msg = params[:name]
    StartScrap.new(@msg).perform
    redirect_to root_path
  end
end
