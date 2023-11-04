class AddressController < ApplicationController
  def new
    @address = Address.new()
  end
end