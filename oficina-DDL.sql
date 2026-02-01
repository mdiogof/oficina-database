show databases;
create database oficina;
use oficina;
-- criar tabelas de acordo com o ER e adicionar checks

create table clients(
	idClient INT auto_increment,
    clientName VARCHAR(255) NOT NULL,
    CPF CHAR(11),
    Phone CHAR(11),
	PRIMARY KEY (idClient),
    constraint uq_cpf UNIQUE (CPF),
    constraint uq_phone UNIQUE (Phone)
);
alter table clients auto_increment=1;

create table vehicles(
	idVehicle INT auto_increment,
    idClient INT,
    Plate CHAR(7),
    Model VARCHAR(45) NOT NULL,
    Brand VARCHAR(45),
	releaseYear INT,
    PRIMARY KEY (idVehicle),
    constraint fk_vehicle_client FOREIGN KEY (idClient) REFERENCES clients(idClient)
		on update cascade
        on delete restrict,
    constraint uq_plate UNIQUE (Plate)
);
alter table vehicles auto_increment=1;
alter table vehicles
	add constraint chk_releaseYear CHECK (releaseYear >= 1980);

create table employees(
	idEmployee INT auto_increment,
    employeeName VARCHAR(255) NOT NULL,
    employeePosition VARCHAR(45) NOT NULL,
    Phone CHAR(11),
    Salary DECIMAL(10,2),
    PRIMARY KEY (idEmployee),
    constraint uq_phone UNIQUE (Phone)
);
alter table employees auto_increment=1;
alter table employees
	add constraint chk_salary CHECK (Salary >= 1518.00);

create table statusSO(
	idStatus INT auto_increment,
    statusDescription VARCHAR(45) NOT NULL,
    PRIMARY KEY (idStatus)
);
alter table statusSO auto_increment=1;

create table serviceOrder(
	idSO INT auto_increment,
    idVehicle INT NOT NULL,
    idEmployee INT NOT NULL,
    idStatus INT NOT NULL,
    openingDate DATE NOT NULL,
    closingDate DATE,
    PRIMARY KEY (idSO),
    constraint fk_so_vehicle FOREIGN KEY (idVehicle) REFERENCES vehicles(idVehicle)
		on update cascade
        on delete restrict,
    constraint fk_so_employee FOREIGN KEY (idEmployee) REFERENCES employees(idEmployee)
		on update cascade
        on delete restrict,
    constraint fk_so_status FOREIGN KEY (idStatus) REFERENCES statusSO(idStatus)
		on update cascade
        on delete restrict
);
alter table serviceOrder auto_increment=1;
alter table serviceOrder
	add constraint chk_date CHECK (closingDate IS NULL OR closingDate >= openingDate);

create table orders(
	idOrder INT auto_increment,
    idSO INT NOT NULL,
    orderDescription VARCHAR(255) NOT NULL,
    totalValue DECIMAL(10,2),
    orderDate DATE,
    PRIMARY KEY (idOrder),
    constraint fk_orders_so FOREIGN KEY (idSO) REFERENCES serviceOrder(idSO)
		on update cascade
        on delete cascade
);
alter table orders auto_increment=1;
alter table orders
	add constraint chk_value CHECK (totalValue >= 0);

create table partnerships(
	idPartner INT auto_increment,
    partnerName VARCHAR(255),
    Phone CHAR(11),
    Localization VARCHAR(255),
    partType ENUM('Car','Motorcycle'),
    PRIMARY KEY (idPartner)
);
alter table partnerships auto_increment=1;

create table stock(
	idPart INT auto_increment,
    idPartner INT NOT NULL,
    partName VARCHAR(45),
    availableQuantity INT,
    partValue DECIMAL(10,2),
    partType ENUM('Car','Motorcycle'),
    PRIMARY KEY (idPart),
    constraint uq_partName UNIQUE (partName),
    constraint fk_stock_partnership FOREIGN KEY (idPartner) REFERENCES partnerships(idPartner)
		on update cascade
        on delete restrict
);
alter table stock auto_increment=1;
alter table stock
	add constraint chk_stock_quantity CHECK (availableQuantity >= 0);

create table order_part(
	idOrder INT NOT NULL,
    idPart INT NOT NULL,
    Quantity INT,
    unitValue DECIMAL(10,2),
    PRIMARY KEY (idOrder,idPart),
	constraint fk_order_order FOREIGN KEY (idOrder) REFERENCES orders(idOrder)
		on update cascade
        on delete cascade,
    constraint fk_order_part FOREIGN KEY (idPart) REFERENCES stock(idPart)
		on update cascade
        on delete restrict
);
alter table order_part
	add constraint chk_quantity CHECK (Quantity > 0);

create table soHistoric(
	idHistoric INT auto_increment,
    idSO INT NOT NULL,
    idStatus INT NOT NULL,
    alterationDate DATE,
    Observation VARCHAR(45),
    PRIMARY KEY (idHistoric),
    constraint fk_historic_so FOREIGN KEY (idSO) REFERENCES serviceOrder(idSO)
		on update cascade
        on delete restrict,
    constraint fk_historic_status FOREIGN KEY (idStatus) REFERENCES statusSO(idStatus)
		on update cascade
        on delete restrict
);
alter table soHistoric auto_increment=1;

create table payments(
	idPayment INT auto_increment,
    idOrder INT NOT NULL,
    paymentValue DECIMAL(10,2) NOT NULL,
    paymentType ENUM('Cartão','PIX','Dinheiro'),
    paymentStatus ENUM('Pago','Em aberto'),
    PRIMARY KEY (idPayment),
    constraint fk_payment_order FOREIGN KEY (idOrder) REFERENCES orders(idOrder)
		on update cascade
        on delete cascade
);
alter table payments auto_increment=1;
show tables;
alter table payments
	add constraint chk_paymentValue CHECK (paymentValue > 0),
    modify column paymentType ENUM('Cartão','PIX','Dinheiro') default 'Cartão',
    modify column paymentStatus ENUM('Pago','Em aberto') default 'Em aberto';
alter table payments
	add column paymentDate DATETIME;