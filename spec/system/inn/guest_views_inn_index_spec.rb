require 'rails_helper'

describe 'Guest views inns' do
  it 'in home page' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', phone:'556618',
                     email:'pousadinha@email.com', address:address)
    host2 = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address2 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
                               city:'Campinas', state:'SP', cep:'15470-000')
    host2.create_inn!(name:'Pousadona', company_name:'Pousadona SN', cnpj:'456', phone:'223345',
                      email:'pousadona@email.com', address:address2)
    #Act
    visit root_path
    #Assert
    expect(page).to have_content 'Pousadinha'
    expect(page).to have_content 'Pousadona'
    expect(page).to have_content 'São Paulo - SP'
    expect(page).to have_content 'Campinas - SP'
    expect(current_path).to eq root_path
  end
  it 'in home page' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    host.create_inn!(name:'Pousada Jabaquara', company_name:'Pousada Jabaquara SN', cnpj:'123',
                     phone:'556618', email:'pousadabeiramar@email.com', address:address)

    host2 = User.create!(name: 'Matheus', email:'matheus@email.com', password:'password', host: true)
    address2 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
                               city:'Vinhedo', state:'SP', cep:'15470-000')
    host2.create_inn!(name:'Pousada Vineard', company_name:'Pousada Vineard SN', cnpj:'456',
                      phone:'223345', email:'pousadona@email.com', address:address2)

    host3 = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address3 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
                               city:'Ilha-Bela', state:'SP', cep:'15470-000')
    host3.create_inn!(name:'Pousada Beira-Mar', company_name:'Pousada Beira-Mar SN', cnpj:'456',
                      phone:'223345', email:'pousadona@email.com', address:address3)

    host4 = User.create!(name: 'Roberto', email:'roberto@email.com', password:'password', host: true)
    address4 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
                               city:'Guarujá', state:'SP', cep:'15470-000')
    host4.create_inn!(name:'Pousada Maresia', company_name:'Pousada Maresia SN', cnpj:'456',
                      phone:'223345', email:'pousadona@email.com', address:address4)
    #Act
    visit root_path
    #Assert

    expect(page).to have_content 'Pousada Beira-Mar'
    expect(page).to have_content 'Pousada Vineard'
    expect(page).to have_content 'Pousada Maresia'
    expect(page).to have_content 'Vinhedo - SP'
    expect(page).to have_content 'Ilha-Bela - SP'
    expect(page).to have_content 'Guarujá - SP'

    expect(page).to have_content 'Pousada Jabaquara'
    expect(page).to have_content 'São Paulo - SP'
    expect(current_path).to eq root_path
  end
  it 'with no inn registered' do
    #Arrange
    #Act
    visit root_path
    #Assert
    expect(page).not_to have_content 'Destaques'
    expect(page).not_to have_content 'Outras opções:'
    expect(page).to have_content 'Sem pousadas registradas'
  end
end