class HomeController < ApplicationController
 def index
  @last_inns = Inn.last(3)
  @inns = Inn.all - @last_inns
 end
end