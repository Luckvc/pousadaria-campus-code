require 'rails_helper'

describe 'User view inn by city' do
  it 'from the home page' do
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    host.create_inn!(name:'Pousada Jabaquara', company_name:'Pousada Jabaquara SN', cnpj:'123',
                     phone:'556618', email:'pousadabeiramar@email.com', address:address)

    host2 = User.create!(name: 'Matheus', email:'matheus@email.com', password:'password', host: true)
    address2 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'Centro',
                               city:'Vinhedo', state:'SP', cep:'15470-000')
    host2.create_inn!(name:'Pousada Vineard', company_name:'Pousada Vineard SN', cnpj:'456',
                      phone:'223345', email:'pousadona@email.com', address:address2)

    visit root_path
    click_on 'Cidades'

    expect(page).to have_content 'São Paulo'
    expect(page).to have_content 'Vinhedo'
  end
  it 'from the home page' do
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    host.create_inn!(name:'Pousada Jabaquara', company_name:'Pousada Jabaquara SN', cnpj:'123',
                     phone:'556618', email:'pousadabeiramar@email.com', address:address)

    host2 = User.create!(name: 'Matheus', email:'matheus@email.com', password:'password', host: true)
    address2 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'Centro',
                               city:'Vinhedo', state:'SP', cep:'15470-000')
    host2.create_inn!(name:'Pousada Vineard', company_name:'Pousada Vineard SN', cnpj:'456',
                      phone:'223345', email:'pousadona@email.com', address:address2)

    host3 = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address3 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'Prainha',
                               city:'Vinhedo', state:'SP', cep:'15470-000')
    host3.create_inn!(name:'Pousada Beira-Mar', company_name:'Pousada Beira-Mar SN', cnpj:'456',
                      phone:'223345', email:'pousadona@email.com', address:address3)

    host4 = User.create!(name: 'Roberto', email:'roberto@email.com', password:'password', host: true)
    address4 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'Centro',
                               city:'Guarujá', state:'SP', cep:'15470-000')
    host4.create_inn!(name:'Pousada Maresia', company_name:'Pousada Maresia SN', cnpj:'456',
                      phone:'223345', email:'pousadona@email.com', address:address4)

    visit root_path
    click_on 'Cidades'
    click_on 'Vinhedo'

    expect(page).to have_content 'Vinhedo'
    expect(page).to have_content 'Resultados encontrados: 2'
    expect(page).to have_content 'Pousada Vineard'
    expect(page).to have_content 'Centro, Vinhedo - SP'
    expect(page).to have_content 'Pousada Beira-Mar'
    expect(page).to have_content 'Prainha, Vinhedo - SP'
    
  end
end