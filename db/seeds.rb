#customers
cjose = Customer.create!(name: 'José', cpf: '86599954651', email: 'jose@email.com', password: '123456')
cmaria = Customer.create!(name: 'Maria', cpf: '78945612301', email: 'maria@email.com', password: 'password123')
ccarlos = Customer.create!(name: 'Carlos', cpf: '32165498702', email: 'carlos@email.com', password: 'securepass')
cana = Customer.create!(name: 'Ana', cpf: '65498732103', email: 'ana@email.com', password: 'abc123')
cpedro = Customer.create!(name: 'Pedro', cpf: '98765432104', email: 'pedro@email.com', password: 'pass123')
cmariana = Customer.create!(name: 'Mariana', cpf: '45678901205', email: 'mariana@email.com', password: 'mariana_pass')
clucas = Customer.create!(name: 'Lucas', cpf: '12378945606', email: 'lucas@email.com', password: 'lucaspass')
ccamila = Customer.create!(name: 'Camila', cpf: '98701234507', email: 'camila@email.com', password: 'camila_pass')
cfelipe = Customer.create!(name: 'Felipe', cpf: '45601278908', email: 'felipe@email.com', password: 'felipepass')
cjulia = Customer.create!(name: 'Julia', cpf: '78901234509', email: 'julia@email.com', password: 'juliapass')

#address
pr = Address.create!(street: 'Rua das Flores', number: '123', neighborhood: 'Jardim Botânico',
                city: 'Curitiba', state: 'PR', cep: '80010-010')

sp = Address.create!(street: 'Avenida Paulista', number: '789', neighborhood: 'Bela Vista',
                city: 'São Paulo', state: 'SP', cep: '01310-100')

bh = Address.create!(street: 'Praça da Liberdade', number: '456', neighborhood: 'Liberdade',
                city: 'Belo Horizonte', state: 'MG', cep: '30140-010')

rj = Address.create!(street: 'Rua do Comércio', number: '101', neighborhood: 'Centro',
                city: 'Rio de Janeiro', state: 'RJ', cep: '20010-120')

ce = Address.create!(street: 'Avenida Beira-Mar', number: '234', neighborhood: 'Praia de Iracema',
                city: 'Fortaleza', state: 'CE', cep: '60165-120')

#host
hroberto = User.create!(name: 'Roberto', email: 'robertoh@email.com', password: 'password')

halice = User.create!(name: 'Alice', email: 'aliceh@email.com', password: 'securepass')

hcarlos = User.create!(name: 'Carlos', email: 'carlosh@email.com', password: 'abc123')

hjulia = User.create!(name: 'Julia', email: 'juliah@email.com', password: 'pass123')

hmariana = User.create!(name: 'Mariana', email: 'marianah@email.com', password: 'mariana_pass')


#inn
pousada_jabaquara = hroberto.create_inn!(name: 'Pousada Jabaquara', company_name: 'Pousada Jabaquara SN',
                       cnpj: '44046459000100',phone: '11955462859', email: 'pousadajabaquara@email.com',
                       address: sp, pix: true, debit: true, credit: true, cash: true, pets: true,
                       policies: 'Proibido fumar')

hotel_central = halice.create_inn!(name: 'Hotel Central', company_name: 'Central Hotels Ltda.',
                       cnpj: '12345678000199',phone: '1187654321', email: 'hotelcentral@email.com',
                       address: pr, pix: true, debit: true, credit: true, cash: true, pets: false,
                       policies: 'Sem barulho: 10pm-6am')

resort_paradise = hcarlos.create_inn!(name: 'Resort Paradise', company_name: 'Paradise Resorts S/A',
                       cnpj: '98765432000101', phone: '1143215678', email: 'resortparadise@email.com',
                       address: rj, pix: true, debit: true, credit: true, cash: true, pets: true,
                       policies: 'Lugar família')

cottage_retreat = hjulia.create_inn!(name: 'Cottage Retreat', company_name: 'Cottage Retreats Inc.',
                       cnpj: '11223344000100', phone: '1155544332', email: 'cottageretreat@email.com',
                       address: bh, pix: true, debit: true, credit: true, cash: true, pets: true,
                       policies: 'Check-in depois das 14:00')

