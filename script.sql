CREATE TABLE cliente (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  apellido VARCHAR(255) NOT NULL,
  tipo_documento VARCHAR(50) NOT NULL,
  numero_documento VARCHAR(50) UNIQUE NOT NULL,
  nacionalidad VARCHAR(100),
  email VARCHAR(255),
  telefono VARCHAR(20),
  fecha_nacimiento DATE
);

create table concepto(
    id SERIAL primary key,
    descripcion_concepto TEXT NOT NULL, 
    puntos_requeridos INT
    
);


CREATE TABLE regla_asignacion_puntos(
   id SERIAL PRIMARY KEY, 
   limite_inferior NUMERIC (15,2), 
   limite_superior NUMERIC (15,2), 
   monto_equivalencia_1punto NUMERIC (15,2)
);

CREATE TABLE vencimiento_puntos(
    id serial primary key ,
    fecha_inicio_validez DATE,
    fecha_fin_validez DATE,
    dias_duracion_puntaje INT
);

CREATE TABLE bolsa_puntos(
    id serial primary key ,
    cliente_id INTEGER REFERENCES cliente(id),
    fecha_asignacion_puntaje TIMESTAMP NOT NULL DEFAULT NOW(),
    fecha_caducidad_puntaje DATE, 
    puntaje_asignado INT NOT NULL DEFAULT 0,
    puntaje_utilizado INT NOT NULL DEFAULT 0,
    saldo_puntos INT NOT NULL DEFAULT 0, 
    monto_operacion NUMERIC (15,2)
); 

create table uso_punto_cabecera(

    id SERIAL primary key,
    cliente_id integer references cliente(id) on delete CASCADE,
    puntajeUtilizado integer not null,
    fecha date not null,
    concepto_id integer references concepto(id) on delete cascade

);

CREATE TABLE uso_puntoDetalle(
   id SERIAL PRIMARY KEY, 
   cabecera_id INTEGER REFERENCES uso_punto_cabecera(id), 
   puntajes_utilizados INT NOT NULL DEFAULT 0,  
   bolsa_usada INTEGER REFERENCES bolsa_puntos(id) ON DELETE CASCADE
); 

alter table concepto add id_vencimiento integer references vencimiento_puntos(id) on delete CASCADE;

alter table concepto add id_regla integer references regla_asignacion_puntos(id) on delete CASCADE;






