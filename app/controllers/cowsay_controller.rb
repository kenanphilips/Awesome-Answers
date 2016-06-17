class CowsayController < ApplicationController

  def index
  end

  def create
    @cowsay_string = Cowsay.say params[:sentence]
  end

end
