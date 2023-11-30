require 'rails_helper'

describe 'Guest advance searchs for a inn' do
  it 'and sees search field' do
    #Arrange
    #Act
    visit root_path
    click_on 'Busca Avançada'

    #Assert
    expect(page).to have_content 'Busca Avançada'
    expect(page).to have_field 'Buscar Pousada:'
    expect(page).to have_field 'Acessível para PCD'
    expect(page).to have_field 'Cozinha'
    expect(page).to have_field 'TV'
    expect(page).to have_field 'Varanda'
    expect(page).to have_field 'Ar Condicionado'
    expect(page).to have_field 'Guarda-Roupas'
    expect(page).to have_field 'Cofre'
    expect(page).to have_field 'Pets'
    within ('div form') do
      expect(page).to have_button 'Busca Avançada'
    end
  end
  it 'successfully' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousada Jabaquara', company_name:'Pousada Jabaquara SN', cnpj:'123',
                     phone:'556618', email:'pousadabeiramar@email.com', address:address, pets:true )
    inn.rooms.create!(number: '101', description: 'Ótimo quarto com uma cama de casal, com TV',
                      double_beds: 1, single_beds: 0, capacity: 2, price: 100.00, bathrooms: 1,
                      kitchen: false, dimension: '13', air: false, tv: true, wardrobe: true,
                      balcony: true, safe: true, accessible: false)
                          
    inn.rooms.create!(number: '201', description: 'Quarto confortável com três camas de solteiro',
                      double_beds: 0, single_beds: 3, capacity: 3, price: 80.00, bathrooms: 1,
                      kitchen: false, dimension: '15', air: true, tv: true, wardrobe: true,
                      balcony: false, safe: false, accessible: true)

    host2 = User.create!(name: 'Matheus', email:'matheus@email.com', password:'password', host: true)
    address2 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'Centro',
                               city:'Vinhedo', state:'SP', cep:'15470-000')
    inn2 = host2.create_inn!(name:'Pousada Vineard', company_name:'Pousada Vineard SN', cnpj:'456',
                      phone:'223345', email:'pousadona@email.com', address:address2, pets:true )
    inn2.rooms.create!(number: '302', description: 'Quarto moderno com duas camas de solteiro e decoração contemporânea',
                       double_beds: 0, single_beds: 2, capacity: 2, price: 90.00, bathrooms: 1,
                       kitchen: false, dimension: '16', air: true, tv: true, wardrobe: true,
                       balcony: false, safe: false, accessible: true)

    host3 = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address3 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'Centro',
                               city:'Ilha-Bela', state:'SP', cep:'15470-000')
    inn3 = host3.create_inn!(name:'Pousada Beira-Mar', company_name:'Pousada Beira-Mar SN', cnpj:'456',
                      phone:'223345', email:'pousadona@email.com', address:address3, pets:true )
    inn3.rooms.create!(number: '103', description: 'Suíte familiar com duas camas de casal e vista para a piscina',
                       double_beds: 2, single_beds: 1, capacity: 5, price: 200.00, bathrooms: 2,
                       kitchen: true, dimension: '25', air: true, tv: true, wardrobe: true,
                       balcony: true, safe: true, accessible: true)

    host4 = User.create!(name: 'Roberto', email:'roberto@email.com', password:'password', host: true)
    address4 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'Centro',
                               city:'Guarujá', state:'SP', cep:'15470-000')
    host4.create_inn!(name:'Pousada Maresia', company_name:'Pousada Maresia SN', cnpj:'456',
                      phone:'223345', email:'pousadona@email.com', address:address4, pets: false)

    #Act
    visit root_path
    click_on 'Busca Avançada'
    fill_in 'Hóspedes:', with: '3'
    check 'Pets'
    check 'Ar Condicionado'
    within('div form') do
      click_on 'Busca Avançada'
    end

    #Assert
    expect(page).to have_content 'Resultados: 2'
    expect(page).to have_content 'Pousada Beira-Mar'
    expect(page).to have_link 'Pousada Jabaquara'
  end
  it 'successfully with text' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousada Jabaquara', company_name:'Pousada Jabaquara SN', cnpj:'123',
                     phone:'556618', email:'pousadabeiramar@email.com', address:address, pets:true )
    inn.rooms.create!(number: '101', description: 'Ótimo quarto com uma cama de casal, com TV',
                      double_beds: 1, single_beds: 0, capacity: 2, price: 100.00, bathrooms: 1,
                      kitchen: false, dimension: '13', air: false, tv: true, wardrobe: true,
                      balcony: true, safe: true, accessible: false)
                          
    inn.rooms.create!(number: '201', description: 'Quarto confortável com três camas de solteiro',
                      double_beds: 0, single_beds: 3, capacity: 3, price: 80.00, bathrooms: 1,
                      kitchen: false, dimension: '15', air: true, tv: true, wardrobe: true,
                      balcony: false, safe: false, accessible: true)

    host2 = User.create!(name: 'Matheus', email:'matheus@email.com', password:'password', host: true)
    address2 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'Centro',
                               city:'Vinhedo', state:'SP', cep:'15470-000')
    inn2 = host2.create_inn!(name:'Pousada Vineard', company_name:'Pousada Vineard SN', cnpj:'456',
                      phone:'223345', email:'pousadona@email.com', address:address2, pets:true )
    inn2.rooms.create!(number: '302', description: 'Quarto moderno com duas camas de solteiro e decoração contemporânea',
                       double_beds: 0, single_beds: 2, capacity: 2, price: 90.00, bathrooms: 1,
                       kitchen: false, dimension: '16', air: true, tv: true, wardrobe: true,
                       balcony: false, safe: false, accessible: true)

    host3 = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address3 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'Centro',
                               city:'Ilha-Bela', state:'SP', cep:'15470-000')
    inn3 = host3.create_inn!(name:'Pousada Beira-Mar', company_name:'Pousada Beira-Mar SN', cnpj:'456',
                      phone:'223345', email:'pousadona@email.com', address:address3, pets:true )
    inn3.rooms.create!(number: '103', description: 'Suíte familiar com duas camas de casal e vista para a piscina',
                       double_beds: 2, single_beds: 1, capacity: 5, price: 200.00, bathrooms: 2,
                       kitchen: true, dimension: '25', air: true, tv: true, wardrobe: true,
                       balcony: true, safe: true, accessible: true)

    host4 = User.create!(name: 'Roberto', email:'roberto@email.com', password:'password', host: true)
    address4 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'Centro',
                               city:'Guarujá', state:'SP', cep:'15470-000')
    host4.create_inn!(name:'Pousada Maresia', company_name:'Pousada Maresia SN', cnpj:'456',
                      phone:'223345', email:'pousadona@email.com', address:address4, pets: false)

    #Act
    visit root_path
    click_on 'Busca Avançada'
    within('div form') do
    fill_in 'Buscar Pousada:', with: 'Pousada Beira-Mar'
    check 'Pets'
    check 'Ar Condicionado'
      click_on 'Busca Avançada'
    end

    #Assert
    expect(page).to have_content 'Resultados: 1'
    expect(page).to have_content 'Pousada Beira-Mar'
    expect(page).not_to have_content 'Pousada Vineard'
  end
  it 'with no results' do
    #Arrange

    #Act
    visit root_path
    click_on 'Busca Avançada'
    fill_in 'Hóspedes:', with: "10"
    within('div form') do
      click_on 'Busca Avançada'
    end

    #Assert
    expect(page).to have_content 'Nenhum resultado foi encontrado'
  end
end