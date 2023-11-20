require 'rails_helper'

describe 'host views custom dates' do
  it 'with no custom dates registered' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com', address:address)
    room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                             varanda com vista para a praia', double_beds:1, single_beds:0, 
                             capacity:2, price:100.00, bathrooms:1, kitchen:false)
    #Act
    login_as(host, scope: :user)
    visit root_path
    click_on 'Minha Pousada'
    #Assert
    expect(page).to have_content 'Sem períodos de alteração de preço adicionados'
    #expect(page).to have_css("custom_dates", :text => 'Diária')
  end
  it 'from my_inn' do
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com', address:address)
    room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                             varanda com vista para a praia', double_beds:1, single_beds:0,
                             capacity:2, price:100.00, bathrooms:1, kitchen:false)
    room.custom_dates.create!(begin:1.days.from_now.to_date, end:5.days.from_now.to_date, price:200.00)
    room.custom_dates.create!(begin:1.month.from_now.to_date, end:2.month.from_now.to_date, price:300.00)

    login_as(host, scope: :user)
    visit root_path
    click_on 'Minha Pousada'

    expect(page).to have_content 'Períodos de alteração de preço'
    expect(page).to have_content "De #{I18n.l(1.days.from_now.to_date)} até #{I18n.l(5.days.from_now.to_date)}"
    expect(page).to have_content "De #{I18n.l(1.month.from_now.to_date)} até #{I18n.l(2.month.from_now.to_date)}"
    expect(page).to have_content 'Diária: R$ 200,00'
    expect(page).to have_content 'Diária: R$ 300,00'  
  end
end