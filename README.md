# Sistema de Gestión de Reservas de Transporte

## Descripción
Este proyecto es un **sistema de gestión de viajes y reservas** para una empresa de transporte de larga distancia, desarrollado durante una pasantía. La base de datos está implementada en **Microsoft SQL Server** y permite administrar micros, tipos de asientos, viajes, usuarios, reservas, pasajeros y medios de pago.

El sistema incluye:
- Diseño relacional completo de la base de datos.
- Consultas de ejemplo para listar reservas, pasajeros, viajes y medios de pago.
- Vistas para facilitar la visualización de datos, como viajes realizados por micros con asientos semi-cama.

## Modelo de Datos
El modelo relacional incluye las siguientes tablas principales:

- **Micro**: Información de los micros, capacidad y empresa.
- **Tipo_asiento**: Tipo de asiento de cada micro (cama, semi-cama, ejecutivo).
- **Viaje**: Viajes programados entre ciudades, con fechas, precios y micro asignado.
- **Usuario**: Usuarios registrados para realizar reservas.
- **Reserva**: Reservas realizadas por usuarios para uno o más pasajeros.
- **Pasajero**: Datos personales de los pasajeros.
- **Medio_pago**: Medios de pago disponibles (tarjeta de débito, crédito, Mercado Pago, Rapipago).
- **Ciudad**: Ciudades de origen y destino.
- **Reserva_pasajero**: Relación entre reservas y pasajeros, asignando número de asiento.

## Consultas de Ejemplo
Algunas consultas implementadas:

- Listado de reservas pagadas con tarjeta de débito o crédito, ordenadas por fecha de reserva.
- Edad de los pasajeros a partir de su fecha de nacimiento.
- Conteo de reservas por medio de pago.
- Vista `MicrosSemicamaView` para viajes realizados por micros con asientos semi-cama.
- Último viaje realizado por tipo de asiento.
