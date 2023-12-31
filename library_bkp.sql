PGDMP      :                {            fauc    16.1    16.1 F               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    25480    fauc    DATABASE     �   CREATE DATABASE fauc WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United Kingdom.1252';
    DROP DATABASE fauc;
                postgres    false            [           1247    25490    booktype    TYPE     q   CREATE TYPE public.booktype AS ENUM (
    'school',
    'art',
    'science',
    'biography',
    'tehnical'
);
    DROP TYPE public.booktype;
       public          postgres    false            �            1255    25597    borrowbook(integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.borrowbook(IN libraryuserid integer, IN bookid integer)
    LANGUAGE plpgsql
    AS $$
begin
if (select count(*) from (select b.userID from borrows b where userID = b.userID and b.dateOfReturn is null)) >= 3 then
raise exception 'Too many borowed books!';
return;
end if;
insert into borrows(userID, bookID, dateOfBorrowing, dateToReturn)
		values (@libraryuserID, @bookID, current_date, current_date + 20);
end;
$$;
 O   DROP PROCEDURE public.borrowbook(IN libraryuserid integer, IN bookid integer);
       public          postgres    false            �            1259    25533    author    TABLE     j  CREATE TABLE public.author (
    authorid integer NOT NULL,
    firstname character varying(32) NOT NULL,
    lastname character varying(64) NOT NULL,
    dateofbirth date NOT NULL,
    dateofdeath date,
    gender smallint NOT NULL,
    country integer NOT NULL,
    CONSTRAINT author_gender_value CHECK ((((gender >= 0) AND (gender <= 2)) OR (gender = 9)))
);
    DROP TABLE public.author;
       public         heap    postgres    false            �            1259    25532    author_authorid_seq    SEQUENCE     �   CREATE SEQUENCE public.author_authorid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.author_authorid_seq;
       public          postgres    false    223                       0    0    author_authorid_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.author_authorid_seq OWNED BY public.author.authorid;
          public          postgres    false    222            �            1259    25502    book    TABLE     �   CREATE TABLE public.book (
    bookid integer NOT NULL,
    title character varying(127) NOT NULL,
    bookcode character varying(8) NOT NULL,
    type public.booktype NOT NULL,
    dateofrelease date NOT NULL
);
    DROP TABLE public.book;
       public         heap    postgres    false    859            �            1259    25501    book_bookid_seq    SEQUENCE     �   CREATE SEQUENCE public.book_bookid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.book_bookid_seq;
       public          postgres    false    218                       0    0    book_bookid_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.book_bookid_seq OWNED BY public.book.bookid;
          public          postgres    false    217            �            1259    25508    bookinlibrary    TABLE     c   CREATE TABLE public.bookinlibrary (
    libraryid integer NOT NULL,
    bookid integer NOT NULL
);
 !   DROP TABLE public.bookinlibrary;
       public         heap    postgres    false            �            1259    25561 
   bookkeeper    TABLE     �   CREATE TABLE public.bookkeeper (
    bookkeeperid integer NOT NULL,
    firstname character varying(32) NOT NULL,
    lastname character varying(64) NOT NULL,
    worksinlibraryid integer NOT NULL
);
    DROP TABLE public.bookkeeper;
       public         heap    postgres    false            �            1259    25560    bookkeeper_bookkeeperid_seq    SEQUENCE     �   CREATE SEQUENCE public.bookkeeper_bookkeeperid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.bookkeeper_bookkeeperid_seq;
       public          postgres    false    226                       0    0    bookkeeper_bookkeeperid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.bookkeeper_bookkeeperid_seq OWNED BY public.bookkeeper.bookkeeperid;
          public          postgres    false    225            �            1259    25580    borrows    TABLE     *  CREATE TABLE public.borrows (
    borrowingid integer NOT NULL,
    userid integer NOT NULL,
    bookid integer NOT NULL,
    dateofborrowing date NOT NULL,
    datetoreturn date NOT NULL,
    dateofreturn date,
    CONSTRAINT invalid_return_date CHECK (((datetoreturn - dateofborrowing) < 60))
);
    DROP TABLE public.borrows;
       public         heap    postgres    false            �            1259    25579    borrows_borrowingid_seq    SEQUENCE     �   CREATE SEQUENCE public.borrows_borrowingid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.borrows_borrowingid_seq;
       public          postgres    false    230                       0    0    borrows_borrowingid_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.borrows_borrowingid_seq OWNED BY public.borrows.borrowingid;
          public          postgres    false    229            �            1259    25524    country    TABLE     �   CREATE TABLE public.country (
    countryid integer NOT NULL,
    name character varying(64) NOT NULL,
    population bigint NOT NULL,
    averagesalary numeric(12,2) NOT NULL
);
    DROP TABLE public.country;
       public         heap    postgres    false            �            1259    25523    country_countryid_seq    SEQUENCE     �   CREATE SEQUENCE public.country_countryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.country_countryid_seq;
       public          postgres    false    221                       0    0    country_countryid_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.country_countryid_seq OWNED BY public.country.countryid;
          public          postgres    false    220            �            1259    25482    library    TABLE     �   CREATE TABLE public.library (
    libraryid integer NOT NULL,
    name character varying(64) NOT NULL,
    opentime time without time zone,
    closetime time without time zone,
    CONSTRAINT open_close_time_invalid CHECK ((closetime > opentime))
);
    DROP TABLE public.library;
       public         heap    postgres    false            �            1259    25481    library_libraryid_seq    SEQUENCE     �   CREATE SEQUENCE public.library_libraryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.library_libraryid_seq;
       public          postgres    false    216                       0    0    library_libraryid_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.library_libraryid_seq OWNED BY public.library.libraryid;
          public          postgres    false    215            �            1259    25573    libraryuser    TABLE     �   CREATE TABLE public.libraryuser (
    userid integer NOT NULL,
    firstname character varying(32) NOT NULL,
    lastname character varying(64) NOT NULL
);
    DROP TABLE public.libraryuser;
       public         heap    postgres    false            �            1259    25572    libraryuser_userid_seq    SEQUENCE     �   CREATE SEQUENCE public.libraryuser_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.libraryuser_userid_seq;
       public          postgres    false    228                       0    0    libraryuser_userid_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.libraryuser_userid_seq OWNED BY public.libraryuser.userid;
          public          postgres    false    227            �            1259    25545    wrote    TABLE     }   CREATE TABLE public.wrote (
    bookid integer NOT NULL,
    authorid integer NOT NULL,
    ismainauthor boolean NOT NULL
);
    DROP TABLE public.wrote;
       public         heap    postgres    false            G           2604    25536    author authorid    DEFAULT     r   ALTER TABLE ONLY public.author ALTER COLUMN authorid SET DEFAULT nextval('public.author_authorid_seq'::regclass);
 >   ALTER TABLE public.author ALTER COLUMN authorid DROP DEFAULT;
       public          postgres    false    222    223    223            E           2604    25505    book bookid    DEFAULT     j   ALTER TABLE ONLY public.book ALTER COLUMN bookid SET DEFAULT nextval('public.book_bookid_seq'::regclass);
 :   ALTER TABLE public.book ALTER COLUMN bookid DROP DEFAULT;
       public          postgres    false    217    218    218            H           2604    25564    bookkeeper bookkeeperid    DEFAULT     �   ALTER TABLE ONLY public.bookkeeper ALTER COLUMN bookkeeperid SET DEFAULT nextval('public.bookkeeper_bookkeeperid_seq'::regclass);
 F   ALTER TABLE public.bookkeeper ALTER COLUMN bookkeeperid DROP DEFAULT;
       public          postgres    false    226    225    226            J           2604    25583    borrows borrowingid    DEFAULT     z   ALTER TABLE ONLY public.borrows ALTER COLUMN borrowingid SET DEFAULT nextval('public.borrows_borrowingid_seq'::regclass);
 B   ALTER TABLE public.borrows ALTER COLUMN borrowingid DROP DEFAULT;
       public          postgres    false    229    230    230            F           2604    25527    country countryid    DEFAULT     v   ALTER TABLE ONLY public.country ALTER COLUMN countryid SET DEFAULT nextval('public.country_countryid_seq'::regclass);
 @   ALTER TABLE public.country ALTER COLUMN countryid DROP DEFAULT;
       public          postgres    false    220    221    221            D           2604    25485    library libraryid    DEFAULT     v   ALTER TABLE ONLY public.library ALTER COLUMN libraryid SET DEFAULT nextval('public.library_libraryid_seq'::regclass);
 @   ALTER TABLE public.library ALTER COLUMN libraryid DROP DEFAULT;
       public          postgres    false    215    216    216            I           2604    25576    libraryuser userid    DEFAULT     x   ALTER TABLE ONLY public.libraryuser ALTER COLUMN userid SET DEFAULT nextval('public.libraryuser_userid_seq'::regclass);
 A   ALTER TABLE public.libraryuser ALTER COLUMN userid DROP DEFAULT;
       public          postgres    false    228    227    228                      0    25533    author 
   TABLE DATA           j   COPY public.author (authorid, firstname, lastname, dateofbirth, dateofdeath, gender, country) FROM stdin;
    public          postgres    false    223   mS       �          0    25502    book 
   TABLE DATA           L   COPY public.book (bookid, title, bookcode, type, dateofrelease) FROM stdin;
    public          postgres    false    218   �S       �          0    25508    bookinlibrary 
   TABLE DATA           :   COPY public.bookinlibrary (libraryid, bookid) FROM stdin;
    public          postgres    false    219   �S                 0    25561 
   bookkeeper 
   TABLE DATA           Y   COPY public.bookkeeper (bookkeeperid, firstname, lastname, worksinlibraryid) FROM stdin;
    public          postgres    false    226   �S                 0    25580    borrows 
   TABLE DATA           k   COPY public.borrows (borrowingid, userid, bookid, dateofborrowing, datetoreturn, dateofreturn) FROM stdin;
    public          postgres    false    230   �S       �          0    25524    country 
   TABLE DATA           M   COPY public.country (countryid, name, population, averagesalary) FROM stdin;
    public          postgres    false    221   �S       �          0    25482    library 
   TABLE DATA           G   COPY public.library (libraryid, name, opentime, closetime) FROM stdin;
    public          postgres    false    216   T                 0    25573    libraryuser 
   TABLE DATA           B   COPY public.libraryuser (userid, firstname, lastname) FROM stdin;
    public          postgres    false    228   8T                 0    25545    wrote 
   TABLE DATA           ?   COPY public.wrote (bookid, authorid, ismainauthor) FROM stdin;
    public          postgres    false    224   UT                  0    0    author_authorid_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.author_authorid_seq', 1, false);
          public          postgres    false    222                       0    0    book_bookid_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.book_bookid_seq', 1, false);
          public          postgres    false    217                       0    0    bookkeeper_bookkeeperid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.bookkeeper_bookkeeperid_seq', 1, false);
          public          postgres    false    225                       0    0    borrows_borrowingid_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.borrows_borrowingid_seq', 1, false);
          public          postgres    false    229                       0    0    country_countryid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.country_countryid_seq', 1, false);
          public          postgres    false    220                       0    0    library_libraryid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.library_libraryid_seq', 1, false);
          public          postgres    false    215                       0    0    libraryuser_userid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.libraryuser_userid_seq', 1, false);
          public          postgres    false    227            Y           2606    25539    author author_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (authorid);
 <   ALTER TABLE ONLY public.author DROP CONSTRAINT author_pkey;
       public            postgres    false    223            Q           2606    25507    book book_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (bookid);
 8   ALTER TABLE ONLY public.book DROP CONSTRAINT book_pkey;
       public            postgres    false    218            S           2606    25512     bookinlibrary bookinlibrary_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.bookinlibrary
    ADD CONSTRAINT bookinlibrary_pkey PRIMARY KEY (libraryid, bookid);
 J   ALTER TABLE ONLY public.bookinlibrary DROP CONSTRAINT bookinlibrary_pkey;
       public            postgres    false    219    219            ]           2606    25566    bookkeeper bookkeeper_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.bookkeeper
    ADD CONSTRAINT bookkeeper_pkey PRIMARY KEY (bookkeeperid);
 D   ALTER TABLE ONLY public.bookkeeper DROP CONSTRAINT bookkeeper_pkey;
       public            postgres    false    226            a           2606    25586    borrows borrows_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.borrows
    ADD CONSTRAINT borrows_pkey PRIMARY KEY (borrowingid);
 >   ALTER TABLE ONLY public.borrows DROP CONSTRAINT borrows_pkey;
       public            postgres    false    230            U           2606    25531    country country_name_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_name_key UNIQUE (name);
 B   ALTER TABLE ONLY public.country DROP CONSTRAINT country_name_key;
       public            postgres    false    221            W           2606    25529    country country_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (countryid);
 >   ALTER TABLE ONLY public.country DROP CONSTRAINT country_pkey;
       public            postgres    false    221            O           2606    25488    library library_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.library
    ADD CONSTRAINT library_pkey PRIMARY KEY (libraryid);
 >   ALTER TABLE ONLY public.library DROP CONSTRAINT library_pkey;
       public            postgres    false    216            _           2606    25578    libraryuser libraryuser_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.libraryuser
    ADD CONSTRAINT libraryuser_pkey PRIMARY KEY (userid);
 F   ALTER TABLE ONLY public.libraryuser DROP CONSTRAINT libraryuser_pkey;
       public            postgres    false    228            [           2606    25549    wrote wrote_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.wrote
    ADD CONSTRAINT wrote_pkey PRIMARY KEY (bookid, authorid);
 :   ALTER TABLE ONLY public.wrote DROP CONSTRAINT wrote_pkey;
       public            postgres    false    224    224            d           2606    25540    author author_country_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_country_fkey FOREIGN KEY (country) REFERENCES public.country(countryid);
 D   ALTER TABLE ONLY public.author DROP CONSTRAINT author_country_fkey;
       public          postgres    false    4695    223    221            b           2606    25518 '   bookinlibrary bookinlibrary_bookid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bookinlibrary
    ADD CONSTRAINT bookinlibrary_bookid_fkey FOREIGN KEY (bookid) REFERENCES public.book(bookid);
 Q   ALTER TABLE ONLY public.bookinlibrary DROP CONSTRAINT bookinlibrary_bookid_fkey;
       public          postgres    false    219    218    4689            c           2606    25513 *   bookinlibrary bookinlibrary_libraryid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bookinlibrary
    ADD CONSTRAINT bookinlibrary_libraryid_fkey FOREIGN KEY (libraryid) REFERENCES public.library(libraryid);
 T   ALTER TABLE ONLY public.bookinlibrary DROP CONSTRAINT bookinlibrary_libraryid_fkey;
       public          postgres    false    216    219    4687            g           2606    25567 +   bookkeeper bookkeeper_worksinlibraryid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bookkeeper
    ADD CONSTRAINT bookkeeper_worksinlibraryid_fkey FOREIGN KEY (worksinlibraryid) REFERENCES public.library(libraryid);
 U   ALTER TABLE ONLY public.bookkeeper DROP CONSTRAINT bookkeeper_worksinlibraryid_fkey;
       public          postgres    false    4687    216    226            h           2606    25592    borrows borrows_bookid_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.borrows
    ADD CONSTRAINT borrows_bookid_fkey FOREIGN KEY (bookid) REFERENCES public.book(bookid);
 E   ALTER TABLE ONLY public.borrows DROP CONSTRAINT borrows_bookid_fkey;
       public          postgres    false    230    218    4689            i           2606    25587    borrows borrows_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.borrows
    ADD CONSTRAINT borrows_userid_fkey FOREIGN KEY (userid) REFERENCES public.libraryuser(userid);
 E   ALTER TABLE ONLY public.borrows DROP CONSTRAINT borrows_userid_fkey;
       public          postgres    false    230    228    4703            e           2606    25555    wrote wrote_authorid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.wrote
    ADD CONSTRAINT wrote_authorid_fkey FOREIGN KEY (authorid) REFERENCES public.author(authorid);
 C   ALTER TABLE ONLY public.wrote DROP CONSTRAINT wrote_authorid_fkey;
       public          postgres    false    224    4697    223            f           2606    25550    wrote wrote_bookid_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.wrote
    ADD CONSTRAINT wrote_bookid_fkey FOREIGN KEY (bookid) REFERENCES public.book(bookid);
 A   ALTER TABLE ONLY public.wrote DROP CONSTRAINT wrote_bookid_fkey;
       public          postgres    false    218    4689    224                  x������ � �      �      x������ � �      �      x������ � �            x������ � �            x������ � �      �      x������ � �      �      x������ � �            x������ � �            x������ � �     