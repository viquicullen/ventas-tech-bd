use ventas_tech_db


--consulta 1: resumen ejecutivo Mensual--
 select * from ventas;
 
 Select
 month(fecha_venta) as Mes, 
 sum(cantidad*precio_unitario) AS Total_Facturado,
 AVG(cantidad*precio_unitario) AS ticket_promedio,
 count(id_venta) as cantidad_de_pedidos
 from ventas
 group by fecha_venta;

 --consulta 2 Ranking de productos--
 
  select top 5 
  id_producto,
  SUM (cantidad)AS unidades_vendidas,
  SUM (cantidad*precio_unitario) AS Total_facturado
  FROM Ventas
  group by id_producto
  order by Total_facturado DESC;

  -- consulta 3 Clientes recurrentes --
  select
  id_cliente,
  count(id_venta) AS cantitad_pedidos,
  sum(cantidad*precio_unitario) AS total_Gastado
  from Ventas
  group by id_cliente
  having count(id_venta)>1
  order by total_gastado DESC;


  --consulta 4 Meses encima/debajo del promedio--
with facturacion_mensual AS (
select 
Month(fecha_venta) As Mes, 
SUM(cantidad*precio_unitario) AS total_Mensual
from ventas
group by month(fecha_venta)
)
select
mes, 
total_mensual,
case 
when total_mensual >(Select AVG (total_Mensual) from facturacion_mensual)
then 'por encima'
else ' por de bajo'
end as comparativa_promedio
from facturacion_mensual
order by mes;


--hallazgos--

-- el cliente 1 concentra mas del 40% del total facturado--
-- si bien el producto que mas cantidad de veces se vendio fue el 2, el producto 1 fue con el que mas se recaudó--
--el mes en el que mas se vendió es marzo--

 
