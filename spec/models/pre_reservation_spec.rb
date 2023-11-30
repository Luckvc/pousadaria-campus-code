require 'rails_helper'

RSpec.describe PreReservation, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when check_in_date is empty' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        pr = room.pre_reservations.new()
        #Act
        pr.valid?
        #Assert
        expect(pr.errors[:check_in_date]).to include 'não pode ficar em branco'
      end
      it 'false when check_out_date is empty' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        pr = room.pre_reservations.new()
        #Act
        pr.valid?
        #Assert
        expect(pr.errors[:check_out_date]).to include 'não pode ficar em branco'
      end
      it 'false when guests is empty' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        pr = room.pre_reservations.new()
        #Act
        pr.valid?
        #Assert
        expect(pr.errors[:guests]).to include 'não pode ficar em branco'
      end
    end
    context 'valid date range' do
      it 'false when check-in earlier than current date' do
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        pr = room.pre_reservations.new(check_in_date: 2.days.ago, 
                                check_out_date: 12.days.from_now, guests:1)

        pr.valid?

        expect(pr.errors[:check_in_date]).to include ' deve ser futura.'
      end
      it 'false when check-out earlier than check-in' do
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        pr = room.pre_reservations.new(check_in_date: 12.days.from_now, 
                                check_out_date: 10.days.from_now, guests:1)

        expect(pr.valid?).to be false
      end



      it 'a starts after b ends' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        room.reservations.create!(check_in_date: 10.days.from_now, 
                                check_out_date: 20.days.from_now, guests:1, customer:customer)
        pr = room.pre_reservations.new(check_in_date: 1.days.from_now, 
                                check_out_date: 9.days.from_now, guests:1)
        #Act
        #Assert
        expect(pr.valid?).to be true
      end
      it 'b starts after a ends' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        room.reservations.create!(check_in_date: 10.days.from_now, 
                                check_out_date: 20.days.from_now, guests:1, customer:customer)
        pr = room.pre_reservations.new(check_in_date: 21.days.from_now, 
                                check_out_date: 29.days.from_now, guests:1)
        #Act
        #Assert
        expect(pr.valid?).to be true
      end
      it 'a starts in the middle of b' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        room.reservations.create!(check_in_date: 10.days.from_now, 
                                check_out_date: 20.days.from_now, guests:1, customer:customer)
        pr = room.pre_reservations.new(check_in_date: 5.days.from_now, 
                                check_out_date: 15.days.from_now, guests:1)
        #Act
        pr.valid?
        #Assert
        expect(pr.errors[:check_in_date]).to include("não disponível")
      end
      it 'b starts in the middle of a' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        room.reservations.create!(check_in_date: 10.days.from_now, 
                                check_out_date: 20.days.from_now, guests:1, customer:customer)
        pr = room.pre_reservations.new(check_in_date: 15.days.from_now, 
                                check_out_date: 29.days.from_now, guests:1)
        #Act
        pr.valid?
        #Assert
        expect(pr.errors[:check_in_date]).to include("não disponível")
      end
      it 'b is in between a' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        room.reservations.create!(check_in_date: 10.days.from_now, 
                                check_out_date: 20.days.from_now, guests:1, customer:customer)
        pr = room.pre_reservations.new(check_in_date: 11.days.from_now, 
                                check_out_date: 19.days.from_now, guests:1)
        #Act
        pr.valid?
        #Assert
        expect(pr.errors[:check_in_date]).to include("não disponível")
      end
      it 'a is in between b' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        room.reservations.create!(check_in_date: 10.days.from_now, 
                                check_out_date: 20.days.from_now, guests:1, customer:customer)
        pr = room.pre_reservations.new(check_in_date: 1.days.from_now, 
                                check_out_date: 29.days.from_now, guests:1)
        #Act
        pr.valid?
        #Assert
        expect(pr.errors[:check_in_date]).to include("não disponível")
      end
      it 'b starts at the end of a' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        room.reservations.create!(check_in_date: 10.days.from_now, 
                                check_out_date: 20.days.from_now, guests:1, customer:customer)
        pr = room.pre_reservations.new(check_in_date: 20.days.from_now, 
                                check_out_date: 29.days.from_now, guests:1)
        #Act
        pr.valid?
        #Assert
        expect(pr.errors[:check_in_date]).to include("não disponível")
      end
      it 'a starts at the end of b' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        room.reservations.create!(check_in_date: 10.days.from_now, 
                                check_out_date: 20.days.from_now, guests:1, customer:customer)
        pr = room.pre_reservations.new(check_in_date: 1.days.from_now, 
                                check_out_date: 10.days.from_now, guests:1)
        #Act
        pr.valid?
        #Assert
        expect(pr.errors[:check_in_date]).to include("não disponível")
      end



    end
  end
  describe '#confirmation' do
    it 'calculate total' do
      host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
      address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                city:'São Paulo', state:'SP', cep:'15470-000')
      inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                            phone:'556618', email:'pousadinha@email.com', address:address)
      room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                              varanda com vista para a praia', double_beds:1, single_beds:0, 
                              capacity:2, price:100.00, bathrooms:1, kitchen:false)
      pr = room.pre_reservations.create!(check_in_date: 2.days.from_now, check_out_date: 12.days.from_now, guests:1)

      expect(pr.total).to eq 1000.00
    end
    it 'calculate total with a custom price range' do
      host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
      address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                city:'São Paulo', state:'SP', cep:'15470-000')
      inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                            phone:'556618', email:'pousadinha@email.com', address:address)
      room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                              varanda com vista para a praia', double_beds:1, single_beds:0, 
                              capacity:2, price:100.00, bathrooms:1, kitchen:false)
      room.custom_dates.build(begin:1.days.from_now, end:7.days.from_now, price:200)
      pr = room.pre_reservations.create!(check_in_date: 2.days.from_now,
                                         check_out_date: 12.days.from_now, guests:1)

      expect(pr.total).to eq 1600.00
    end
    it 'calculate total with two custom price range' do
      host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
      address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                city:'São Paulo', state:'SP', cep:'15470-000')
      inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                            phone:'556618', email:'pousadinha@email.com', address:address)
      room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                              varanda com vista para a praia', double_beds:1, single_beds:0, 
                              capacity:2, price:100.00, bathrooms:1, kitchen:false)
      room.custom_dates.build(begin:1.days.from_now, end:7.days.from_now, price:200)
      room.custom_dates.build(begin:10.days.from_now, end:17.days.from_now, price:300)
      pr = room.pre_reservations.create!(check_in_date: 2.days.from_now, 
                                         check_out_date: 12.days.from_now, guests:1)

      expect(pr.total).to eq 2000.00
    end
  end
end
