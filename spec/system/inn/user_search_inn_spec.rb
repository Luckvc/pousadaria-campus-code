require 'rails_helper'

describe 'User searchs for a inn' do
  it 'from home page' do
    #Arrange
    #Act
    visit root_path

    #Assert
    within('nav') do
      expect(page).to have_field 'Buscar Pousada'
      expect(page).to have_button 'Buscar'
    end
  end
end