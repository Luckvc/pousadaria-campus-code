require 'rails_helper'

describe 'Host adds image to inn' do
  it 'and views image upload page' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', phone:'556618',
                    email:'pousadinha@email.com', address:address)
    
    #Act
    login_as(host, scope: :user)
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Adicionar Imagens'
    #Assert
    expect(page).to have_content 'Adicionar Imagens'
    expect(page).to have_content 'Imagens'
  end
end