beachfront_villa = hmariana.create_inn!(name: 'Beachfront Villa', company_name: 'Villa Escapes Ltd.',
                       cnpj: '99887766000100', phone: '1133669955', email: 'villaescapes@email.com',
                       address: ce, pix: true, debit: true, credit: true, cash: true, pets: false,
                       policies: 'Sem festas')
                       
#rooms
pj101 = pousada_jabaquara.rooms.create!(number: '101', description: 'Ótimo quarto com uma cama de casal, com TV',
                       double_beds: 1, single_beds: 0, capacity: 2, price: 100.00, bathrooms: 1,
                       kitchen: false, dimension: '13', air: false, tv: true, wardrobe: true,
                       balcony: true, safe: true, accessible: false)
                       
pj201 = pousada_jabaquara.rooms.create!(number: '201', description: 'Quarto confortável com três camas de solteiro',
                       double_beds: 0, single_beds: 3, capacity: 3, price: 80.00, bathrooms: 1,
                       kitchen: false, dimension: '15', air: true, tv: true, wardrobe: true,
                       balcony: false, safe: false, accessible: true)

pj301 = pousada_jabaquara.rooms.create!(number: '301', description: 'Suíte elegante com cama king-size e vista para o jardim',
                       double_beds: 1, single_beds: 0, capacity: 2, price: 120.00, bathrooms: 1,
                       kitchen: false, dimension: '18', air: true, tv: true, wardrobe: true,
                       balcony: true, safe: true, accessible: false)

hc102 = hotel_central.rooms.create!(number: '102', description: 'Suite luxuosa com cama king-size e vista para a cidade',
                            double_beds: 1, single_beds: 2, capacity: 4, price: 150.00, bathrooms: 2,
                            kitchen: true, dimension: '20', air: true, tv: true, wardrobe: true,
                            balcony: true, safe: true, accessible: false)

hc202 = hotel_central.rooms.create!(number: '202', description: 'Quarto aconchegante com cama de casal e banheiro privativo',
                            double_beds: 1, single_beds: 0, capacity: 2, price: 120.00, bathrooms: 1,
                            kitchen: false, dimension: '18', air: true, tv: true, wardrobe: true,
                            balcony: false, safe: false, accessible: false)
hc302 = hotel_central.rooms.create!(number: '302', description: 'Quarto moderno com duas camas de solteiro e decoração contemporânea',
                            double_beds: 0, single_beds: 2, capacity: 2, price: 90.00, bathrooms: 1,
                            kitchen: false, dimension: '16', air: true, tv: true, wardrobe: true,
                            balcony: false, safe: false, accessible: true)

rp103 = resort_paradise.rooms.create!(number: '103', description: 'Suíte familiar com duas camas de casal e vista para a piscina',
                              double_beds: 2, single_beds: 1, capacity: 5, price: 200.00, bathrooms: 2,
                              kitchen: true, dimension: '25', air: true, tv: true, wardrobe: true,
                              balcony: true, safe: true, accessible: true)

rp203 = resort_paradise.rooms.create!(number: '203', description: 'Quarto standard com cama de casal e decoração tropical',
                              double_beds: 1, single_beds: 0, capacity: 2, price: 130.00, bathrooms: 1,
                              kitchen: false, dimension: '16', air: true, tv: true, wardrobe: true,
                              balcony: false, safe: false, accessible: false)
rp303 = resort_paradise.rooms.create!(number: '303', description: 'Suíte de luxo com cama queen-size e banheira de hidromassagem',
                              double_beds: 1, single_beds: 0, capacity: 2, price: 220.00, bathrooms: 1,
                              kitchen: true, dimension: '22', air: true, tv: true, wardrobe: true,
                              balcony: true, safe: true, accessible: true)

