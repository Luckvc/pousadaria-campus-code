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
  it 'from home page' do
    #Arrange
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
    address3 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'Centro',
                               city:'Ilha-Bela', state:'SP', cep:'15470-000')
    host3.create_inn!(name:'Pousada Beira-Mar', company_name:'Pousada Beira-Mar SN', cnpj:'456',
                      phone:'223345', email:'pousadona@email.com', address:address3)

    host4 = User.create!(name: 'Roberto', email:'roberto@email.com', password:'password', host: true)
    address4 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'Centro',
                               city:'Guarujá', state:'SP', cep:'15470-000')
    host4.create_inn!(name:'Pousada Maresia', company_name:'Pousada Maresia SN', cnpj:'456',
                      phone:'223345', email:'pousadona@email.com', address:address4)

    #Act
    visit root_path
    fill_in 'Buscar Pousada', with: 'Vineard'
    click_on 'Buscar'

    #Assert
    expect(page).to have_content 'Resultados da busca por: Vineard'
    #expect(page).to have_content '1 pousada encontrada'
    expect(page).to have_content 'Pousada Vineard'
    expect(page).to have_content 'Centro, Vinhedo - SP'
  end
end