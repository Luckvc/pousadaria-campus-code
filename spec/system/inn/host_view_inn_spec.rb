require 'rails_helper'

describe 'Host view its own inn' do
  it 'Successfully' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', phone:'556618',
                     email:'pousadinha@email.com', address:address)
    
    host2 = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address2 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
                               city:'São Paulo', state:'SP', cep:'15470-000')
    host2.create_inn!(name:'Pousadona', company_name:'Pousadona SN', cnpj:'456', phone:'223345',
                      email:'pousadona@email.com', address:address2)

    #Act
    login_as(host2, scope: :user)
    visit root_path
    click_on 'Minha Pousada'
    #Assert
    expect(page).to have_content 'Pousadona'
    expect(page).not_to have_content 'Pousadinha'
    expect(page).to have_content 'Rua das torres, 28 - centro, São Paulo - SP'
    expect(page).to have_content 'pousadona@email.com'
    expect(page).to have_content '223345'
    expect(page).to have_link 'Adicionar Quarto'
  end
  it 'if it is not logged in' do
    #Arrange
    #Act
    visit my_inn_path
    #Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'if it is not logged in as host' do
    #Arrange
    customer = Customer.create!(name: 'Lucas', cpf:'222', email:'test@email.com', password:'password')
    
    #Act
    login_as(customer, scope: :customer)
    visit root_path
    visit my_inn_path
    #Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    expect(page).to have_content 'Dono de Pousada'
  end
  it 'with no inn registered' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    
    #Act
    login_as(host, scope: :user)
    visit root_path
    click_on 'Minha Pousada'
    #Assert
    expect(page).to have_content 'Cadastrar Pousada'
    expect(current_path).to eq new_inn_path
  end
end

