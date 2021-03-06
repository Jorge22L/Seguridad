PGDMP     +                    y         	   seguridad    11.10    11.10 (    .           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            /           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            0           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            1           1262    25217 	   seguridad    DATABASE     ?   CREATE DATABASE seguridad WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Spain.1252' LC_CTYPE = 'Spanish_Spain.1252';
    DROP DATABASE seguridad;
             postgres    false            ?            1259    25218    tblrol    TABLE     ?   CREATE TABLE public.tblrol (
    idrol integer NOT NULL,
    descripcion character varying(20) NOT NULL,
    estado integer NOT NULL
);
    DROP TABLE public.tblrol;
       public         postgres    false            ?            1259    25221    rol_idrol_seq    SEQUENCE     ?   CREATE SEQUENCE public.rol_idrol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.rol_idrol_seq;
       public       postgres    false    196            2           0    0    rol_idrol_seq    SEQUENCE OWNED BY     B   ALTER SEQUENCE public.rol_idrol_seq OWNED BY public.tblrol.idrol;
            public       postgres    false    197            ?            1259    25223    tbl_usuario_rol    TABLE     ?   CREATE TABLE public.tbl_usuario_rol (
    idtblusuario_rol integer NOT NULL,
    idusuario integer NOT NULL,
    idrol integer NOT NULL
);
 #   DROP TABLE public.tbl_usuario_rol;
       public         postgres    false            ?            1259    25226 $   tbl_usuario_rol_idtblusuario_rol_seq    SEQUENCE     ?   CREATE SEQUENCE public.tbl_usuario_rol_idtblusuario_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.tbl_usuario_rol_idtblusuario_rol_seq;
       public       postgres    false    198            3           0    0 $   tbl_usuario_rol_idtblusuario_rol_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.tbl_usuario_rol_idtblusuario_rol_seq OWNED BY public.tbl_usuario_rol.idtblusuario_rol;
            public       postgres    false    199            ?            1259    25228 	   tblopcion    TABLE     ?   CREATE TABLE public.tblopcion (
    idopcion integer NOT NULL,
    descripcion character varying(35) NOT NULL,
    url character varying(50) NOT NULL
);
    DROP TABLE public.tblopcion;
       public         postgres    false            ?            1259    25231    tblopcion_idopcion_seq    SEQUENCE     ?   CREATE SEQUENCE public.tblopcion_idopcion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.tblopcion_idopcion_seq;
       public       postgres    false    200            4           0    0    tblopcion_idopcion_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.tblopcion_idopcion_seq OWNED BY public.tblopcion.idopcion;
            public       postgres    false    201            ?            1259    25233    tblrol_opciones    TABLE     ?   CREATE TABLE public.tblrol_opciones (
    idrol_opciones integer NOT NULL,
    idrol integer NOT NULL,
    idopciones integer NOT NULL
);
 #   DROP TABLE public.tblrol_opciones;
       public         postgres    false            ?            1259    25236 "   tblrol_opciones_idrol_opciones_seq    SEQUENCE     ?   CREATE SEQUENCE public.tblrol_opciones_idrol_opciones_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.tblrol_opciones_idrol_opciones_seq;
       public       postgres    false    202            5           0    0 "   tblrol_opciones_idrol_opciones_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.tblrol_opciones_idrol_opciones_seq OWNED BY public.tblrol_opciones.idrol_opciones;
            public       postgres    false    203            ?            1259    25238 
   tblusuario    TABLE     $  CREATE TABLE public.tblusuario (
    idusuario integer NOT NULL,
    nombre character varying(45) NOT NULL,
    apellido character varying(45) NOT NULL,
    usuario character varying(45) NOT NULL,
    pwd character varying(33) NOT NULL,
    fechacreacion date,
    estado integer NOT NULL
);
    DROP TABLE public.tblusuario;
       public         postgres    false            ?            1259    25241    tblusuario_idusuario_seq    SEQUENCE     ?   CREATE SEQUENCE public.tblusuario_idusuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.tblusuario_idusuario_seq;
       public       postgres    false    204            6           0    0    tblusuario_idusuario_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.tblusuario_idusuario_seq OWNED BY public.tblusuario.idusuario;
            public       postgres    false    205            ?            1259    33291    vw_usuario_rol    VIEW     *  CREATE VIEW public.vw_usuario_rol AS
 SELECT tbu.idusuario,
    tbu.nombre,
    tbu.apellido,
    tbu.usuario,
    tbu.pwd,
    tbu.estado,
    tbr.idrol,
    tbr.descripcion,
    tbo.idopcion,
    tbo.descripcion AS nombre_opcion,
    tbo.url
   FROM ((((public.tblusuario tbu
     JOIN public.tbl_usuario_rol tbur ON ((tbu.idusuario = tbur.idusuario)))
     JOIN public.tblrol tbr ON ((tbur.idrol = tbr.idrol)))
     JOIN public.tblrol_opciones tbro ON ((tbr.idrol = tbro.idrol)))
     JOIN public.tblopcion tbo ON ((tbro.idopciones = tbo.idopcion)));
 !   DROP VIEW public.vw_usuario_rol;
       public       postgres    false    204    202    202    200    200    200    198    198    204    204    196    196    204    204    204            ?
           2604    25243     tbl_usuario_rol idtblusuario_rol    DEFAULT     ?   ALTER TABLE ONLY public.tbl_usuario_rol ALTER COLUMN idtblusuario_rol SET DEFAULT nextval('public.tbl_usuario_rol_idtblusuario_rol_seq'::regclass);
 O   ALTER TABLE public.tbl_usuario_rol ALTER COLUMN idtblusuario_rol DROP DEFAULT;
       public       postgres    false    199    198            ?
           2604    25244    tblopcion idopcion    DEFAULT     x   ALTER TABLE ONLY public.tblopcion ALTER COLUMN idopcion SET DEFAULT nextval('public.tblopcion_idopcion_seq'::regclass);
 A   ALTER TABLE public.tblopcion ALTER COLUMN idopcion DROP DEFAULT;
       public       postgres    false    201    200            ?
           2604    25245    tblrol idrol    DEFAULT     i   ALTER TABLE ONLY public.tblrol ALTER COLUMN idrol SET DEFAULT nextval('public.rol_idrol_seq'::regclass);
 ;   ALTER TABLE public.tblrol ALTER COLUMN idrol DROP DEFAULT;
       public       postgres    false    197    196            ?
           2604    25246    tblrol_opciones idrol_opciones    DEFAULT     ?   ALTER TABLE ONLY public.tblrol_opciones ALTER COLUMN idrol_opciones SET DEFAULT nextval('public.tblrol_opciones_idrol_opciones_seq'::regclass);
 M   ALTER TABLE public.tblrol_opciones ALTER COLUMN idrol_opciones DROP DEFAULT;
       public       postgres    false    203    202            ?
           2604    25247    tblusuario idusuario    DEFAULT     |   ALTER TABLE ONLY public.tblusuario ALTER COLUMN idusuario SET DEFAULT nextval('public.tblusuario_idusuario_seq'::regclass);
 C   ALTER TABLE public.tblusuario ALTER COLUMN idusuario DROP DEFAULT;
       public       postgres    false    205    204            $          0    25223    tbl_usuario_rol 
   TABLE DATA               M   COPY public.tbl_usuario_rol (idtblusuario_rol, idusuario, idrol) FROM stdin;
    public       postgres    false    198   d.       &          0    25228 	   tblopcion 
   TABLE DATA               ?   COPY public.tblopcion (idopcion, descripcion, url) FROM stdin;
    public       postgres    false    200   ?.       "          0    25218    tblrol 
   TABLE DATA               <   COPY public.tblrol (idrol, descripcion, estado) FROM stdin;
    public       postgres    false    196   ?.       (          0    25233    tblrol_opciones 
   TABLE DATA               L   COPY public.tblrol_opciones (idrol_opciones, idrol, idopciones) FROM stdin;
    public       postgres    false    202   /       *          0    25238 
   tblusuario 
   TABLE DATA               f   COPY public.tblusuario (idusuario, nombre, apellido, usuario, pwd, fechacreacion, estado) FROM stdin;
    public       postgres    false    204   G/       7           0    0    rol_idrol_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.rol_idrol_seq', 2, true);
            public       postgres    false    197            8           0    0 $   tbl_usuario_rol_idtblusuario_rol_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.tbl_usuario_rol_idtblusuario_rol_seq', 3, true);
            public       postgres    false    199            9           0    0    tblopcion_idopcion_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.tblopcion_idopcion_seq', 3, true);
            public       postgres    false    201            :           0    0 "   tblrol_opciones_idrol_opciones_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.tblrol_opciones_idrol_opciones_seq', 4, true);
            public       postgres    false    203            ;           0    0    tblusuario_idusuario_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.tblusuario_idusuario_seq', 11, true);
            public       postgres    false    205            ?
           2606    25249 $   tbl_usuario_rol tbl_usuario_rol_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.tbl_usuario_rol
    ADD CONSTRAINT tbl_usuario_rol_pkey PRIMARY KEY (idtblusuario_rol);
 N   ALTER TABLE ONLY public.tbl_usuario_rol DROP CONSTRAINT tbl_usuario_rol_pkey;
       public         postgres    false    198            ?
           2606    25251    tblopcion tblopcion_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.tblopcion
    ADD CONSTRAINT tblopcion_pkey PRIMARY KEY (idopcion);
 B   ALTER TABLE ONLY public.tblopcion DROP CONSTRAINT tblopcion_pkey;
       public         postgres    false    200            ?
           2606    25253 $   tblrol_opciones tblrol_opciones_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.tblrol_opciones
    ADD CONSTRAINT tblrol_opciones_pkey PRIMARY KEY (idrol_opciones);
 N   ALTER TABLE ONLY public.tblrol_opciones DROP CONSTRAINT tblrol_opciones_pkey;
       public         postgres    false    202            ?
           2606    25255    tblrol tblrol_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.tblrol
    ADD CONSTRAINT tblrol_pkey PRIMARY KEY (idrol);
 <   ALTER TABLE ONLY public.tblrol DROP CONSTRAINT tblrol_pkey;
       public         postgres    false    196            ?
           2606    25257    tblusuario tblusuario_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.tblusuario
    ADD CONSTRAINT tblusuario_pkey PRIMARY KEY (idusuario);
 D   ALTER TABLE ONLY public.tblusuario DROP CONSTRAINT tblusuario_pkey;
       public         postgres    false    204            $      x?3?4?4?2?B.c i????? !??      &   8   x?3?-.M,?̇?zY?\F??)?%?E
0?R+1???KI???`?=... b??      "   .   x?3?tL????,.)JL?/?4?2?tI-??+?,
pq??qqq ?r      (   !   x?3?4?4?2?F\?@Ҙ˄?H??qqq 4;q      *   ?   x???Mn?0???Sp*{? U?R??m6[$?ؑ????n???t?ռ??f?=?:??h??n???_C. )???0"?)???K??	0???e?^?'a?E???B*U???????%??]?DUU?o I?&???Ƹ0)?=??o.k?$?8?_?vY{?6{???=?nj????????u?????d??:?I4T?)??t???[C?????70????br?0?????!³??     