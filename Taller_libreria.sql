--Parte 1: Creación de la Base de Datos y Esquemas

-- 1. CREACION DE LA BASE DE DATOS

CREATE DATABASE libreria

USE libreria

-- 2 ESQUEMAS

CREATE SCHEMA Catalogo
GO

CREATE SCHEMA Ventas
GO

-- Parte 2: Creación de Tablas

CREATE TABLE  Catalogo.Autores
(
	AutorID INT IDENTITY,
	Nombre VARCHAR(100),
	Apellido VARCHAR(100),
	CONSTRAINT PK_Autor_ID PRIMARY KEY(AutorID)
)

CREATE TABLE  Catalogo.Libros 
(
	LibroID INT IDENTITY,
	Titulo NVARCHAR(200),
	AutorID INT,
	CategoriaID INT,
	Precio MONEY,
	CONSTRAINT FK_Autor_ID_CON_Autor_ID_Autores FOREIGN KEY(AutorID)
	REFERENCES Catalogo.Autores(AutorID)
)


CREATE TABLE Catalogo.Categorias
(
	CategoriaID INT IDENTITY PRIMARY KEY,
	Nombre NVARCHAR(300) UNIQUE NOT NULL,
	
	)


--  RELACION 1

ALTER TABLE Catalogo.Libros 
ADD CONSTRAINT FK_Categoria_ID_CON_Categoria_ID_Categorias FOREIGN KEY (CategoriaID)
	REFERENCES Catalogo.Categorias (CategoriaID)



CREATE TABLE Ventas.Clientes
(
	ClienteID INT IDENTITY,
	Nombre VARCHAR(200),
	Apellido VARCHAR(100),
	Correo NVARCHAR(300) UNIQUE NOT NULL,
	CONSTRAINT PK_Cliente_ID PRIMARY KEY(ClienteID)
)



CREATE TABLE Ventas.Ventas
(
	VentaID INT IDENTITY PRIMARY KEY,
	ClienteID INT,
	FechaVenta DATE,
	CONSTRAINT FK_Cliente_ID_CON_Cliente_ID_Clientes FOREIGN KEY(ClienteID)
	REFERENCES Ventas.Clientes(ClienteID)
)

CREATE TABLE Ventas.DetalleVentas
(
	DetalleID INT IDENTITY,
	VentaID INT,
	LibroID INT,
	Cantidad FLOAT,
	PrecioVenta MONEY,
)
-- RELACION 2

ALTER TABLE Ventas.Ventas ---- PENIDNETE PREGUNTAR
ADD CONSTRAINT FK_Venta_ID_CON_Venta_ID_DetalleVentas FOREIGN KEY(VentaID)
	REFERENCES Ventas.DetalleVentas(VentaID)


	--Modificaciones
-- Insertar columnas

ALTER TABLE Catalogo.Categorias
ADD Estado VARCHAR(100)

select*from Catalogo.Categorias

ALTER TABLE Ventas.Ventas
ADD Metodo_pago VARCHAR(120)

select*from Ventas.Ventas

-- Modificar Nombres de columnas

EXEC sp_rename 'esquema.nombre_de_tu_tabla.nombre_actual_de_la_columna', 'nuevo_nombre_de_la_columna', 'COLUMN';

EXEC sp_rename 'Catalogo.Categorias.Nombre', 'Clasificacion_categoria', 'COLUMN';

select*from Catalogo.Categorias

EXEC sp_rename 'Ventas.Clientes.Correo', 'Email', 'COLUMN';

select*from Ventas.Clientes

EXEC sp_rename 'Catalogo.Libros.Precio', 'Precio_unitario', 'COLUMN';

select*from Catalogo.Libros


-- INSERTAR DATOS

INSERT INTO Catalogo.Autores (Nombre, Apellido)
VALUES
('PEDRO', 'MARTINEZ'),
('ANA','PEREZ'),
('GABI','CRUZ'),
('JUAN','LOPEZ'),
('CAMILO','ALARCON'),
('SUSANA','SANCHEZ'),
('MARTA','PELAEZ'),
('DIANA','MENDOZA'),
('ALEJANDRA','DIAZ'),
('KELY','TABARES')

SELECT * FROM Catalogo.Autores

INSERT INTO Catalogo.Categorias (Clasificacion_categoria, Estado)
VALUES
('DRAMA','ACTIVO'),
('PSICOLOGIA','ACTIVO'),
('ROMANCE','ACTIVO'),
('CUENTO','ACTIVO'),
('FANTASIA','ACTIVO'),
('POESIA','ACTIVO'),
('FILOSOFIA','ACTIVO'),
('HISTORIA','INACTIVO'),
('COMEDIA','INACTIVO'),
('SUSPENSO','INACTIVO')

SELECT * FROM Catalogo.Categorias

INSERT INTO Catalogo.Libros (Titulo, AutorID, CategoriaID, Precio_unitario)
VALUES
('El tunel',1,1,12000),
('JUANA DE ARCO',2,4,11000),
('MARIA',3,6,11100),
('PEDRO PARAMO',4,2,17100),
('LA BELLA Y LA BESTIA',5,3,11100),
('ARIEL',6,5,11100),
('EL OLVIDO QUE SEREMOS',7,8,11100),
('LA VACA',8,10,11100),
('EL MUNDO DE SOFIA',9,7,11100),
('CIEN AÑOS DE SOLEDAD',10,9,11100)

SELECT * FROM Catalogo.Libros

INSERT INTO Ventas.Clientes (Nombre, Apellido, Email)
VALUES
('JUAN','CASAS', 'jcasas@gmail.com'),
('EMILIO','CRUZ', 'ecruzas@gmail.com'),
('SARA','DIAZ', 'sdiaz@gmail.com'),
('ALE','RUIZ', 'aruiz@gmail.com'),
('PAULA','ALARCON', 'palarcon@gmail.com'),
('MARLON','MENESES', 'mmene@gmail.com'),
('JULIAN','PINEDA', 'jpine@gmail.com'),
('CAMILO','MONTOYA', 'camo@gmail.com'),
('RUBEN','CARVAJAL', 'rubenca@gmail.com'),
('ESTEBAN','SANCHEZ', 'essanchez@gmail.com')

SELECT * FROM Ventas.Clientes

INSERT INTO Ventas.Ventas (ClienteID, FechaVenta, Metodo_pago)
VALUES
(1,'2024-02-15','EFECTIVO'),
(2,'2024-02-10','TARJETA'),
(3,'2024-03-10','TARJETA'),
(4,'2024-03-14','EFECTIVO'),
(5,'2024-02-20','TARJETA'),
(6,'2024-03-20','EFECTIVO'),
(7,'2024-02-02','TARJETA'),
(8,'2024-02-20','EFECTIVO'),
(9,'2024-02-24','TARJETA'),
(10,'2024-02-21','EFECTIVO')

SELECT * FROM Ventas.Ventas


INSERT INTO Ventas.DetalleVentas (VentaID,LibroID, Cantidad, PrecioVenta)
VALUES
(10,1,2,24000),
(9,2,9,17100),
(8,3,3,33000),
(7,4,1,11100),
(6,5,1,17100),
(5,6,1,11100),
(4,7,2,34200),
(3,8,1,17100),
(2,9,1,11100),
(1,10,1,17100)

SELECT * FROM Ventas.DetalleVentas