require 'rails_helper'

describe 'Inn API' do
  context 'GET /api/v1/inns/1' do
    it 'success' do
      host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
      address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
        city:'Campinas', state:'SP', cep:'15470-000')
      inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
        email:'pousadona@email.com', address:address, pix:true, credit:true, debit:true, cash:true)
      room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
        double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
      customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
      res = room.reservations.create!(check_in_date: 10.days.ago, check_out_date: 6.days.ago,
        guests:2, customer:customer, checked_in_datetime: 10.days.ago, checked_out_datetime: 6.days.ago,
        status:"completed")
      res2 = room.reservations.create!(check_in_date: 5.days.ago, check_out_date: Time.zone.now,
        guests:2, customer:customer, checked_in_datetime: 5.days.ago, checked_out_datetime: 1.days.ago,
        status:"completed")
      res3 = room.reservations.create!(check_in_date: 5.days.ago, check_out_date: Time.zone.now,
        guests:2, customer:customer, checked_in_datetime: 5.days.ago, checked_out_datetime: 1.days.ago,
        status:"completed")
      res.create_review!(score: 5, message: 'Ótima estadia, adorei', customer:customer)
      res2.create_review!(score: 3, message: 'Bom', customer:customer)
      res3.create_review!(score: 4, message: 'Ótimo', customer:customer)

      get "/api/v1/inns/#{inn.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq 'Safari'
      expect(json_response["email"]).to eq 'pousadona@email.com'
      expect(json_response["score"]).to eq '4.0'
      expect(json_response.keys).not_to include("created_at")
      expect(json_response.keys).not_to include("updated_at")
      expect(json_response.keys).not_to include("cnpj")
      expect(json_response.keys).not_to include("company_name")
    end
    it 'fail if inn not found' do
      get "/api/v1/inns/99999"

      expect(response.status).to eq 404
    end
  end
  context 'GET /api/v1/inns' do
    it 'success' do
      host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
      address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
        city:'São Paulo', state:'SP', cep:'15470-000')
      inn = host.create_inn!(name:'Safari', company_name:'Safari SN', cnpj:'123',
        phone:'556618', email:'safari@email.com', address:address)
      host2 = User.create!(name: 'Matheus', email:'matheus@email.com', password:'password', host: true)
      address2 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'Centro',
        city:'Vinhedo', state:'SP', cep:'15470-000')
      host2.create_inn!(name:'Pousada Vineard', company_name:'Pousada Vineard SN', cnpj:'456',
        phone:'223345', email:'pousadona@email.com', address:address2)

      get "/api/v1/inns"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["name"]).to eq 'Safari'
      expect(json_response[0]["email"]).to eq 'safari@email.com'
      expect(json_response[1]["name"]).to eq 'Pousada Vineard'
      expect(json_response[1]["email"]).to eq 'pousadona@email.com'
      expect(json_response[0].keys).not_to include("created_at")
      expect(json_response[0].keys).not_to include("updated_at")
    end
    it 'with name search' do
      host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
      address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
        city:'São Paulo', state:'SP', cep:'15470-000')
      inn = host.create_inn!(name:'Safari', company_name:'Safari SN', cnpj:'123',
        phone:'556618', email:'safari@email.com', address:address)
      host2 = User.create!(name: 'Matheus', email:'matheus@email.com', password:'password', host: true)
      address2 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'Centro',
        city:'Vinhedo', state:'SP', cep:'15470-000')
      host2.create_inn!(name:'Pousada Vineard', company_name:'Pousada Vineard SN', cnpj:'456',
        phone:'223345', email:'pousadona@email.com', address:address2)

      get "/api/v1/inns", params: { query: 'Safari'}

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response[0]["name"]).to eq 'Safari'
      expect(json_response[0]["email"]).to eq 'safari@email.com'
      expect(json_response[0].keys).not_to include("created_at")
      expect(json_response[0].keys).not_to include("updated_at")
    end
    it 'empty if no results' do
      get "/api/v1/inns"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end
end