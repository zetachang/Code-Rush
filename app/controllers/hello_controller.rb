class HelloController < ApplicationController
  def index
    render :text => "<h1>Hello Wolrd</h1>";
  end

end
