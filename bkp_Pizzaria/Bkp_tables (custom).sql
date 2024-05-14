PGDMP  .    +                |            Exemplo_Bkp    16.1    16.1     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    33732    Exemplo_Bkp    DATABASE     �   CREATE DATABASE "Exemplo_Bkp" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE "Exemplo_Bkp";
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1259    33733    cliente    TABLE     �   CREATE TABLE public.cliente (
    cpf character varying(14) NOT NULL,
    endereco character varying(40) NOT NULL,
    nome character varying(40) NOT NULL,
    telefone character varying(15) NOT NULL
);
    DROP TABLE public.cliente;
       public         heap    postgres    false    4            �            1259    33753    contem    TABLE     �   CREATE TABLE public.contem (
    quantidade integer NOT NULL,
    comprovante character varying(20) NOT NULL,
    id integer NOT NULL,
    numero integer NOT NULL
);
    DROP TABLE public.contem;
       public         heap    postgres    false    4            �            1259    33743    pedido    TABLE     �   CREATE TABLE public.pedido (
    numero integer NOT NULL,
    total numeric(7,2) NOT NULL,
    data date NOT NULL,
    cpf character varying(14) NOT NULL
);
    DROP TABLE public.pedido;
       public         heap    postgres    false    4            �            1259    33738    produto    TABLE     �   CREATE TABLE public.produto (
    id integer NOT NULL,
    preco numeric(7,2) NOT NULL,
    nome character varying(40) NOT NULL,
    estoque integer NOT NULL
);
    DROP TABLE public.produto;
       public         heap    postgres    false    4            &           2606    33737    cliente cliente_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cpf);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    215            ,           2606    33757    contem contem_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.contem
    ADD CONSTRAINT contem_pkey PRIMARY KEY (comprovante);
 <   ALTER TABLE ONLY public.contem DROP CONSTRAINT contem_pkey;
       public            postgres    false    218            *           2606    33747    pedido pedido_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (numero);
 <   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pedido_pkey;
       public            postgres    false    217            (           2606    33742    produto produto_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.produto DROP CONSTRAINT produto_pkey;
       public            postgres    false    216            .           2606    33758    contem contem_id_fkey    FK CONSTRAINT     q   ALTER TABLE ONLY public.contem
    ADD CONSTRAINT contem_id_fkey FOREIGN KEY (id) REFERENCES public.produto(id);
 ?   ALTER TABLE ONLY public.contem DROP CONSTRAINT contem_id_fkey;
       public          postgres    false    218    4648    216            /           2606    33763    contem contem_numero_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.contem
    ADD CONSTRAINT contem_numero_fkey FOREIGN KEY (numero) REFERENCES public.pedido(numero);
 C   ALTER TABLE ONLY public.contem DROP CONSTRAINT contem_numero_fkey;
       public          postgres    false    218    217    4650            -           2606    33748    pedido pedido_cpf_fkey    FK CONSTRAINT     t   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_cpf_fkey FOREIGN KEY (cpf) REFERENCES public.cliente(cpf);
 @   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pedido_cpf_fkey;
       public          postgres    false    217    215    4646           