class TempConverterController < ApplicationController

  def index
  end

  def create
    @temp = params[:temp].to_f
    @temp_f = @temp * 1.8 + 32
    render :index
  end

end
