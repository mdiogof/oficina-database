show databases;
use oficina;
-- popular o banco de dados Oficina

select * from clients;
INSERT INTO clients (clientName, CPF, Phone) VALUES
	('Carlos Henrique Souza', '12345678901', '15991234567'),
	('Mariana Oliveira Lima', '23456789012', '15992345678'),
	('Rafael Andrade Costa', '34567890123', '15993456789'),
	('Fernanda Rocha Alves', '45678901234', '15994567890'),
	('Lucas Pereira Martins', '56789012345', '15995678901');

select * from vehicles;
INSERT INTO vehicles (idClient, Plate, Model, Brand, releaseYear) VALUES
	(1, 'ABC1D23', 'Civic', 'Honda', 2018),
	(1, 'DEF4G56', 'CG 160', 'Honda', 2021),
	(2, 'GHI7J89', 'Corolla', 'Toyota', 2020),
	(3, 'JKL0M12', 'Onix', 'Chevrolet', 2019),
	(4, 'NOP3Q45', 'HB20', 'Hyundai', 2022),
	(5, 'RST6U78', 'Gol', 'Volkswagen', 2016);

select * from employees;
INSERT INTO employees (employeeName, employeePosition, Phone, Salary) VALUES
	('João Paulo Ribeiro', 'Mecânico', '15981112222', 2800.00),
	('Ana Carolina Mendes', 'Atendente', '15982223333', 2000.00),
	('Bruno Ferreira Lopes', 'Mecânico', '15983334444', 3000.00),
	('Patrícia Gomes Silva', 'Gerente', '15984445555', 4500.00),
	('Ricardo Alves Nogueira', 'Auxiliar Mecânico', '15985556666', 1800.00);

select * from statusSO;
INSERT INTO statusSO (statusDescription) VALUES
	('Aberta'),
	('Em andamento'),
	('Aguardando peça'),
	('Finalizada'),
	('Cancelada');

select * from serviceOrder;
INSERT INTO serviceOrder (idVehicle, idEmployee, idStatus, openingDate, closingDate) VALUES
	(1, 1, 2, '2025-01-10', NULL),
	(3, 3, 3, '2025-01-08', NULL),
	(4, 1, 4, '2025-01-02', '2025-01-05'),
	(2, 5, 1, '2025-01-12', NULL),
	(6, 4, 5, '2025-01-03', '2025-01-04');

select * from orders;
INSERT INTO orders (idSO, orderDescription, totalValue, orderDate) VALUES
	(3, 'Revisão completa e troca de óleo', 450.00, '2025-01-05'),
	(1, 'Manutenção preventiva e diagnóstico', 300.00, '2025-01-10'),
	(2, 'Substituição de pastilhas de freio', 180.00, '2025-01-08');

select * from partnerships;
INSERT INTO partnerships (partnerName, Phone, Localization, partType) VALUES
	('Auto Peças Central', '15990001111', 'Sorocaba - SP', 'Car'),
	('Moto Peças Speed', '15990002222', 'Votorantim - SP', 'Motorcycle'),
	('Distribuidora São Jorge', '15990003333', 'Itu - SP', 'Car'),
	('Garage Parts', '15990004444', 'Sorocaba - SP', 'Motorcycle');

select * from stock;
INSERT INTO stock (idPartner, partName, availableQuantity, partValue, partType) VALUES
	(1, 'Filtro de óleo', 50, 35.00, 'Car'),
	(1, 'Pastilha de freio', 30, 120.00, 'Car'),
	(3, 'Correia dentada', 20, 180.00, 'Car'),
	(3, 'Velas de ignição', 40, 25.00, 'Car'),
	(2, 'Filtro de ar', 25, 45.00, 'Motorcycle'),
	(2, 'Kit relação', 15, 350.00, 'Motorcycle'),
	(4, 'Pastilha de freio moto', 20, 95.00, 'Motorcycle'),
	(4, 'Cabo de embreagem', 18, 60.00, 'Motorcycle');

select * from order_part;
INSERT INTO order_part (idOrder, idPart, Quantity, unitValue) VALUES
	(1, 1, 1, 35.00),
	(1, 4, 4, 25.00),
	(2, 3, 1, 180.00),
	(2, 1, 1, 35.00), 
	(3, 2, 1, 120.00); 

select * from soHistoric;
INSERT INTO soHistoric (idSO, idStatus, alterationDate, Observation) VALUES
	(1, 1, '2026-01-20', 'Ordem de serviço criada'),
	(1, 2, '2026-01-20', 'Veículo encaminhado para revisão'),
	(1, 4, '2026-01-20', 'Serviço finalizado com sucesso'),
	(2, 1, '2026-01-21', 'Abertura da ordem de serviço'),
	(2, 3, '2026-01-21', 'Aguardando chegada da correia dentada'),
	(2, 2, '2026-01-22', 'Peça recebida, serviço retomado'),
	(2, 4, '2026-01-22', 'Manutenção concluída'),
	(3, 1, '2026-01-23', 'OS aberta para troca de pastilhas'),
	(3, 2, '2026-01-23', 'Troca de pastilhas iniciada'),
	(3, 4, '2026-01-23', 'Serviço finalizado');

select * from payments;
INSERT INTO payments (idOrder, paymentType, paymentValue, paymentStatus, paymentDate) VALUES
	(1, 'PIX', 350.00, 'Pago', '2026-01-20 17:10:00'),
	(2, default, 780.00, 'Em aberto', NULL),
	(3, 'Dinheiro', 220.00, 'Pago', '2026-01-22 15:00:00');
