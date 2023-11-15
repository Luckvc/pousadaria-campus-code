require 'rails_helper'


describe 'Host edits Inn' do
  it 'and sees edit page' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', phone:'556618', 
                     email:'pousadinha@email.com', address:address)
    #Act
    login_as(host)
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Editar Pousada'

    #Assert
    expect(page).to have_content 'Editar Pousada'
    expect(page).to have_content 'Dados da Empresa'
    expect(page).to have_content 'CNPJ'
    expect(page).to have_content 'Razão Social'
    expect(page).to have_content 'Nome Fantasia'
    expect(page).to have_content 'Telefone'
    expect(page).to have_content 'E-mail'
    expect(page).to have_content 'Endereço da Pousada'
    expect(page).to have_content 'Logradouro'
    expect(page).to have_content 'Cidade'
    expect(page).to have_field 'Bairro'
    expect(page).to have_content 'Número'
  end
  it 'successfully' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', phone:'556618',
                     email:'pousadinha@email.com', address:address)
    #Act
    login_as(host)
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Editar Pousada'
    fill_in 'Telefone', with: '11955554444'
    fill_in 'E-mail', with: 'pousada@email.com'
    fill_in 'Cidade', with: 'Palestina'
    fill_in 'Logradouro', with: 'Rua Capitão'
    fill_in 'Número', with: '30'
    click_on 'Atualizar'
    #Assert
    expect(page).to have_content 'Telefone: 11955554444'
    expect(page).to have_content 'Pousadinha'
    expect(page).to have_content 'E-mail: pousada@email.com'
    expect(page).to have_content 'Endereço: Rua Capitão, 30 - Centro, Palestina - SP'
  end
  it 'insuccessfully' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', phone:'556618',
                     email:'pousadinha@email.com', address:address)
    #Act
    login_as(host)
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Editar Pousada'
    fill_in 'Telefone', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Atualizar'
    #Assert
    expect(page).to have_content 'Não foi possível atualizar a pousada'
  end
  it 'to be innactive' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', phone:'556618',
                     email:'pousadinha@email.com', address:address)
    #Act
    login_as(host)
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Mudar Status da Pousada'
    click_on 'Desativar'

    #Assert
    expect(page).to have_content 'Pousada desativada'
    expect(page).to have_content 'Status: Inativa'
  end
end