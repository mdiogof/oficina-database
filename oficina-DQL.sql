show databases;
use oficina;
-- realizar consultas usando o banco de dados Oficina

-- qual o total recebido por tipo de pagamento?
SELECT paymentType, SUM(paymentValue) as totalValue
	FROM payments
	WHERE paymentStatus = 'Pago'
	GROUP BY paymentType;
    
-- quais são os status dos pedidos?
select idVehicle, orderDate, orderDescription, totalValue, statusDescription
	from serviceOrder
    join orders using (idSO)
    join statusSO using (idStatus);


-- qual a quantidade de clientes que possuem carros?
-- stock > order_part > orders > serviceOrder > vehicles > clients
select count(distinct idClient) as clients_with_cars from stock s
	join order_part op using (idPart)
    join orders o using (idOrder)
    join serviceOrder so using (idSO)
    join vehicles v using (idVehicle)
    join clients c using (idClient)
    where s.partType = 'Car';
    
-- o valor médio das peças em estoque ultrapassa o limite de 100 reais?
select round(AVG(partValue), 2) as avg_value, partType from stock
	group by partType
    having avg_value > 100;