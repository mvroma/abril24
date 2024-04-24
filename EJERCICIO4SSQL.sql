-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://github.com/pgadmin-org/pgadmin4/issues/new/choose if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.almacenes
(
    id_almacen serial NOT NULL,
    direccion character varying(50) COLLATE pg_catalog."default",
    id_provincia character varying(50) COLLATE pg_catalog."default",
    f_apertura date,
    CONSTRAINT almacenes_pkey PRIMARY KEY (id_almacen)
);

CREATE TABLE IF NOT EXISTS public.avala
(
    id_socioavalador serial NOT NULL,
    CONSTRAINT avala_pkey PRIMARY KEY (id_socioavalador)
);

CREATE TABLE IF NOT EXISTS public.colecciones
(
    volumen character varying(50) COLLATE pg_catalog."default",
    id_coleccion serial NOT NULL,
    CONSTRAINT colecciones_pkey PRIMARY KEY (id_coleccion)
);

CREATE TABLE IF NOT EXISTS public.detalle_pedido
(
    id_pedido serial NOT NULL,
    consecutivo integer NOT NULL,
    isbn integer,
    cantidad integer,
    CONSTRAINT detalle_pedido_pkey PRIMARY KEY (id_pedido, consecutivo)
);

CREATE TABLE IF NOT EXISTS public.libros
(
    isbn serial NOT NULL,
    autor character varying(50) COLLATE pg_catalog."default",
    editorial character varying(50) COLLATE pg_catalog."default",
    titulo character varying(50) COLLATE pg_catalog."default",
    id_coleccion serial NOT NULL,
    CONSTRAINT isbn PRIMARY KEY (isbn)
);

CREATE TABLE IF NOT EXISTS public.pedidos
(
    id_pedido serial NOT NULL,
    id_socio serial NOT NULL,
    forma_envio character varying(50) COLLATE pg_catalog."default",
    forma_pago character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT pedidos_pkey PRIMARY KEY (id_pedido)
);

CREATE TABLE IF NOT EXISTS public.poblacion
(
    id_poblacion serial NOT NULL,
    habitantes integer,
    nombre character varying(50) COLLATE pg_catalog."default",
    id_provincia serial NOT NULL,
    CONSTRAINT id_poblacion PRIMARY KEY (id_poblacion)
);

CREATE TABLE IF NOT EXISTS public.provincia
(
    id_provincia serial NOT NULL,
    nombre character varying(50) COLLATE pg_catalog."default",
    extens integer,
    id_almacen serial NOT NULL,
    CONSTRAINT id_provincia PRIMARY KEY (id_provincia)
);

CREATE TABLE IF NOT EXISTS public.socios
(
    id_socio serial NOT NULL,
    dni character varying(50) COLLATE pg_catalog."default",
    nombre character varying(50) COLLATE pg_catalog."default",
    apellidos character varying(50) COLLATE pg_catalog."default",
    telefono integer,
    id_poblacion serial NOT NULL,
    id_socioavalador serial NOT NULL,
    CONSTRAINT socios_pkey PRIMARY KEY (id_socio)
);

CREATE TABLE IF NOT EXISTS public.stock
(
    cantidad integer,
    id_almacen serial NOT NULL,
    isbn integer
);

ALTER TABLE IF EXISTS public.detalle_pedido
    ADD CONSTRAINT fk_id_pedido FOREIGN KEY (id_pedido)
    REFERENCES public.pedidos (id_pedido) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.libros
    ADD CONSTRAINT libros_id_coleccion_fkey FOREIGN KEY (id_coleccion)
    REFERENCES public.colecciones (id_coleccion) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.pedidos
    ADD CONSTRAINT pedidos_id_socio_fkey FOREIGN KEY (id_socio)
    REFERENCES public.socios (id_socio) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.poblacion
    ADD CONSTRAINT poblacion_id_provincia_fkey FOREIGN KEY (id_provincia)
    REFERENCES public.provincia (id_provincia) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.provincia
    ADD CONSTRAINT provincia_id_almacen_fkey FOREIGN KEY (id_almacen)
    REFERENCES public.almacenes (id_almacen) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.socios
    ADD CONSTRAINT socios_id_poblacion_fkey FOREIGN KEY (id_poblacion)
    REFERENCES public.poblacion (id_poblacion) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.socios
    ADD CONSTRAINT socios_id_socioavalador_fkey FOREIGN KEY (id_socioavalador)
    REFERENCES public.avala (id_socioavalador) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.stock
    ADD CONSTRAINT stock_id_almacen_fkey FOREIGN KEY (id_almacen)
    REFERENCES public.almacenes (id_almacen) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.stock
    ADD CONSTRAINT stock_isbn_fkey FOREIGN KEY (isbn)
    REFERENCES public.libros (isbn) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;