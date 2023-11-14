require 'rails_helper'

describe 'Host registers a Room' do
  it 'and sees register page' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com', address:address)

    #Act
    login_as(host)
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Adicionar Quarto'
    #Assert
    expect(current_path).to eq new_inn_room_path(inn.id)
    expect(page).to have_content 'Adicionar Quarto' 
    expect(page).to have_field 'Número' 
    expect(page).to have_field 'Descrição' 
    expect(page).to have_field 'Banheiros' 
    expect(page).to have_field 'Hóspedes' 
  end
  it 'successfully' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com', address:address)
    #Act
    login_as(host)
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Adicionar Quarto'
    fill_in 'Número', with: '101'
    fill_in 'Descrição', with: 'Ótimo quarto, com 2 camas de casal, varanda'
    fill_in 'Camas de Casal', with: '2'
    fill_in 'Camas de Solteiro', with: '0'
    fill_in 'Hóspedes', with: '4'
    fill_in 'Diária', with: '20000'
    fill_in 'Banheiros', with: '2'
    check 'Cozinha'
    click_on 'Cadastrar'
    #Assert
    expect(page).to have_content 'Pousadinha' 
    expect(page).to have_content 'CNPJ: 123' 
    expect(page).to have_content 'Telefone: 556618' 
    expect(page).to have_content 'E-mail: pousadinha@email.com' 
    expect(page).to have_content 'Endereço: Rua das ruas, 12 - centro, São Paulo - SP' 
    expect(page).to have_content 'CEP: 15470-000' 
    
    expect(page).to have_content 'Quarto 101' 
    expect(page).to have_content 'Ótimo quarto, com 2 camas de casal, varanda' 
    expect(page).to have_content 'Diária: R$ 200,00'
  end
  it 'successfully and see details' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com', address:address)
    #Act
    login_as(host)
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Adicionar Quarto'
    fill_in 'Número', with: '101'
    fill_in 'Descrição', with: 'Ótimo quarto, com 2 camas de casal, varanda'
    fill_in 'Camas de Casal', with: '2'
    fill_in 'Camas de Solteiro', with: '0'
    fill_in 'Hóspedes', with: '4'
    fill_in 'Diária', with: '20000'
    fill_in 'Banheiros', with: '2'
    check 'Cozinha'
    click_on 'Cadastrar'
    click_on 'Quarto 101'
    #Assert
    
    expect(page).to have_content 'Quarto 101' 
    expect(page).to have_content 'Ótimo quarto, com 2 camas de casal, varanda' 
    expect(page).to have_content 'Camas: 2 de Casal' 
    expect(page).not_to have_content 'de Solteiro'
    expect(page).to have_content '4 Hóspedes'
    expect(page).to have_content 'Diária: R$ 200,00'
    expect(page).to have_content 'Cozinha: Sim'
  end
  it 'insuccessfully' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com', address:address)
    #Act
    login_as(host)
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Adicionar Quarto'
    fill_in 'Número', with: ''
    fill_in 'Camas de Casal', with: '2'
    fill_in 'Camas de Solteiro', with: '0'
    fill_in 'Hóspedes', with: '4'
    fill_in 'Diária', with: '20000'
    fill_in 'Banheiros', with: '2'
    check 'Cozinha'
    click_on 'Cadastrar'
    #Assert
    expect(page).to have_content 'Quarto não cadastrada'
    expect(page).to have_content 'Número não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
  end
  it 'with another room registered' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com', address:address)
    inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv, varanda com vista para a praia',
                      double_beds:1, single_beds:1, capacity:2, price_cents:100_00,
                      bathrooms:1, kitchen:false)
    login_as(host)
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Adicionar Quarto'
    fill_in 'Número', with: '102'
    fill_in 'Descrição', with: 'Ótimo quarto, com 2 camas de casal, varanda'
    fill_in 'Camas de Casal', with: '2'
    fill_in 'Camas de Solteiro', with: '0'
    fill_in 'Hóspedes', with: '4'
    fill_in 'Diária', with: '20000'
    fill_in 'Banheiros', with: '2'
    check 'Cozinha'
    click_on 'Cadastrar'
    
    #Assert
    expect(page).to have_content 'Quarto 101' 
    expect(page).to have_content 'Ótimo quarto com uma cama de casal, tv, varanda com vista para a praia' 
    expect(page).to have_content 'Diária: R$ 100,00'
    
    expect(page).to have_content 'Quarto 102' 
    expect(page).to have_content 'Ótimo quarto, com 2 camas de casal, varanda' 
    expect(page).to have_content 'Diária: R$ 200,00'
  end
  it 'and sees edit page' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com', address:address)
    inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv, varanda com vista para a praia',
                      double_beds:1, single_beds:0, capacity:2, price_cents:100_00,
                      bathrooms:1, kitchen:false)
    #Act
    login_as(host)
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Quarto 101'
    click_on 'Editar Quarto 101'

    #Assert
    expect(page).to have_content 'Editar Quarto 101' 
    expect(page).to have_content 'Número' 
    expect(page).to have_field 'Descrição' 
    expect(page).to have_content 'Banheiros' 
    expect(page).to have_content 'Hóspedes' 
  end
  it 'and edits it' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com', address:address)
    inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv, varanda com vista para a praia',
                        double_beds:1, single_beds:1, capacity:2, price_cents:125_00,
                        bathrooms:1, kitchen:false)
    #Act
    login_as(host)
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Quarto 101'
    click_on 'Editar Quarto 101'
    fill_in 'Diária', with: '12500'
    click_on 'Atualizar'
    #Assert
    expect(page).to have_content 'Quarto 101' 
    expect(page).to have_content 'Ótimo quarto com uma cama de casal, tv, varanda com vista para a praia'
    expect(page).to have_content 'Camas: 1 de Casal 1 de Solteiro'
    expect(page).to have_content '2 Hóspedes'
    expect(page).to have_content 'Diária: R$ 125,00'
    expect(page).to have_content 'Cozinha: Não'
  end
end