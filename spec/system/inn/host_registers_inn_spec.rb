require 'rails_helper'

describe 'User registers an Inn' do
  it 'and it is authenticated' do
    #Arrange
    #Act
    visit new_inn_path
    #Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'a sees register page' do
    #Arrange
    user = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    #Act
    login(user)
    click_on 'Minha Pousada'
    #Assert
    expect(current_path).to eq new_address_path
    expect(page).to have_content 'Cadastrar Pousada' 
    expect(page).to have_content 'Logradouro' 
    expect(page).to have_content 'Cidade' 
    expect(page).to have_field 'Bairro' 
    expect(page).to have_content 'Número' 
  end
end