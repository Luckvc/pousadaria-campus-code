require 'rails_helper'

RSpec.describe CustomDate, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when begin date is empty' do
        #Arrange
        cd = CustomDate.new(begin:'', end:5.days.from_now, price:300.00)
        #Act
        cd.valid?
        #Assert
        expect(cd.errors[:begin]).to include("não pode ficar em branco")
      end
      it 'false when end date is empty' do
        #Arrange
        cd = CustomDate.new(begin:5.days.from_now, end:'', price:300.00)
        #Act
        cd.valid?
        #Assert
        expect(cd.errors[:end]).to include("não pode ficar em branco")
      end
      it 'false when price is empty' do
        #Arrange
        cd = CustomDate.new(begin:2.days.from_now, end:5.days.from_now, price:'')
        #Act
        cd.valid?
        #Assert
        expect(cd.errors[:price]).to include("não pode ficar em branco")
      end
    end
    context 'range_overlap' do
      it 'a starts after b ends' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        room.custom_dates.create!(begin:10.days.from_now, end:20.days.from_now, 
                                  price:10000)
        cd = room.custom_dates.build(begin:1.days.from_now, end:5.days.from_now, 
                                     price:20000)
        #Act
        #Assert
        expect(cd.valid?).to be true
      end
      it 'b starts after a ends' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        room.custom_dates.create!(begin:10.days.from_now, end:20.days.from_now, 
                                  price:10000)
        cd = room.custom_dates.build(begin:25.days.from_now, end:35.days.from_now, 
                                     price:20000)
        #Act
        #Assert
        expect(cd.valid?).to be true
      end
      it 'a starts in the middle of b' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        room.custom_dates.create!(begin:10.days.from_now, end:20.days.from_now, 
                                  price:10000)
        cd = room.custom_dates.build(begin:15.days.from_now, end:35.days.from_now, 
                                     price:20000)
        #Act
        cd.valid?
        #Assert
        expect(cd.errors[:begin]).to include("não pode haver sobreposição entre preços sazonais")
      end
      it 'b starts in the middle of a' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        room.custom_dates.create!(begin:10.days.from_now, end:20.days.from_now, 
                                  price:10000)
        cd = room.custom_dates.build(begin:5.days.from_now, end:15.days.from_now, 
                                     price:20000)
        #Act
        cd.valid?
        #Assert
        expect(cd.errors[:begin]).to include("não pode haver sobreposição entre preços sazonais")
      end
      it 'b is in between a' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        room.custom_dates.create!(begin:10.days.from_now, end:20.days.from_now, 
                                  price:10000)
        cd = room.custom_dates.build(begin:12.days.from_now, end:15.days.from_now, 
                                     price:20000)
        #Act
        cd.valid?
        #Assert
        expect(cd.errors[:begin]).to include("não pode haver sobreposição entre preços sazonais")
      end
      it 'a is in between b' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        room.custom_dates.create!(begin:10.days.from_now, end:20.days.from_now, 
                                  price:10000)
        cd = room.custom_dates.build(begin:5.days.from_now, end:25.days.from_now, 
                                     price:20000)
        #Act
        cd.valid?
        #Assert
        expect(cd.errors[:begin]).to include("não pode haver sobreposição entre preços sazonais")
      end
    end
  end
end
