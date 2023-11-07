require 'rails_helper'

describe 'host adds custom date price' do
  it 'and it is authenticated' do
    #Arrange
    #Act
    visit my_inn_path
    #Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'and sees custom date page' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com', address:address)
    inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv, varanda com
                      vista para a praia', double_beds:1, single_beds:0, capacity:2,
                      price_cents:100_00, bathrooms:1, kitchen:false)
    inn.rooms.create!(number:'102', description:'Ótimo quarto com uma cama de solteiro, tv, varanda
                      com vista para a praia', double_beds:0, single_beds:1, capacity:1,
                      price_cents:200_00, bathrooms:1, kitchen:false)
    #Act
    login_as(host)
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Quarto - 101'
    click_on 'Adicionar preço sazonal'
    
    expect(page).to have_content 'Adicionar Preço Sazonal | Quarto - 101'
    expect(page).to have_content 'Data Início'
    #expect(page).to have_field 'Data Fim'
    #expect(page).to have_field 'Diária'
    #Assert
  end
end