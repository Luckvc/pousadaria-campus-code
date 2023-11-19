class HomeController < ApplicationController
 def index
  @last_inns = Inn.last(3)
  @inns = Inn.all.order(:name) - @last_inns
 end
end