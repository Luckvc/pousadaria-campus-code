class AddressesController < ApplicationController
  before_action :authenticate_user!

  def new
    @address = Address.new()
  end
end