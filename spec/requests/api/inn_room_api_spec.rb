require 'rails_helper'

describe 'Room API' do
  context 'GET /api/v1/inns/1/rooms' do
    it 'success' do
      host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
      address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
        city:'São Paulo', state:'SP', cep:'15470-000')
      inn = host.create_inn!(name:'Safari', company_name:'Safari SN', cnpj:'123',
        phone:'556618', email:'safari@email.com', address:address)
      inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal, tv', 
        double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1, tv:true)
      inn.rooms.create!(number:'Leão', description:'Ótimo quarto com cozinha',
        double_beds:1, single_beds:2, capacity:3, price:150.00, bathrooms:0, kitchen:true)

      get "/api/v1/inns/#{inn.id}/rooms"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["number"]).to eq 'Elefante'
      expect(json_response[0]["description"]).to eq 'Ótimo quarto com uma cama de casal, tv'
      expect(json_response[1]["number"]).to eq 'Leão'
      expect(json_response[1]["description"]).to eq 'Ótimo quarto com cozinha'
      expect(json_response[0].keys).not_to include("created_at")
      expect(json_response[0].keys).not_to include("updated_at")
    end
    it 'success with correct rooms' do
      host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
      address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
        city:'São Paulo', state:'SP', cep:'15470-000')
      inn = host.create_inn!(name:'Safari', company_name:'Safari SN', cnpj:'123',
        phone:'556618', email:'safari@email.com', address:address)
      inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal, tv', 
        double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1, tv:true)

      host2 = User.create!(name: 'Matheus', email:'matheus@email.com', password:'password', host: true)
      address2 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'Centro',
        city:'Vinhedo', state:'SP', cep:'15470-000')
      inn2 = host2.create_inn!(name:'Pousada Vineard', company_name:'Pousada Vineard SN', cnpj:'456',
        phone:'223345', email:'pousadona@email.com', address:address2)
      inn2.rooms.create!(number:'Leão', description:'Ótimo quarto com cozinha',
        double_beds:1, single_beds:2, capacity:3, price:150.00, bathrooms:0, kitchen:true)

      get "/api/v1/inns/#{inn.id}/rooms"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response[0]["number"]).to eq 'Elefante'
      expect(json_response[0]["description"]).to eq 'Ótimo quarto com uma cama de casal, tv'
    end
    it 'fail if inn not found' do
      get "/api/v1/inns/99999/rooms"

      expect(response.status).to eq 404
    end
  end
end