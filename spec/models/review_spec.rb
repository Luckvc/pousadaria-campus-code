require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when score is empty' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        customer = Customer.create!(name:'nome', cpf:'123', email:'email@email.com', password:'123123')
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro', 
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', 
                               phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal',
                                 double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1,
                                 kitchen:false)  
        res = customer.reservations.create!(check_in_date:10.days.from_now,
                                            check_out_date:20.days.from_now, guests: 2, room:room)
        review = res.build_review()
        #Act
        review.valid?
        #Assert
        expect(review.errors[:score]).to include 'não pode ficar em branco'
      end
    end
  end
end
