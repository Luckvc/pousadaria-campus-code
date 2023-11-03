class InnController < ApplicationController
  def new
  end

  def my_inn
    @inn = current_user.inn
  end
end