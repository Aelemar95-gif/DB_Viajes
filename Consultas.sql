
USE Viajes2025_Grupo2;

--1 - Listado de pasajeros de nacionalidad “argentina”, ordenados por DNI. 
--Mostrar nombre y apellido (en una misma columna), DNI y edad.

SELECT 
    CONCAT(p.nombre, ' ', p.apellido) AS NombreCompleto,
    p.dni,
    DATEDIFF(YEAR, p.fecha_nacimiento, GETDATE()) AS Edad,
	p.nacionalidad
FROM PASajero P
WHERE p.nacionalidad = 'Argentina'
ORDER BY p.dni;

--2 - Listado de reservAS pagadAS con tarjeta de “débito” o de “crédito”, ordenadAS por fecha de reserva. 
--Mostrar el ID de la reserva, el nombre y email del usuario, y el medio de pago.

SELECT 
    R.id AS ID_Reserva,
    U.mail AS Email,
    CONCAT (U.nombre, ' ', U.apellido) AS NombreUsuario,
    MP.tipo AS MedioPago,
    R.fecha_reserva
FROM Reserva R
INNER JOIN Usuario U ON R.usuario_id = U.id
INNER JOIN Medio_pago MP ON R.medio_pago_reserva = MP.id
WHERE MP.tipo LIKE '%crédito%'
   OR MP.tipo LIKE '%débito%'
ORDER BY R.fecha_reserva;

--3 - Listado de viajes con origen o destino en Buenos Aires. 
--Mostrar nombre de la ciudad de origen, ciudad de destino, fechAS de salida y 
--llegada en formato día/mes/año hora:minuto, y precio.

SELECT 
        v.id,
        FORMAT (v.Salida, 'dd/MM/yyyy HH:mm') AS FechaSalida,
        FORMAT (v.llegada, 'dd/MM/yyyy HH:mm') AS FechaLlegada,
        CONCAT (CO.ciudad, ', ',CO.provincia) AS Origen,
        CONCAT (CD.ciudad, ', ',CD.provincia) AS Destino

FROM Viaje V
INNER JOIN Ciudad CO ON v.origen = CO.id
INNER JOIN Ciudad CD ON v.destino = CD.id
WHERE CO.provincia LIKE '%Buenos%% %Aires%'
OR CD.provincia LIKE '%Buenos%% %Aires%';

--4 - Precio promedio, mínimo y máximo de los viajes.

SELECT 
        AVG (v.precio) AS PromedioViajes,
        MAX (v.precio) AS MaximoViajes,
        MIN (v.precio) AS MinimoViajes
    
FROM Viaje V;

--5 - Listado de medios de pago y la cantidad de reservAS realizadAS con cada medio, 
--ordenados alfabéticamente por medio de pago. Mostrar solo los medios de pago con más de 1 reserva.

SELECT 
    MP.tipo AS MedioPago,
    COUNT(R.id) AS CantidadReservas
FROM Medio_pago MP
INNER JOIN Reserva R ON MP.id = R.medio_pago_reserva
GROUP BY MP.tipo
HAVING COUNT(R.id) > 1
ORDER BY MP.tipo;

--6 - Crear una view en la base de datos llamada “MicrosSemicamaView” que devuelva un listadode todos los viajes realizados
--por micros con asientos Semi-cama. 
--Mostrar: Patente del micro, capacidad, fecha de salida del viaje, ciudad de origen y ciudad de destino.

CREATE VIEW MicrosSemicamaView AS
SELECT 
    V.id AS IdViaje,
    M.patente AS PatenteMicro,
    M.capacidad AS CapacidadMicro,
    V.Salida AS FechaSalida,
    C1.ciudad AS CiudadOrigen,
    C2.ciudad AS CiudadDestino,
    TA.tipo AS TipoAsiento
FROM Viaje V
INNER JOIN Micro M ON V.id_micro = M.id
INNER JOIN Tipo_asiento TA ON M.id_tipo_asiento = TA.id
INNER JOIN Ciudad C1 ON V.origen = C1.id
INNER JOIN Ciudad C2 ON V.destino = C2.id
WHERE TA.tipo = 'Semicama';

--7 - Realizar una consulta sobre la view anterior y mostrar solamente el último viaje realizado (el más reciente).

SELECT TOP (1) MSV.IdViaje,
      MSV.PatenteMicro,
      MSV.CapacidadMicro,
      FORMAT (MSV.FechaSalida, 'dd/MM/yyyy HH:mm') AS Salida,
      MSV.CiudadOrigen,
      MSV.CiudadDestino,
      MSV.TipoAsiento
  FROM MicrosSemicamaView MSV
  ORDER BY MSV.FechaSalida DESC
