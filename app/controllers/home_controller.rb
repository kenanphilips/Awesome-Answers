class HomeController < ApplicationController

  def index

  end

  def greet
    # we can use symbols or strings to access values in the `params` Hash
    @name = params[:name]
  end

  # methods defined in controllers are called `actions`
  def about
    # render text: "About Us!"

    # This tell Rails to look for a file: /app/views/home/about.html.erb
    # it will render the file and send it as a response.
    # layout: :application tells Rails to use: /app/views/layouts/application.html.erb
    # render :about, layout: "application"
    # the line above is redundant because it's the default Rails convention
  end

end
