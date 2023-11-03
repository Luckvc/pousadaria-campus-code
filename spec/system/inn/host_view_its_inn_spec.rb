require 'rails_helper'

describe 'User view its own inn' do
  it 'Successfully' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro', city:'São Paulo', state:'SP', cep:'15470-000')
    inn = Inn.create!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', phone:'556618', email:'pousadinha@email.com', address:address, user:host)
    
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro', city:'São Paulo', state:'SP', cep:'15470-000')
    inn = Inn.create!(name:'Pousadona', company_name:'Pousadona SN', cnpj:'456', phone:'223345', email:'pousadona@email.com', address:address, user:host)

    #Act
    visit root_path
    click_on 'Entrar'
    within ('form') do
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Minha Pousada'
    #Assert
    expect(page).to have_content 'Pousadona'
    expect(page).not_to have_content 'Pousadinha'
    expect(page).to have_content '223345'
    expect(page).to have_content 'Rua das torres, 28'
    expect(page).to have_content 'São Paulo, SP'
    expect(page).to have_content 'pousadona@email.com'
    expect(page).to have_content '223345'
    expect(page).to have_link 'Adicionar Quarto'
  end
end