ct104 = cottage_retreat.rooms.create!(number: '104', description: 'Cabana privativa com cama queen-size e lareira',
                              double_beds: 1, single_beds: 0, capacity: 2, price: 180.00, bathrooms: 1,
                              kitchen: true, dimension: '22', air: false, tv: true, wardrobe: true,
                              balcony: true, safe: true, accessible: false)

ct204 = cottage_retreat.rooms.create!(number: '204', description: 'Quarto acolhedor com cama de casal e banheira de hidromassagem',
                              double_beds: 1, single_beds: 0, capacity: 2, price: 160.00, bathrooms: 1,
                              kitchen: false, dimension: '20', air: true, tv: true, wardrobe: true,
                              balcony: false, safe: false, accessible: false)
ct304 = cottage_retreat.rooms.create!(number: '304', description: 'Cabana rústica com cama de casal e lareira a lenha',
                              double_beds: 1, single_beds: 0, capacity: 2, price: 160.00, bathrooms: 1,
                              kitchen: true, dimension: '20', air: false, tv: true, wardrobe: true,
                              balcony: true, safe: true, accessible: false)

bv105 = beachfront_villa.rooms.create!(number: '105', description: 'Suíte à beira-mar com cama king-size e varanda privativa',
                               double_beds: 1, single_beds: 1, capacity: 3, price: 250.00, bathrooms: 2,
                               kitchen: true, dimension: '28', air: true, tv: true, wardrobe: true,
                               balcony: true, safe: true, accessible: true)

bv205 = beachfront_villa.rooms.create!(number: '205', description: 'Quarto com vista para o oceano e cama queen-size',
                               double_beds: 1, single_beds: 0, capacity: 2, price: 200.00, bathrooms: 1,
                               kitchen: false, dimension: '24', air: true, tv: true, wardrobe: true,
                               balcony: true, safe: false, accessible: false)
bv305 = beachfront_villa.rooms.create!(number: '306', description: 'Suíte exclusiva à beira-mar com cama king-size e piscina privativa',
                              double_beds: 1, single_beds: 1, capacity: 3, price: 300.00, bathrooms: 2,
                              kitchen: true, dimension: '30', air: true, tv: true, wardrobe: true,
                              balcony: true, safe: true, accessible: true)


#Custom Prices
pj101.custom_dates.create!(begin: Time.zone.now, end: 15.days.from_now, price: 150.00)
pj101.custom_dates.create!(begin: 16.days.from_now, end: 2.months.from_now, price: 200.00)
pj201.custom_dates.create!(begin: Time.zone.now, end: 15.days.from_now, price: 200.00)
pj201.custom_dates.create!(begin: 16.days.from_now, end: 2.months.from_now, price: 250.00)
pj301.custom_dates.create!(begin: Time.zone.now, end: 15.days.from_now, price: 300.00)
pj301.custom_dates.create!(begin: 16.days.from_now, end: 2.months.from_now, price: 320.00)

hc202.custom_dates.create!(begin: Time.zone.now, end: 20.days.from_now, price: 180.00)

rp203.custom_dates.create!(begin: Time.zone.now, end: 25.days.from_now, price: 220.00)
rp203.custom_dates.create!(begin: 26.days.from_now, end: 4.months.from_now, price: 300.00)

bv305.custom_dates.create!(begin: Time.zone.now, end: 35.days.from_now, price: 250.00)
bv305.custom_dates.create!(begin: 36.days.from_now, end: 6.months.from_now, price: 350.00)

#Reservations
pj101.reservations.create!(check_in_date: 8.days.from_now, check_out_date: 12.days.from_now, guests: 2, customer: cjose)
pj101.reservations.create!(check_in_date: 20.days.from_now, check_out_date: 25.days.from_now, guests: 2, customer: cmaria)
pj301.reservations.create!(check_in_date: 5.days.from_now, check_out_date: 8.days.from_now, guests: 2, customer: ccarlos)
pj201.reservations.create!(check_in_date: 12.days.from_now, check_out_date: 18.days.from_now, guests: 3, customer: cana)

