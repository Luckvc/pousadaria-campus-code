require 'rails_helper'

describe 'Inn API' do
  context 'GET /api/v1/inns/1' do
    it 'success' do
      host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
      address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
        city:'São Paulo', state:'SP', cep:'15470-000')
      inn = host.create_inn!(name:'Safari', company_name:'Safari SN', cnpj:'123',
        phone:'556618', email:'safari@email.com', address:address)

      get "/api/v1/inns/#{inn.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq 'Safari'
      expect(json_response["email"]).to eq 'safari@email.com'
      expect(json_response.keys).not_to include("created_at")
      expect(json_response.keys).not_to include("updated_at")
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