require 'rails_helper'

describe 'Inn API' do
  context 'GET /api/v1/inn/1' do
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
end