hc102.reservations.create!(check_in_date: 12.days.from_now, check_out_date: 16.days.from_now, guests: 1, customer: ccarlos)
hc202.reservations.create!(check_in_date: 30.days.from_now, check_out_date: 35.days.from_now, guests: 2, customer: cana)
hc102.reservations.create!(check_in_date: 10.days.from_now, check_out_date: 15.days.from_now, guests: 2, customer: clucas)
hc102.reservations.create!(check_in_date: 22.days.from_now, check_out_date: 28.days.from_now, guests: 4, customer: cjose)

rp203.reservations.create!(check_in_date: 10.days.from_now, check_out_date: 15.days.from_now, guests: 2, customer: cpedro)
rp103.reservations.create!(check_in_date: 28.days.from_now, check_out_date: 32.days.from_now, guests: 4, customer: cmariana)
rp203.reservations.create!(check_in_date: 18.days.from_now, check_out_date: 22.days.from_now, guests: 1, customer: ccarlos)
rp203.reservations.create!(check_in_date: 25.days.from_now, check_out_date: 30.days.from_now, guests: 2, customer: ccamila)

ct304.reservations.create!(check_in_date: 15.days.from_now, check_out_date: 20.days.from_now, guests: 1, customer: clucas)
ct304.reservations.create!(check_in_date: 25.days.from_now, check_out_date: 30.days.from_now, guests: 2, customer: ccamila)
ct304.reservations.create!(check_in_date: 15.days.from_now, check_out_date: 20.days.from_now, guests: 2, customer: cana)

bv205.reservations.create!(check_in_date: 18.days.from_now, check_out_date: 22.days.from_now, guests: 2, customer: cfelipe)
bv305.reservations.create!(check_in_date: 35.days.from_now, check_out_date: 40.days.from_now, guests: 1, customer: cjulia)
bv305.reservations.create!(check_in_date: 20.days.from_now, check_out_date: 25.days.from_now, guests: 2, customer: cpedro)
bv305.reservations.create!(check_in_date: 35.days.from_now, check_out_date: 40.days.from_now, guests: 1, customer: cmariana)
bv305.reservations.create!(check_in_date: 25.days.from_now, check_out_date: 30.days.from_now, guests: 3, customer: cmaria)


pj301.reservations.create!(check_out_date: 5.days.ago, check_in_date: 8.days.ago, guests: 2,
                           customer: ccarlos, status:"completed")
bv305.reservations.create!(check_out_date: 20.days.ago, check_in_date: 25.days.ago, guests: 2,
                           customer: cpedro, status:"completed")
rp203.reservations.create!(check_out_date: 18.days.ago, check_in_date: 22.days.ago, guests: 1,
                           customer: ccarlos, status:"completed")
ct304.reservations.create!(check_out_date: 25.days.ago, check_in_date: 30.days.ago, guests: 2,
                           customer: ccamila, status:"completed")
                           
rp103.reservations.create!(check_out_date: 28.days.ago, check_in_date: 32.days.ago, guests: 4,
                           customer: cmariana, status:"cancelled")
hc102.reservations.create!(check_in_date: 10.days.from_now, check_out_date: 15.days.from_now, guests: 2,
                           customer: clucas, status:"cancelled")

                           
bv205.reservations.create!(check_in_date: 1.days.ago, check_out_date: 12.days.from_now,
                           guests: 2, customer: cpedro, status:"ongoing")
bv305.reservations.create!(check_in_date: 5.days.ago, check_out_date: 5.days.from_now,
                           guests: 1, customer: cmariana, status:"ongoing")
rp103.reservations.create!(check_in_date: 3.days.ago, check_out_date: 2.days.from_now,
                           guests: 1, customer: ccarlos, status:"ongoing")
rp203.reservations.create!(check_in_date: 3.days.ago, check_out_date: 1.days.from_now,
                           guests: 2, customer: cmaria, status:"ongoing")
ct304.reservations.create!(check_in_date: 10.days.ago, check_out_date: 1.days.from_now,
                           guests: 2, customer: ccamila, status:"ongoing")
pj101.reservations.create!(check_in_date: 2.days.ago, check_out_date: 1.days.from_now,
                           guests: 2, customer: cmaria, status:"ongoing")