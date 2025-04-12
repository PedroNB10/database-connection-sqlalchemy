DROP SCHEMA IF EXISTS public CASCADE;


--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.8 (Ubuntu 16.8-0ubuntu0.24.04.1)

-- Started on 2025-04-06 15:21:36 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16390)
-- Name: northwind; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA northwind;


--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16391)
-- Name: categories; Type: TABLE; Schema: northwind; Owner: -
--

CREATE TABLE northwind.categories (
    categoryid integer NOT NULL,
    categoryname character varying(50),
    description character varying(100),
    rate numeric(8,2)
);


--
-- TOC entry 217 (class 1259 OID 16394)
-- Name: customers; Type: TABLE; Schema: northwind; Owner: -
--

CREATE TABLE northwind.customers (
    customerid character varying(5) NOT NULL,
    companyname character varying(50),
    contactname character varying(30),
    contacttitle character varying(30),
    address character varying(50),
    city character varying(20),
    region character varying(15),
    postalcode character varying(9),
    country character varying(15),
    phone character varying(17),
    fax character varying(17)
);


--
-- TOC entry 218 (class 1259 OID 16397)
-- Name: employees; Type: TABLE; Schema: northwind; Owner: -
--

CREATE TABLE northwind.employees (
    employeeid integer NOT NULL,
    lastname character varying(10),
    firstname character varying(10),
    title character varying(25),
    titleofcourtesy character varying(5),
    birthdate timestamp without time zone,
    hiredate timestamp without time zone,
    address character varying(50),
    city character varying(20),
    region character varying(2),
    postalcode character varying(9),
    country character varying(15),
    homephone character varying(14),
    extension character varying(4),
    reportsto integer,
    notes text
);


--
-- TOC entry 219 (class 1259 OID 16402)
-- Name: order_details; Type: TABLE; Schema: northwind; Owner: -
--

CREATE TABLE northwind.order_details (
    orderid integer NOT NULL,
    productid integer NOT NULL,
    unitprice numeric(13,4),
    quantity smallint,
    discount numeric(10,4)
);


--
-- TOC entry 220 (class 1259 OID 16405)
-- Name: orders; Type: TABLE; Schema: northwind; Owner: -
--

CREATE TABLE northwind.orders (
    orderid integer NOT NULL,
    customerid character varying(5) NOT NULL,
    employeeid integer NOT NULL,
    orderdate timestamp without time zone,
    requireddate timestamp without time zone,
    shippeddate timestamp without time zone,
    freight numeric(15,4),
    shipname character varying(35),
    shipaddress character varying(50),
    shipcity character varying(15),
    shipregion character varying(15),
    shippostalcode character varying(9),
    shipcountry character varying(15),
    shipperid integer
);


--
-- TOC entry 221 (class 1259 OID 16408)
-- Name: products; Type: TABLE; Schema: northwind; Owner: -
--

CREATE TABLE northwind.products (
    productid integer NOT NULL,
    productname character varying(35),
    supplierid integer NOT NULL,
    categoryid integer NOT NULL,
    quantityperunit character varying(20),
    unitprice numeric(13,4),
    unitsinstock smallint,
    unitsonorder smallint,
    reorderlevel smallint,
    discontinued character varying(1)
);


--
-- TOC entry 222 (class 1259 OID 16411)
-- Name: shippers; Type: TABLE; Schema: northwind; Owner: -
--

CREATE TABLE northwind.shippers (
    shipperid integer NOT NULL,
    companyname character varying(20),
    phone character varying(14)
);


--
-- TOC entry 223 (class 1259 OID 16414)
-- Name: suppliers; Type: TABLE; Schema: northwind; Owner: -
--

CREATE TABLE northwind.suppliers (
    supplierid integer NOT NULL,
    companyname character varying(50),
    contactname character varying(30),
    contacttitle character varying(30),
    address character varying(50),
    city character varying(20),
    region character varying(15),
    postalcode character varying(8),
    country character varying(15),
    phone character varying(15),
    fax character varying(15),
    homepage character varying(100)
);


--
-- TOC entry 224 (class 1259 OID 16539)
-- Name: relatorio; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.relatorio AS
 SELECT o.orderid,
    o.customerid,
    o.employeeid,
    sum(od.quantity) AS total_produtos,
    sum(((od.quantity)::numeric * od.unitprice)) AS total_pedido
   FROM (northwind.orders o
     JOIN northwind.order_details od ON ((o.orderid = od.orderid)))
  GROUP BY o.orderid, o.customerid, o.employeeid;


--
-- TOC entry 3395 (class 0 OID 16391)
-- Dependencies: 216
-- Data for Name: categories; Type: TABLE DATA; Schema: northwind; Owner: -
--

COPY northwind.categories (categoryid, categoryname, description, rate) FROM stdin;
1	Beverages	Soft drinks	\N
2	Condiments	Sweet and savory sauces	\N
3	Confections	Desserts, candies, and sweet breads	\N
4	Dairy northwind.products	Cheeses	\N
5	Grains/Cereals	Breads, crackers, pasta, and cereal	\N
6	Meat/Poultry	Prepared meats	\N
7	Produce	Dried fruit and bean curd	\N
8	Seafood	Seaweed and fish	\N
\.


--
-- TOC entry 3396 (class 0 OID 16394)
-- Dependencies: 217
-- Data for Name: customers; Type: TABLE DATA; Schema: northwind; Owner: -
--

COPY northwind.customers (customerid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax) FROM stdin;
MEREP	MÃ¨re Paillarde	Jean FresniÃ¨re	Marketing Assistant	43 rue St. Laurent	MontrÃ©al	QuÃ©bec	H1J 1C3	Canada	(514) 555-8054	(514) 555-8055
ANATR	Ana Trujillo Emparedados y helados	Ana Trujillo	Owner	Avda. de la ConstituciÃ³n 2222	MÃ©xico D.F.	\N	05021	Mexico	(5) 555-4729	(5) 555-3745
ANTON	Antonio Moreno TaquerÃ­a	Antonio Moreno	Owner	Mataderos  2312	MÃ©xico D.F.	\N	05023	Mexico	(5) 555-3932	\N
AROUT	Around the Horn	Thomas Hardy	Sales Representative	120 Hanover Sq.	London	\N	WA1 1DP	UK	(171) 555-7788	(171) 555-6750
BERGS	Berglunds snabbkÃ¶p	Christina Berglund	Order Administrator	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	0921-12 34 65	0921-12 34 67
BLAUS	Blauer See Delikatessen	Hanna Moos	Sales Representative	Forsterstr. 57	Mannheim	\N	68306	Germany	0621-08460	0621-08924
BLONP	Blondel pÃ¨re et fils	FrÃ©dÃ©rique Citeaux	Marketing Manager	24, place KlÃ©ber	Strasbourg	\N	67000	France	88.60.15.31	88.60.15.32
BOLID	BÃ³lido Comidas preparadas	MartÃ­n Sommer	Owner	C/ Araquil, 67	Madrid	\N	28023	Spain	(91) 555 22 82	(91) 555 91 99
BONAP	Bon app'	Laurence Lebihan	Owner	12, rue des Bouchers	Marseille	\N	13008	France	91.24.45.40	91.24.45.41
BOTTM	Bottom-Dollar Markets	Elizabeth Lincoln	Accounting Manager	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	(604) 555-4729	(604) 555-3745
BSBEV	B's Beverages	Victoria Ashworth	Sales Representative	Fauntleroy Circus	London	\N	EC2 5NT	UK	(171) 555-1212	\N
CACTU	Cactus Comidas para llevar	Patricio Simpson	Sales Agent	Cerrito 333	Buenos Aires	\N	1010	Argentina	(1) 135-5555	(1) 135-4892
CENTC	Centro comercial Moctezuma	Francisco Chang	Marketing Manager	Sierras de Granada 9993	MÃ©xico D.F.	\N	05022	Mexico	(5) 555-3392	(5) 555-7293
CHOPS	Chop-suey Chinese	Yang Wang	Owner	Hauptstr. 29	Bern	\N	3012	Switzerland	0452-076545	\N
COMMI	ComÃ©rcio Mineiro	Pedro Afonso	Sales Associate	Av. dos LusÃ­adas, 23	SÃ£o Paulo	SP	05432-043	Brazil	(11) 555-7647	\N
CONSH	Consolidated Holdings	Elizabeth Brown	Sales Representative	Berkeley Gardens\n12  Brewery 	London	\N	WX1 6LT	UK	(171) 555-2282	(171) 555-9199
DRACD	Drachenblut Delikatessen	Sven Ottlieb	Order Administrator	Walserweg 21	Aachen	\N	52066	Germany	0241-039123	0241-059428
DUMON	Du monde entier	Janine Labrune	Owner	67, rue des Cinquante Otages	Nantes	\N	44000	France	40.67.88.88	40.67.89.89
EASTC	Eastern Connection	Ann Devon	Sales Agent	35 King George	London	\N	WX3 6FW	UK	(171) 555-0297	(171) 555-3373
ERNSH	Ernst Handel	Roland Mendel	Sales Manager	Kirchgasse 6	Graz	\N	8010	Austria	7675-3425	7675-3426
FAMIA	Familia Arquibaldo	Aria Cruz	Marketing Assistant	Rua OrÃ³s, 92	SÃ£o Paulo	SP	05442-030	Brazil	(11) 555-9857	\N
FISSA	FISSA Fabrica Inter. Salchichas S.A.	Diego Roel	Accounting Manager	C/ Moralzarzal, 86	Madrid	\N	28034	Spain	(91) 555 94 44	(91) 555 55 93
FOLIG	Folies gourmandes	Martine RancÃ©	Assistant Sales Agent	184, chaussÃ©e de Tournai	Lille	\N	59000	France	20.16.10.16	20.16.10.17
FOLKO	Folk och fÃ¤ HB	Maria Larsson	Owner	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	0695-34 67 21	\N
FRANK	Frankenversand	Peter Franken	Marketing Manager	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	089-0877310	089-0877451
FRANR	France restauration	Carine Schmitt	Marketing Manager	54, rue Royale	Nantes	\N	44000	France	40.32.21.21	40.32.21.20
FRANS	Franchi S.p.A.	Paolo Accorti	Sales Representative	Via Monte Bianco 34	Torino	\N	10100	Italy	011-4988260	011-4988261
FURIB	Furia Bacalhau e Frutos do Mar	Lino Rodriguez 	Sales Manager	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal	(1) 354-2534	(1) 354-2535
GALED	GalerÃ­a del gastrÃ³nomo	Eduardo Saavedra	Marketing Manager	Rambla de CataluÃ±a, 23	Barcelona	\N	08022	Spain	(93) 203 4560	(93) 203 4561
GODOS	Godos Cocina TÃ­pica	JosÃ© Pedro Freyre	Sales Manager	C/ Romero, 33	Sevilla	\N	41101	Spain	(95) 555 82 82	\N
GOURL	Gourmet Lanchonetes	AndrÃ© Fonseca	Sales Associate	Av. Brasil, 442	Campinas	SP	04876-786	Brazil	(11) 555-9482	\N
GREAL	Great Lakes Food Market	Howard Snyder	Marketing Manager	2732 Baker Blvd.	Eugene	OR	97403	USA	(503) 555-7555	\N
GROSR	GROSELLA-Restaurante	Manuel Pereira	Owner	5Âª Ave. Los Palos Grandes	Caracas	DF	1081	Venezuela	(2) 283-2951	(2) 283-3397
HANAR	Hanari Carnes	Mario Pontes	Accounting Manager	Rua do PaÃ§o, 67	Rio de Janeiro	RJ	05454-876	Brazil	(21) 555-0091	(21) 555-8765
HILAA	HILARIÃ“N-Abastos	Carlos HernÃ¡ndez	Sales Representative	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	(5) 555-1340	(5) 555-1948
HUNGC	Hungry Coyote Import Store	Yoshi Latimer	Sales Representative	City Center Plaza\n516 Main St.	Elgin	OR	97827	USA	(503) 555-6874	(503) 555-2376
HUNGO	Hungry Owl All-Night Grocers	Patricia McKenna	Sales Associate	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	2967 542	2967 3333
ISLAT	Island Trading	Helen Bennett	Marketing Manager	Garden House\nCrowther Way	Cowes	Isle of Wight	PO31 7PJ	UK	(198) 555-8888	\N
KOENE	KÃ¶niglich Essen	Philip Cramer	Sales Associate	Maubelstr. 90	Brandenburg	\N	14776	Germany	0555-09876	\N
LACOR	La corne d'abondance	Daniel Tonini	Sales Representative	67, avenue de l'Europe	Versailles	\N	78000	France	30.59.84.10	30.59.85.11
LAMAI	La maison d'Asie	Annette Roulet	Sales Manager	1 rue Alsace-Lorraine	Toulouse	\N	31000	France	61.77.61.10	61.77.61.11
LAUGB	Laughing Bacchus Wine Cellars	Yoshi Tannamuri	Marketing Assistant	1900 Oak St.	Vancouver	BC	V3F 2K1	Canada	(604) 555-3392	(604) 555-7293
LAZYK	Lazy K Kountry Store	John Steel	Marketing Manager	12 Orchestra Terrace	Walla Walla	WA	99362	USA	(509) 555-7969	(509) 555-6221
LEHMS	Lehmanns Marktstand	Renate Messner	Sales Representative	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	069-0245984	069-0245874
LETSS	Let's Stop N Shop	Jaime Yorres	Owner	87 Polk St.\nSuite 5	San Francisco	CA	94117	USA	(415) 555-5938	\N
LILAS	LILA-Supermercado	Carlos GonzÃ¡lez	Accounting Manager	Carrera 52 con Ave. BolÃ­var #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela	(9) 331-6954	(9) 331-7256
LINOD	LINO-Delicateses	Felipe Izquierdo	Owner	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela	(8) 34-56-12	(8) 34-93-93
LONEP	Lonesome Pine Restaurant	Fran Wilson	Sales Manager	89 Chiaroscuro Rd.	Portland	OR	97219	USA	(503) 555-9573	(503) 555-9646
MAGAA	Magazzini Alimentari Riuniti	Giovanni Rovelli	Marketing Manager	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy	035-640230	035-640231
MAISD	Maison Dewey	Catherine Dewey	Sales Agent	Rue Joseph-Bens 532	Bruxelles	\N	B-1180	Belgium	(02) 201 24 67	(02) 201 24 68
MORGK	Morgenstern Gesundkost	Alexander Feuer	Marketing Assistant	Heerstr. 22	Leipzig	\N	04179	Germany	0342-023176	\N
NORTS	North/South	Simon Crowther	Sales Associate	South House\n300 Queensbridge	London	\N	SW7 1RZ	UK	(171) 555-7733	(171) 555-2530
OCEAN	OcÃ©ano AtlÃ¡ntico Ltda.	Yvonne Moncada	Sales Agent	Ing. Gustavo Moncada 8585\nPiso 20-A	Buenos Aires	\N	1010	Argentina	(1) 135-5333	(1) 135-5535
OLDWO	Old World Delicatessen	Rene Phillips	Sales Representative	2743 Bering St.	Anchorage	AK	99508	USA	(907) 555-7584	(907) 555-2880
OTTIK	Ottilies KÃ¤seladen	Henriette Pfalzheim	Owner	Mehrheimerstr. 369	KÃ¶ln	\N	50739	Germany	0221-0644327	0221-0765721
PARIS	Paris spÃ©cialitÃ©s	Marie Bertrand	Owner	265, boulevard Charonne	Paris	\N	75012	France	(1) 42.34.22.66	(1) 42.34.22.77
PERIC	Pericles Comidas clÃ¡sicas	Guillermo FernÃ¡ndez	Sales Representative	Calle Dr. Jorge Cash 321	MÃ©xico D.F.	\N	05033	Mexico	(5) 552-3745	(5) 545-3745
PICCO	Piccolo und mehr	Georg Pipps	Sales Manager	Geislweg 14	Salzburg	\N	5020	Austria	6562-9722	6562-9723
PRINI	Princesa Isabel Vinhos	Isabel de Castro	Sales Representative	Estrada da saÃºde n. 58	Lisboa	\N	1756	Portugal	(1) 356-5634	\N
QUEDE	Que DelÃ­cia	Bernardo Batista	Accounting Manager	Rua da Panificadora, 12	Rio de Janeiro	RJ	02389-673	Brazil	(21) 555-4252	(21) 555-4545
QUEEN	Queen Cozinha	LÃºcia Carvalho	Marketing Assistant	Alameda dos CanÃ rios, 891	SÃ£o Paulo	SP	05487-020	Brazil	(11) 555-1189	\N
QUICK	QUICK-Stop	Horst Kloss	Accounting Manager	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	0372-035188	\N
RANCH	Rancho grande	Sergio GutiÃ©rrez	Sales Representative	Av. del Libertador 900	Buenos Aires	\N	1010	Argentina	(1) 123-5555	(1) 123-5556
RATTC	Rattlesnake Canyon Grocery	Paula Wilson	Assistant Sales Representative	2817 Milton Dr.	Albuquerque	NM	87110	USA	(505) 555-5939	(505) 555-3620
REGGC	Reggiani Caseifici	Maurizio Moroni	Sales Associate	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy	0522-556721	0522-556722
RICAR	Ricardo Adocicados	Janete Limeira	Assistant Sales Agent	Av. Copacabana, 267	Rio de Janeiro	RJ	02389-890	Brazil	(21) 555-3412	\N
RICSU	Richter Supermarkt	Michael Holz	Sales Manager	Grenzacherweg 237	GenÃ¨ve	\N	1203	Switzerland	0897-034214	\N
ROMEY	Romero y tomillo	Alejandra Camino	Accounting Manager	Gran VÃ­a, 1	Madrid	\N	28001	Spain	(91) 745 6200	(91) 745 6210
SANTG	SantÃ© Gourmet	Jonas Bergulfsen	Owner	Erling Skakkes gate 78	Stavern	\N	4110	Norway	07-98 92 35	07-98 92 47
SAVEA	Save-a-lot Markets	Jose Pavarotti	Sales Representative	187 Suffolk Ln.	Boise	ID	83720	USA	(208) 555-8097	\N
SEVES	Seven Seas Imports	Hari Kumar	Sales Manager	90 Wadhurst Rd.	London	\N	OX15 4NB	UK	(171) 555-1717	(171) 555-5646
SIMOB	Simons bistro	Jytte Petersen	Owner	VinbÃ¦ltet 34	KÃ¸benhavn	\N	1734	Denmark	31 12 34 56	31 13 35 57
SPECD	SpÃ©cialitÃ©s du monde	Dominique Perrier	Marketing Manager	25, rue Lauriston	Paris	\N	75016	France	(1) 47.55.60.10	(1) 47.55.60.20
SPLIR	Split Rail Beer & Ale	Art Braunschweiger	Sales Manager	P.O. Box 555	Lander	WY	82520	USA	(307) 555-4680	(307) 555-6525
SUPRD	SuprÃªmes dÃ©lices	Pascale Cartrain	Accounting Manager	Boulevard Tirou, 255	Charleroi	\N	B-6000	Belgium	(071) 23 67 22 20	(071) 23 67 22 21
THEBI	The Big Cheese	Liz Nixon	Marketing Manager	89 Jefferson Way\nSuite 2	Portland	OR	97201	USA	(503) 555-3612	\N
THECR	The Cracker Box	Liu Wong	Marketing Assistant	55 Grizzly Peak Rd.	Butte	MT	59801	USA	(406) 555-5834	(406) 555-8083
TOMSP	Toms SpezialitÃ¤ten	Karin Josephs	Marketing Manager	Luisenstr. 48	MÃ¼nster	\N	44087	Germany	0251-031259	0251-035695
TORTU	Tortuga Restaurante	Miguel Angel Paolino	Owner	Avda. Azteca 123	MÃ©xico D.F.	\N	05033	Mexico	(5) 555-2933	\N
TRADH	TradiÃ§Ã£o Hipermercados	Anabela Domingues	Sales Representative	Av. InÃªs de Castro, 414	SÃ£o Paulo	SP	05634-030	Brazil	(11) 555-2167	(11) 555-2168
TRAIH	Trail's Head Gourmet Provisioners	Helvetius Nagy	Sales Associate	722 DaVinci Blvd.	Kirkland	WA	98034	USA	(206) 555-8257	(206) 555-2174
VAFFE	Vaffeljernet	Palle Ibsen	Sales Manager	SmagslÃ¸get 45	Ã…rhus	\N	8200	Denmark	86 21 32 43	86 22 33 44
VICTE	Victuailles en stock	Mary Saveley	Sales Agent	2, rue du Commerce	Lyon	\N	69004	France	78.32.54.86	78.32.54.87
VINET	Vins et alcools Chevalier	Paul Henriot	Accounting Manager	59 rue de l'Abbaye	Reims	\N	51100	France	26.47.15.10	26.47.15.11
WANDK	Die Wandernde Kuh	Rita MÃ¼ller	Sales Representative	Adenauerallee 900	Stuttgart	\N	70563	Germany	0711-020361	0711-035428
WARTH	Wartian Herkku	Pirkko Koskitalo	Accounting Manager	Torikatu 38	Oulu	\N	90110	Finland	981-443655	981-443655
WELLI	Wellington Importadora	Paula Parente	Sales Manager	Rua do Mercado, 12	Resende	SP	08737-363	Brazil	(14) 555-8122	\N
WHITC	White Clover Markets	Karl Jablonski	Owner	305 - 14th Ave. S.\nSuite 3B	Seattle	WA	98128	USA	(206) 555-4112	(206) 555-4115
WILMK	Wilman Kala	Matti Karttunen	Owner/Marketing Assistant	Keskuskatu 45	Helsinki	\N	21240	Finland	90-224 8858	90-224 8858
WOLZA	Wolski  Zajazd	Zbyszek Piestrzeniewicz	Owner	ul. Filtrowa 68	Warszawa	\N	01-012	Poland	(26) 642-7012	(26) 642-7012
ALFKI	Alfreds Futterkiste	Maria Anders	Sales Representative	Obere Str. 57	Frankfurt	\N	12209	Germany	030-0074321	030-0076545
\.


--
-- TOC entry 3397 (class 0 OID 16397)
-- Dependencies: 218
-- Data for Name: employees; Type: TABLE DATA; Schema: northwind; Owner: -
--

COPY northwind.employees (employeeid, lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, city, region, postalcode, country, homephone, extension, reportsto, notes) FROM stdin;
1	Davolio	Nancy	Sales Representative	Ms.	1948-12-08 00:00:00	1992-05-01 00:00:00	507 - 20th Ave. E.\nApt. 2A	Seattle	WA	98122	USA	(206) 555-9857	5467	2	Education includes a BA in psychology from Colorado State University in 1970.  She also completed "The Art of the Cold Call."  Nancy is a member of Toastmasters International.
2	Fuller	Andrew	Vice President, Sales	Dr.	1952-02-19 00:00:00	1992-08-14 00:00:00	908 W. Capital Way	Tacoma	WA	98401	USA	(206) 555-9482	3457	\N	Andrew received his BTS commercial in 1974 and a Ph.D. in international marketing from the University of Dallas in 1981.  He is fluent in French and Italian and reads German.  He joined the company as a sales representative, was promoted to sales manager in January 1992 and to vice president of sales in March 1993.  Andrew is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association.
3	Leverling	Janet	Sales Representative	Ms.	1963-08-30 00:00:00	1992-04-01 00:00:00	722 Moss Bay Blvd.	Kirkland	WA	98033	USA	(206) 555-3412	3355	2	Janet has a BS degree in chemistry from Boston College (1984).  She has also completed a certificate program in food retailing management.  Janet was hired as a sales associate in 1991 and promoted to sales representative in February 1992.
4	Peacock	Margaret	Sales Representative	Mrs.	1937-09-19 00:00:00	1993-05-03 00:00:00	4110 Old Redmond Rd.	Redmond	WA	98052	USA	(206) 555-8122	5176	2	Margaret holds a BA in English literature from Concordia College (1958) and an MA from the American Institute of Culinary Arts (1966).  She was assigned to the London office temporarily from July through November 1992.
5	Buchanan	Steven	Sales Manager	Mr.	1955-03-04 00:00:00	1993-10-17 00:00:00	14 Garrett Hill	London	\N	SW1 8JR	UK	(71) 555-4848	3453	2	Steven Buchanan graduated from St. Andrews University, Scotland, with a BSC degree in 1976.  Upon joining the company as a sales representative in 1992, he spent 6 months in an orientation program at the Seattle office and then returned to his permanent post in London.  He was promoted to sales manager in March 1993.  Mr. Buchanan has completed the courses "Successful Telemarketing" and "International Sales Management."  He is fluent in French.
6	Suyama	Michael	Sales Representative	Mr.	1963-07-02 00:00:00	1993-10-17 00:00:00	Coventry House\nMiner Rd.	London	\N	EC2 7JR	UK	(71) 555-7773	428	5	Michael is a graduate of Sussex University (MA, economics, 1983) and the University of California at Los Angeles (MBA, marketing, 1986).  He has also taken the courses "Multi-Cultural Selling" and "Time Management for the Sales Professional."  He is fluent in Japanese and can read and write French, Portuguese, and Spanish.
7	King	Robert	Sales Representative	Mr.	1960-05-29 00:00:00	1994-01-02 00:00:00	Edgeham Hollow\nWinchester Way	London	\N	RG1 9SP	UK	(71) 555-5598	465	5	Robert King served in the Peace Corps and traveled extensively before completing his degree in English at the University of Michigan in 1992, the year he joined the company.  After completing a course entitled "Selling in Europe," he was transferred to the London office in March 1993.
8	Callahan	Laura	Inside Sales Coordinator	Ms.	1958-01-09 00:00:00	1994-03-05 00:00:00	4726 - 11th Ave. N.E.	Seattle	WA	98105	USA	(206) 555-1189	2344	2	Laura received a BA in psychology from the University of Washington.  She has also completed a course in business French.  She reads and writes French.
9	Dodsworth	Anne	Sales Representative	Ms.	1966-01-27 00:00:00	1994-11-15 00:00:00	7 Houndstooth Rd.	London	\N	WG2 7LT	UK	(71) 555-4444	452	5	Anne has a BA degree in English from St. Lawrence College.  She is fluent in French and German.
\.


--
-- TOC entry 3398 (class 0 OID 16402)
-- Dependencies: 219
-- Data for Name: order_details; Type: TABLE DATA; Schema: northwind; Owner: -
--

COPY northwind.order_details (orderid, productid, unitprice, quantity, discount) FROM stdin;
10248	11	14.0000	12	0.0000
10248	42	9.8000	10	0.0000
10248	72	34.8000	5	0.0000
10249	14	18.6000	9	0.0000
10249	51	42.4000	40	0.0000
10250	41	7.7000	10	0.0000
10250	51	42.4000	35	0.1500
10250	65	16.8000	15	0.1500
10251	22	16.8000	6	0.0500
10251	57	15.6000	15	0.0500
10251	65	16.8000	20	0.0000
10252	20	64.8000	40	0.0500
10252	33	2.0000	25	0.0500
10252	60	27.2000	40	0.0000
10253	31	10.0000	20	0.0000
10253	39	14.4000	42	0.0000
10253	49	16.0000	40	0.0000
10254	24	3.6000	15	0.1500
10254	55	19.2000	21	0.1500
10254	74	8.0000	21	0.0000
10255	2	15.2000	20	0.0000
10255	16	13.9000	35	0.0000
10255	36	15.2000	25	0.0000
10255	59	44.0000	30	0.0000
10256	53	26.2000	15	0.0000
10256	77	10.4000	12	0.0000
10257	27	35.1000	25	0.0000
10257	39	14.4000	6	0.0000
10257	77	10.4000	15	0.0000
10258	2	15.2000	50	0.2000
10258	5	17.0000	65	0.2000
10258	32	25.6000	6	0.2000
10259	21	8.0000	10	0.0000
10259	37	20.8000	1	0.0000
10260	41	7.7000	16	0.2500
10260	57	15.6000	50	0.0000
10260	62	39.4000	15	0.2500
10260	70	12.0000	21	0.2500
10261	21	8.0000	20	0.0000
10261	35	14.4000	20	0.0000
10262	5	17.0000	12	0.2000
10262	7	24.0000	15	0.0000
10262	56	30.4000	2	0.0000
10263	16	13.9000	60	0.2500
10263	24	3.6000	28	0.0000
10263	30	20.7000	60	0.2500
10263	74	8.0000	36	0.2500
10264	2	15.2000	35	0.0000
10264	41	7.7000	25	0.1500
10265	17	31.2000	30	0.0000
10265	70	12.0000	20	0.0000
10266	12	30.4000	12	0.0500
10267	40	14.7000	50	0.0000
10267	59	44.0000	70	0.1500
10267	76	14.4000	15	0.1500
10268	29	99.0000	10	0.0000
10268	72	27.8000	4	0.0000
10269	33	2.0000	60	0.0500
10269	72	27.8000	20	0.0500
10270	36	15.2000	30	0.0000
10270	43	36.8000	25	0.0000
10271	33	2.0000	24	0.0000
10272	20	64.8000	6	0.0000
10272	31	10.0000	40	0.0000
10272	72	27.8000	24	0.0000
10273	10	24.8000	24	0.0500
10273	31	10.0000	15	0.0500
10273	33	2.0000	20	0.0000
10273	40	14.7000	60	0.0500
10273	76	14.4000	33	0.0500
10274	71	17.2000	20	0.0000
10274	72	27.8000	7	0.0000
10275	24	3.6000	12	0.0500
10275	59	44.0000	6	0.0500
10276	10	24.8000	15	0.0000
10276	13	4.8000	10	0.0000
10277	28	36.4000	20	0.0000
10277	62	39.4000	12	0.0000
10278	44	15.5000	16	0.0000
10278	59	44.0000	15	0.0000
10278	63	35.1000	8	0.0000
10278	73	12.0000	25	0.0000
10279	17	31.2000	15	0.2500
10280	24	3.6000	12	0.0000
10280	55	19.2000	20	0.0000
10280	75	6.2000	30	0.0000
10281	19	7.3000	1	0.0000
10281	24	3.6000	6	0.0000
10281	35	14.4000	4	0.0000
10282	30	20.7000	6	0.0000
10282	57	15.6000	2	0.0000
10283	15	12.4000	20	0.0000
10283	19	7.3000	18	0.0000
10283	60	27.2000	35	0.0000
10283	72	27.8000	3	0.0000
10284	27	35.1000	15	0.2500
10284	44	15.5000	21	0.0000
10284	60	27.2000	20	0.2500
10284	67	11.2000	5	0.2500
10285	1	14.4000	45	0.2000
10285	40	14.7000	40	0.2000
10285	53	26.2000	36	0.2000
10286	35	14.4000	100	0.0000
10286	62	39.4000	40	0.0000
10287	16	13.9000	40	0.1500
10287	34	11.2000	20	0.0000
10287	46	9.6000	15	0.1500
10288	54	5.9000	10	0.1000
10288	68	10.0000	3	0.1000
10289	3	8.0000	30	0.0000
10289	64	26.6000	9	0.0000
10290	5	17.0000	20	0.0000
10290	29	99.0000	15	0.0000
10290	49	16.0000	15	0.0000
10290	77	10.4000	10	0.0000
10291	13	4.8000	20	0.1000
10291	44	15.5000	24	0.1000
10291	51	42.4000	2	0.1000
10292	20	64.8000	20	0.0000
10293	18	50.0000	12	0.0000
10293	24	3.6000	10	0.0000
10293	63	35.1000	5	0.0000
10293	75	6.2000	6	0.0000
10294	1	14.4000	18	0.0000
10294	17	31.2000	15	0.0000
10294	43	36.8000	15	0.0000
10294	60	27.2000	21	0.0000
10294	75	6.2000	6	0.0000
10295	56	30.4000	4	0.0000
10296	11	16.8000	12	0.0000
10296	16	13.9000	30	0.0000
10296	69	28.8000	15	0.0000
10297	39	14.4000	60	0.0000
10297	72	27.8000	20	0.0000
10298	2	15.2000	40	0.0000
10298	36	15.2000	40	0.2500
10298	59	44.0000	30	0.2500
10298	62	39.4000	15	0.0000
10299	19	7.3000	15	0.0000
10299	70	12.0000	20	0.0000
10300	66	13.6000	30	0.0000
10300	68	10.0000	20	0.0000
10301	40	14.7000	10	0.0000
10301	56	30.4000	20	0.0000
10302	17	31.2000	40	0.0000
10302	28	36.4000	28	0.0000
10302	43	36.8000	12	0.0000
10303	40	14.7000	40	0.1000
10303	65	16.8000	30	0.1000
10303	68	10.0000	15	0.1000
10304	49	16.0000	30	0.0000
10304	59	44.0000	10	0.0000
10304	71	17.2000	2	0.0000
10305	18	50.0000	25	0.1000
10305	29	99.0000	25	0.1000
10305	39	14.4000	30	0.1000
10306	30	20.7000	10	0.0000
10306	53	26.2000	10	0.0000
10306	54	5.9000	5	0.0000
10307	62	39.4000	10	0.0000
10307	68	10.0000	3	0.0000
10308	69	28.8000	1	0.0000
10308	70	12.0000	5	0.0000
10309	4	17.6000	20	0.0000
10309	6	20.0000	30	0.0000
10309	42	11.2000	2	0.0000
10309	43	36.8000	20	0.0000
10309	71	17.2000	3	0.0000
10310	16	13.9000	10	0.0000
10310	62	39.4000	5	0.0000
10311	42	11.2000	6	0.0000
10311	69	28.8000	7	0.0000
10312	28	36.4000	4	0.0000
10312	43	36.8000	24	0.0000
10312	53	26.2000	20	0.0000
10312	75	6.2000	10	0.0000
10313	36	15.2000	12	0.0000
10314	32	25.6000	40	0.1000
10314	58	10.6000	30	0.1000
10314	62	39.4000	25	0.1000
10315	34	11.2000	14	0.0000
10315	70	12.0000	30	0.0000
10316	41	7.7000	10	0.0000
10316	62	39.4000	70	0.0000
10317	1	14.4000	20	0.0000
10318	41	7.7000	20	0.0000
10318	76	14.4000	6	0.0000
10319	17	31.2000	8	0.0000
10319	28	36.4000	14	0.0000
10319	76	14.4000	30	0.0000
10320	71	17.2000	30	0.0000
10321	35	14.4000	10	0.0000
10322	52	5.6000	20	0.0000
10323	15	12.4000	5	0.0000
10323	25	11.2000	4	0.0000
10323	39	14.4000	4	0.0000
10324	16	13.9000	21	0.1500
10324	35	14.4000	70	0.1500
10324	46	9.6000	30	0.0000
10324	59	44.0000	40	0.1500
10324	63	35.1000	80	0.1500
10325	6	20.0000	6	0.0000
10325	13	4.8000	12	0.0000
10325	14	18.6000	9	0.0000
10325	31	10.0000	4	0.0000
10325	72	27.8000	40	0.0000
10326	4	17.6000	24	0.0000
10326	57	15.6000	16	0.0000
10326	75	6.2000	50	0.0000
10327	2	15.2000	25	0.2000
10327	11	16.8000	50	0.2000
10327	30	20.7000	35	0.2000
10327	58	10.6000	30	0.2000
10328	59	44.0000	9	0.0000
10328	65	16.8000	40	0.0000
10328	68	10.0000	10	0.0000
10329	19	7.3000	10	0.0500
10329	30	20.7000	8	0.0500
10329	38	210.8000	20	0.0500
10329	56	30.4000	12	0.0500
10331	54	5.9000	15	0.0000
10332	18	50.0000	40	0.2000
10332	42	11.2000	10	0.2000
10332	47	7.6000	16	0.2000
10333	14	18.6000	10	0.0000
10333	21	8.0000	10	0.1000
10333	71	17.2000	40	0.1000
10334	52	5.6000	8	0.0000
10334	68	10.0000	10	0.0000
10335	2	15.2000	7	0.2000
10335	31	10.0000	25	0.2000
10335	32	25.6000	6	0.2000
10335	51	42.4000	48	0.2000
10336	4	17.6000	18	0.1000
10337	23	7.2000	40	0.0000
10337	26	24.9000	24	0.0000
10337	36	15.2000	20	0.0000
10337	37	20.8000	28	0.0000
10337	72	27.8000	25	0.0000
10338	17	31.2000	20	0.0000
10338	30	20.7000	15	0.0000
10339	4	17.6000	10	0.0000
10339	17	31.2000	70	0.0500
10339	62	39.4000	28	0.0000
10340	18	50.0000	20	0.0500
10340	41	7.7000	12	0.0500
10340	43	36.8000	40	0.0500
10341	33	2.0000	8	0.0000
10341	59	44.0000	9	0.1500
10342	2	15.2000	24	0.2000
10342	31	10.0000	56	0.2000
10342	36	15.2000	40	0.2000
10342	55	19.2000	40	0.2000
10343	64	26.6000	50	0.0000
10343	68	10.0000	4	0.0500
10343	76	14.4000	15	0.0000
10344	4	17.6000	35	0.0000
10344	8	32.0000	70	0.2500
10345	8	32.0000	70	0.0000
10345	19	7.3000	80	0.0000
10345	42	11.2000	9	0.0000
10346	17	31.2000	36	0.1000
10346	56	30.4000	20	0.0000
10347	25	11.2000	10	0.0000
10347	39	14.4000	50	0.1500
10347	40	14.7000	4	0.0000
10347	75	6.2000	6	0.1500
10348	1	14.4000	15	0.1500
10348	23	7.2000	25	0.0000
10349	54	5.9000	24	0.0000
10350	50	13.0000	15	0.1000
10350	69	28.8000	18	0.1000
10351	38	210.8000	20	0.0500
10351	41	7.7000	13	0.0000
10351	44	15.5000	77	0.0500
10351	65	16.8000	10	0.0500
10352	24	3.6000	10	0.0000
10352	54	5.9000	20	0.1500
10353	11	16.8000	12	0.2000
10353	38	210.8000	50	0.2000
10354	1	14.4000	12	0.0000
10354	29	99.0000	4	0.0000
10355	24	3.6000	25	0.0000
10355	57	15.6000	25	0.0000
10356	31	10.0000	30	0.0000
10356	55	19.2000	12	0.0000
10356	69	28.8000	20	0.0000
10357	10	24.8000	30	0.2000
10357	26	24.9000	16	0.0000
10357	60	27.2000	8	0.2000
10358	24	3.6000	10	0.0500
10358	34	11.2000	10	0.0500
10358	36	15.2000	20	0.0500
10359	16	13.9000	56	0.0500
10359	31	10.0000	70	0.0500
10359	60	27.2000	80	0.0500
10360	28	36.4000	30	0.0000
10360	29	99.0000	35	0.0000
10360	38	210.8000	10	0.0000
10360	49	16.0000	35	0.0000
10360	54	5.9000	28	0.0000
10361	39	14.4000	54	0.1000
10361	60	27.2000	55	0.1000
10362	25	11.2000	50	0.0000
10362	51	42.4000	20	0.0000
10362	54	5.9000	24	0.0000
10363	31	10.0000	20	0.0000
10363	75	6.2000	12	0.0000
10363	76	14.4000	12	0.0000
10364	69	28.8000	30	0.0000
10364	71	17.2000	5	0.0000
10365	11	16.8000	24	0.0000
10366	65	16.8000	5	0.0000
10366	77	10.4000	5	0.0000
10367	34	11.2000	36	0.0000
10367	54	5.9000	18	0.0000
10367	65	16.8000	15	0.0000
10367	77	10.4000	7	0.0000
10368	21	8.0000	5	0.1000
10368	28	36.4000	13	0.1000
10368	57	15.6000	25	0.0000
10368	64	26.6000	35	0.1000
10369	29	99.0000	20	0.0000
10369	56	30.4000	18	0.2500
10370	1	14.4000	15	0.1500
10370	64	26.6000	30	0.0000
10370	74	8.0000	20	0.1500
10371	36	15.2000	6	0.2000
10372	20	64.8000	12	0.2500
10372	38	210.8000	40	0.2500
10372	60	27.2000	70	0.2500
10372	72	27.8000	42	0.2500
10373	58	10.6000	80	0.2000
10373	71	17.2000	50	0.2000
10374	31	10.0000	30	0.0000
10374	58	10.6000	15	0.0000
10375	14	18.6000	15	0.0000
10375	54	5.9000	10	0.0000
10376	31	10.0000	42	0.0500
10377	28	36.4000	20	0.1500
10377	39	14.4000	20	0.1500
10378	71	17.2000	6	0.0000
10379	41	7.7000	8	0.1000
10379	63	35.1000	16	0.1000
10379	65	16.8000	20	0.1000
10380	30	20.7000	18	0.1000
10380	53	26.2000	20	0.1000
10380	60	27.2000	6	0.1000
10380	70	12.0000	30	0.0000
10381	74	8.0000	14	0.0000
10382	5	17.0000	32	0.0000
10382	18	50.0000	9	0.0000
10382	29	99.0000	14	0.0000
10382	33	2.0000	60	0.0000
10382	74	8.0000	50	0.0000
10383	13	4.8000	20	0.0000
10383	50	13.0000	15	0.0000
10383	56	30.4000	20	0.0000
10384	20	64.8000	28	0.0000
10384	60	27.2000	15	0.0000
10385	7	24.0000	10	0.2000
10385	60	27.2000	20	0.2000
10385	68	10.0000	8	0.2000
10386	24	3.6000	15	0.0000
10386	34	11.2000	10	0.0000
10387	24	3.6000	15	0.0000
10387	28	36.4000	6	0.0000
10387	59	44.0000	12	0.0000
10387	71	17.2000	15	0.0000
10388	45	7.6000	15	0.2000
10388	52	5.6000	20	0.2000
10388	53	26.2000	40	0.0000
10389	10	24.8000	16	0.0000
10389	55	19.2000	15	0.0000
10389	62	39.4000	20	0.0000
10389	70	12.0000	30	0.0000
10390	31	10.0000	60	0.1000
10390	35	14.4000	40	0.1000
10390	46	9.6000	45	0.0000
10390	72	27.8000	24	0.1000
10391	13	4.8000	18	0.0000
10392	69	28.8000	50	0.0000
10393	2	15.2000	25	0.2500
10393	14	18.6000	42	0.2500
10393	25	11.2000	7	0.2500
10393	26	24.9000	70	0.2500
10393	31	10.0000	32	0.0000
10394	13	4.8000	10	0.0000
10394	62	39.4000	10	0.0000
10395	46	9.6000	28	0.1000
10395	53	26.2000	70	0.1000
10395	69	28.8000	8	0.0000
10396	23	7.2000	40	0.0000
10396	71	17.2000	60	0.0000
10396	72	27.8000	21	0.0000
10397	21	8.0000	10	0.1500
10397	51	42.4000	18	0.1500
10398	35	14.4000	30	0.0000
10398	55	19.2000	120	0.1000
10399	68	10.0000	60	0.0000
10399	71	17.2000	30	0.0000
10399	76	14.4000	35	0.0000
10399	77	10.4000	14	0.0000
10400	29	99.0000	21	0.0000
10400	35	14.4000	35	0.0000
10400	49	16.0000	30	0.0000
10401	30	20.7000	18	0.0000
10401	56	30.4000	70	0.0000
10401	65	16.8000	20	0.0000
10401	71	17.2000	60	0.0000
10402	23	7.2000	60	0.0000
10402	63	35.1000	65	0.0000
11069	39	18.0000	20	0.0000
10403	16	13.9000	21	0.1500
10403	48	10.2000	70	0.1500
10404	26	24.9000	30	0.0500
10404	42	11.2000	40	0.0500
10404	49	16.0000	30	0.0500
10405	3	8.0000	50	0.0000
10406	1	14.4000	10	0.0000
10406	21	8.0000	30	0.1000
10406	28	36.4000	42	0.1000
10406	36	15.2000	5	0.1000
10406	40	14.7000	2	0.1000
10407	11	16.8000	30	0.0000
10407	69	28.8000	15	0.0000
10407	71	17.2000	15	0.0000
10408	37	20.8000	10	0.0000
10408	54	5.9000	6	0.0000
10408	62	39.4000	35	0.0000
10409	14	18.6000	12	0.0000
10409	21	8.0000	12	0.0000
10410	33	2.0000	49	0.0000
10410	59	44.0000	16	0.0000
10411	41	7.7000	25	0.2000
10411	44	15.5000	40	0.2000
10411	59	44.0000	9	0.2000
10412	14	18.6000	20	0.1000
10413	1	14.4000	24	0.0000
10413	62	39.4000	40	0.0000
10413	76	14.4000	14	0.0000
10414	19	7.3000	18	0.0500
10414	33	2.0000	50	0.0000
10415	17	31.2000	2	0.0000
10415	33	2.0000	20	0.0000
10416	19	7.3000	20	0.0000
10416	53	26.2000	10	0.0000
10416	57	15.6000	20	0.0000
10417	38	210.8000	50	0.0000
10417	46	9.6000	2	0.2500
10417	68	10.0000	36	0.2500
10417	77	10.4000	35	0.0000
10418	2	15.2000	60	0.0000
10418	47	7.6000	55	0.0000
10418	61	22.8000	16	0.0000
10418	74	8.0000	15	0.0000
10419	60	27.2000	60	0.0500
10419	69	28.8000	20	0.0500
10420	9	77.6000	20	0.1000
10420	13	4.8000	2	0.1000
10420	70	12.0000	8	0.1000
10420	73	12.0000	20	0.1000
10421	19	7.3000	4	0.1500
10421	26	24.9000	30	0.0000
10421	53	26.2000	15	0.1500
10421	77	10.4000	10	0.1500
10422	26	24.9000	2	0.0000
10423	31	10.0000	14	0.0000
10423	59	44.0000	20	0.0000
10424	35	14.4000	60	0.2000
10424	38	210.8000	49	0.2000
10424	68	10.0000	30	0.2000
10425	55	19.2000	10	0.2500
10425	76	14.4000	20	0.2500
10426	56	30.4000	5	0.0000
10426	64	26.6000	7	0.0000
10427	14	18.6000	35	0.0000
10428	46	9.6000	20	0.0000
10429	50	13.0000	40	0.0000
10429	63	35.1000	35	0.2500
10430	17	31.2000	45	0.2000
10430	21	8.0000	50	0.0000
10430	56	30.4000	30	0.0000
10430	59	44.0000	70	0.2000
10431	17	31.2000	50	0.2500
10431	40	14.7000	50	0.2500
10431	47	7.6000	30	0.2500
10432	26	24.9000	10	0.0000
10432	54	5.9000	40	0.0000
10433	56	30.4000	28	0.0000
10434	11	16.8000	6	0.0000
10434	76	14.4000	18	0.1500
10435	2	15.2000	10	0.0000
10435	22	16.8000	12	0.0000
10435	72	27.8000	10	0.0000
10436	46	9.6000	5	0.0000
10436	56	30.4000	40	0.1000
10436	64	26.6000	30	0.1000
10436	75	6.2000	24	0.1000
10437	53	26.2000	15	0.0000
10438	19	7.3000	15	0.2000
10438	34	11.2000	20	0.2000
10438	57	15.6000	15	0.2000
10439	12	30.4000	15	0.0000
10439	16	13.9000	16	0.0000
10439	64	26.6000	6	0.0000
10439	74	8.0000	30	0.0000
10440	2	15.2000	45	0.1500
10440	16	13.9000	49	0.1500
10440	29	99.0000	24	0.1500
10440	61	22.8000	90	0.1500
10441	27	35.1000	50	0.0000
10442	11	16.8000	30	0.0000
10442	54	5.9000	80	0.0000
10442	66	13.6000	60	0.0000
10443	11	16.8000	6	0.2000
10443	28	36.4000	12	0.0000
10444	17	31.2000	10	0.0000
10444	26	24.9000	15	0.0000
10444	35	14.4000	8	0.0000
10444	41	7.7000	30	0.0000
10445	39	14.4000	6	0.0000
10445	54	5.9000	15	0.0000
10446	19	7.3000	12	0.1000
10446	24	3.6000	20	0.1000
10446	31	10.0000	3	0.1000
10446	52	5.6000	15	0.1000
10447	19	7.3000	40	0.0000
10447	65	16.8000	35	0.0000
10447	71	17.2000	2	0.0000
10448	26	24.9000	6	0.0000
10448	40	14.7000	20	0.0000
10449	10	24.8000	14	0.0000
10449	52	5.6000	20	0.0000
10449	62	39.4000	35	0.0000
10450	10	24.8000	20	0.2000
10450	54	5.9000	6	0.2000
10451	55	19.2000	120	0.1000
10451	64	26.6000	35	0.1000
10451	65	16.8000	28	0.1000
10451	77	10.4000	55	0.1000
10452	28	36.4000	15	0.0000
10452	44	15.5000	100	0.0500
10453	48	10.2000	15	0.1000
10453	70	12.0000	25	0.1000
10454	16	13.9000	20	0.2000
10454	33	2.0000	20	0.2000
10454	46	9.6000	10	0.2000
10455	39	14.4000	20	0.0000
10455	53	26.2000	50	0.0000
10455	61	22.8000	25	0.0000
10455	71	17.2000	30	0.0000
10456	21	8.0000	40	0.1500
10456	49	16.0000	21	0.1500
10457	59	44.0000	36	0.0000
10458	26	24.9000	30	0.0000
10458	28	36.4000	30	0.0000
10458	43	36.8000	20	0.0000
10458	56	30.4000	15	0.0000
10458	71	17.2000	50	0.0000
10459	7	24.0000	16	0.0500
10459	46	9.6000	20	0.0500
10459	72	27.8000	40	0.0000
10460	68	10.0000	21	0.2500
10460	75	6.2000	4	0.2500
10461	21	8.0000	40	0.2500
10461	30	20.7000	28	0.2500
10461	55	19.2000	60	0.2500
10462	13	4.8000	1	0.0000
10462	23	7.2000	21	0.0000
10463	19	7.3000	21	0.0000
10463	42	11.2000	50	0.0000
10464	4	17.6000	16	0.2000
10464	43	36.8000	3	0.0000
10464	56	30.4000	30	0.2000
10464	60	27.2000	20	0.0000
10465	24	3.6000	25	0.0000
10465	29	99.0000	18	0.1000
10465	40	14.7000	20	0.0000
10465	45	7.6000	30	0.1000
10465	50	13.0000	25	0.0000
10466	11	16.8000	10	0.0000
10466	46	9.6000	5	0.0000
10467	24	3.6000	28	0.0000
10467	25	11.2000	12	0.0000
10468	30	20.7000	8	0.0000
10468	43	36.8000	15	0.0000
10469	2	15.2000	40	0.1500
10469	16	13.9000	35	0.1500
10469	44	15.5000	2	0.1500
10470	18	50.0000	30	0.0000
10470	23	7.2000	15	0.0000
10470	64	26.6000	8	0.0000
10471	7	24.0000	30	0.0000
10471	56	30.4000	20	0.0000
10472	24	3.6000	80	0.0500
10472	51	42.4000	18	0.0000
10473	33	2.0000	12	0.0000
10473	71	17.2000	12	0.0000
10474	14	18.6000	12	0.0000
10474	28	36.4000	18	0.0000
10474	40	14.7000	21	0.0000
10474	75	6.2000	10	0.0000
10475	31	10.0000	35	0.1500
10475	66	13.6000	60	0.1500
10475	76	14.4000	42	0.1500
10476	55	19.2000	2	0.0500
10476	70	12.0000	12	0.0000
10477	1	14.4000	15	0.0000
10477	21	8.0000	21	0.2500
10477	39	14.4000	20	0.2500
10478	10	24.8000	20	0.0500
10479	38	210.8000	30	0.0000
10479	53	26.2000	28	0.0000
10479	59	44.0000	60	0.0000
10479	64	26.6000	30	0.0000
10480	47	7.6000	30	0.0000
10480	59	44.0000	12	0.0000
10481	49	16.0000	24	0.0000
10481	60	27.2000	40	0.0000
10482	40	14.7000	10	0.0000
10483	34	11.2000	35	0.0500
10483	77	10.4000	30	0.0500
10484	21	8.0000	14	0.0000
10484	40	14.7000	10	0.0000
10484	51	42.4000	3	0.0000
10485	2	15.2000	20	0.1000
10485	3	8.0000	20	0.1000
10485	55	19.2000	30	0.1000
10485	70	12.0000	60	0.1000
10486	11	16.8000	5	0.0000
10486	51	42.4000	25	0.0000
10486	74	8.0000	16	0.0000
10487	19	7.3000	5	0.0000
10487	26	24.9000	30	0.0000
10487	54	5.9000	24	0.2500
10488	59	44.0000	30	0.0000
10488	73	12.0000	20	0.2000
10489	11	16.8000	15	0.2500
10489	16	13.9000	18	0.0000
10490	59	44.0000	60	0.0000
10490	68	10.0000	30	0.0000
10490	75	6.2000	36	0.0000
10491	44	15.5000	15	0.1500
10491	77	10.4000	7	0.1500
10492	25	11.2000	60	0.0500
10492	42	11.2000	20	0.0500
10493	65	16.8000	15	0.1000
10493	66	13.6000	10	0.1000
10493	69	28.8000	10	0.1000
10494	56	30.4000	30	0.0000
10495	23	7.2000	10	0.0000
10495	41	7.7000	20	0.0000
10495	77	10.4000	5	0.0000
10496	31	10.0000	20	0.0500
10497	56	30.4000	14	0.0000
10497	72	27.8000	25	0.0000
10497	77	10.4000	25	0.0000
10498	24	4.5000	14	0.0000
10498	40	18.4000	5	0.0000
10498	42	14.0000	30	0.0000
10499	28	45.6000	20	0.0000
10499	49	20.0000	25	0.0000
10500	15	15.5000	12	0.0500
10500	28	45.6000	8	0.0500
10501	54	7.4500	20	0.0000
10502	45	9.5000	21	0.0000
10502	53	32.8000	6	0.0000
10502	67	14.0000	30	0.0000
10503	14	23.2500	70	0.0000
10503	65	21.0500	20	0.0000
10504	2	19.0000	12	0.0000
10504	21	10.0000	12	0.0000
10504	53	32.8000	10	0.0000
10504	61	28.5000	25	0.0000
10505	62	49.3000	3	0.0000
10506	25	14.0000	18	0.1000
10506	70	15.0000	14	0.1000
10507	43	46.0000	15	0.1500
10507	48	12.7500	15	0.1500
10508	13	6.0000	10	0.0000
10508	39	18.0000	10	0.0000
10509	28	45.6000	3	0.0000
10510	29	123.7900	36	0.0000
10510	75	7.7500	36	0.1000
10511	4	22.0000	50	0.1500
10511	7	30.0000	50	0.1500
10511	8	40.0000	10	0.1500
10512	24	4.5000	10	0.1500
10512	46	12.0000	9	0.1500
10512	47	9.5000	6	0.1500
10512	60	34.0000	12	0.1500
10513	21	10.0000	40	0.2000
10513	32	32.0000	50	0.2000
10513	61	28.5000	15	0.2000
10514	20	81.0000	39	0.0000
10514	28	45.6000	35	0.0000
10514	56	38.0000	70	0.0000
10514	65	21.0500	39	0.0000
10514	75	7.7500	50	0.0000
10515	9	97.0000	16	0.1500
10515	16	17.4500	50	0.0000
10515	27	43.9000	120	0.0000
10515	33	2.5000	16	0.1500
10515	60	34.0000	84	0.1500
10516	18	62.5000	25	0.1000
10516	41	9.6500	80	0.1000
10516	42	14.0000	20	0.0000
10517	52	7.0000	6	0.0000
10517	59	55.0000	4	0.0000
10517	70	15.0000	6	0.0000
10518	24	4.5000	5	0.0000
10518	38	263.5000	15	0.0000
10518	44	19.4500	9	0.0000
10519	10	31.0000	16	0.0500
10519	56	38.0000	40	0.0000
10519	60	34.0000	10	0.0500
10520	24	4.5000	8	0.0000
10520	53	32.8000	5	0.0000
10521	35	18.0000	3	0.0000
10521	41	9.6500	10	0.0000
10521	68	12.5000	6	0.0000
10522	1	18.0000	40	0.2000
10522	8	40.0000	24	0.0000
10522	30	25.8900	20	0.2000
10522	40	18.4000	25	0.2000
10523	17	39.0000	25	0.1000
10523	20	81.0000	15	0.1000
10523	37	26.0000	18	0.1000
10523	41	9.6500	6	0.1000
10524	10	31.0000	2	0.0000
10524	30	25.8900	10	0.0000
10524	43	46.0000	60	0.0000
10524	54	7.4500	15	0.0000
10525	36	19.0000	30	0.0000
10525	40	18.4000	15	0.1000
10526	1	18.0000	8	0.1500
10526	13	6.0000	10	0.0000
10526	56	38.0000	30	0.1500
10527	4	22.0000	50	0.1000
10527	36	19.0000	30	0.1000
10528	11	21.0000	3	0.0000
10528	33	2.5000	8	0.2000
10528	72	34.8000	9	0.0000
10529	55	24.0000	14	0.0000
10529	68	12.5000	20	0.0000
10529	69	36.0000	10	0.0000
10530	17	39.0000	40	0.0000
10530	43	46.0000	25	0.0000
10530	61	28.5000	20	0.0000
10530	76	18.0000	50	0.0000
10531	59	55.0000	2	0.0000
10532	30	25.8900	15	0.0000
10532	66	17.0000	24	0.0000
10533	4	22.0000	50	0.0500
10533	72	34.8000	24	0.0000
10533	73	15.0000	24	0.0500
10534	30	25.8900	10	0.0000
10534	40	18.4000	10	0.2000
10534	54	7.4500	10	0.2000
10535	11	21.0000	50	0.1000
10535	40	18.4000	10	0.1000
10535	57	19.5000	5	0.1000
10535	59	55.0000	15	0.1000
10536	12	38.0000	15	0.2500
10536	31	12.5000	20	0.0000
10536	33	2.5000	30	0.0000
10536	60	34.0000	35	0.2500
10537	31	12.5000	30	0.0000
10537	51	53.0000	6	0.0000
10537	58	13.2500	20	0.0000
10537	72	34.8000	21	0.0000
10537	73	15.0000	9	0.0000
10538	70	15.0000	7	0.0000
10538	72	34.8000	1	0.0000
10539	13	6.0000	8	0.0000
10539	21	10.0000	15	0.0000
10539	33	2.5000	15	0.0000
10539	49	20.0000	6	0.0000
10540	3	10.0000	60	0.0000
10540	26	31.2300	40	0.0000
10540	38	263.5000	30	0.0000
10540	68	12.5000	35	0.0000
10541	24	4.5000	35	0.1000
10541	38	263.5000	4	0.1000
10541	65	21.0500	36	0.1000
10541	71	21.5000	9	0.1000
10542	11	21.0000	15	0.0500
10542	54	7.4500	24	0.0500
10543	12	38.0000	30	0.1500
10543	23	9.0000	70	0.1500
10544	28	45.6000	7	0.0000
10544	67	14.0000	7	0.0000
10545	11	21.0000	10	0.0000
10546	7	30.0000	10	0.0000
10546	35	18.0000	30	0.0000
10546	62	49.3000	40	0.0000
10547	32	32.0000	24	0.1500
10547	36	19.0000	60	0.0000
10548	34	14.0000	10	0.2500
10548	41	9.6500	14	0.0000
10549	31	12.5000	55	0.1500
10549	45	9.5000	100	0.1500
10549	51	53.0000	48	0.1500
10550	17	39.0000	8	0.1000
10550	19	9.2000	10	0.0000
10550	21	10.0000	6	0.1000
10550	61	28.5000	10	0.1000
10551	16	17.4500	40	0.1500
10551	35	18.0000	20	0.1500
10551	44	19.4500	40	0.0000
10552	69	36.0000	18	0.0000
10552	75	7.7500	30	0.0000
10553	11	21.0000	15	0.0000
10553	16	17.4500	14	0.0000
10553	22	21.0000	24	0.0000
10553	31	12.5000	30	0.0000
10553	35	18.0000	6	0.0000
10554	16	17.4500	30	0.0500
10554	23	9.0000	20	0.0500
10554	62	49.3000	20	0.0500
10554	77	13.0000	10	0.0500
10555	14	23.2500	30	0.2000
10555	19	9.2000	35	0.2000
10555	24	4.5000	18	0.2000
10555	51	53.0000	20	0.2000
10555	56	38.0000	40	0.2000
10556	72	34.8000	24	0.0000
10557	64	33.2500	30	0.0000
10557	75	7.7500	20	0.0000
10558	47	9.5000	25	0.0000
10558	51	53.0000	20	0.0000
10558	52	7.0000	30	0.0000
10558	53	32.8000	18	0.0000
10558	73	15.0000	3	0.0000
10559	41	9.6500	12	0.0500
10559	55	24.0000	18	0.0500
10560	30	25.8900	20	0.0000
10560	62	49.3000	15	0.2500
10561	44	19.4500	10	0.0000
10561	51	53.0000	50	0.0000
10562	33	2.5000	20	0.1000
10562	62	49.3000	10	0.1000
10563	36	19.0000	25	0.0000
10563	52	7.0000	70	0.0000
10564	17	39.0000	16	0.0500
10564	31	12.5000	6	0.0500
10564	55	24.0000	25	0.0500
10565	24	4.5000	25	0.1000
10565	64	33.2500	18	0.1000
10566	11	21.0000	35	0.1500
10566	18	62.5000	18	0.1500
10566	76	18.0000	10	0.0000
10567	31	12.5000	60	0.2000
10567	51	53.0000	3	0.0000
10567	59	55.0000	40	0.2000
10568	10	31.0000	5	0.0000
10569	31	12.5000	35	0.2000
10569	76	18.0000	30	0.0000
10570	11	21.0000	15	0.0500
10570	56	38.0000	60	0.0500
10571	14	23.2500	11	0.1500
10571	42	14.0000	28	0.1500
10572	16	17.4500	12	0.1000
10572	32	32.0000	10	0.1000
10572	40	18.4000	50	0.0000
10572	75	7.7500	15	0.1000
10573	17	39.0000	18	0.0000
10573	34	14.0000	40	0.0000
10573	53	32.8000	25	0.0000
10574	33	2.5000	14	0.0000
10574	40	18.4000	2	0.0000
10574	62	49.3000	10	0.0000
10574	64	33.2500	6	0.0000
10575	59	55.0000	12	0.0000
10575	63	43.9000	6	0.0000
10575	72	34.8000	30	0.0000
10575	76	18.0000	10	0.0000
10576	1	18.0000	10	0.0000
10576	31	12.5000	20	0.0000
10576	44	19.4500	21	0.0000
10577	39	18.0000	10	0.0000
10577	75	7.7500	20	0.0000
10577	77	13.0000	18	0.0000
10578	35	18.0000	20	0.0000
10578	57	19.5000	6	0.0000
10579	15	15.5000	10	0.0000
10579	75	7.7500	21	0.0000
10580	14	23.2500	15	0.0500
10580	41	9.6500	9	0.0500
10580	65	21.0500	30	0.0500
10581	75	7.7500	50	0.2000
10582	57	19.5000	4	0.0000
10582	76	18.0000	14	0.0000
10583	29	123.7900	10	0.0000
10583	60	34.0000	24	0.1500
10583	69	36.0000	10	0.1500
10584	31	12.5000	50	0.0500
10585	47	9.5000	15	0.0000
10586	52	7.0000	4	0.1500
10587	26	31.2300	6	0.0000
10587	35	18.0000	20	0.0000
10587	77	13.0000	20	0.0000
10588	18	62.5000	40	0.2000
10588	42	14.0000	100	0.2000
10589	35	18.0000	4	0.0000
10590	1	18.0000	20	0.0000
10590	77	13.0000	60	0.0500
10591	3	10.0000	14	0.0000
10591	7	30.0000	10	0.0000
10591	54	7.4500	50	0.0000
10592	15	15.5000	25	0.0500
10592	26	31.2300	5	0.0500
10593	20	81.0000	21	0.2000
10593	69	36.0000	20	0.2000
10593	76	18.0000	4	0.2000
10594	52	7.0000	24	0.0000
10594	58	13.2500	30	0.0000
10595	35	18.0000	30	0.2500
10595	61	28.5000	120	0.2500
10595	69	36.0000	65	0.2500
10596	56	38.0000	5	0.2000
10596	63	43.9000	24	0.2000
10596	75	7.7500	30	0.2000
10597	24	4.5000	35	0.2000
10597	57	19.5000	20	0.0000
10597	65	21.0500	12	0.2000
10598	27	43.9000	50	0.0000
10598	71	21.5000	9	0.0000
10599	62	49.3000	10	0.0000
10600	54	7.4500	4	0.0000
10600	73	15.0000	30	0.0000
10601	13	6.0000	60	0.0000
10601	59	55.0000	35	0.0000
10602	77	13.0000	5	0.2500
10603	22	21.0000	48	0.0000
10603	49	20.0000	25	0.0500
10604	48	12.7500	6	0.1000
10604	76	18.0000	10	0.1000
10605	16	17.4500	30	0.0500
10605	59	55.0000	20	0.0500
10605	60	34.0000	70	0.0500
10605	71	21.5000	15	0.0500
10606	4	22.0000	20	0.2000
10606	55	24.0000	20	0.2000
10606	62	49.3000	10	0.2000
10607	7	30.0000	45	0.0000
10607	17	39.0000	100	0.0000
10607	33	2.5000	14	0.0000
10607	40	18.4000	42	0.0000
10607	72	34.8000	12	0.0000
10608	56	38.0000	28	0.0000
10609	1	18.0000	3	0.0000
10609	10	31.0000	10	0.0000
10609	21	10.0000	6	0.0000
10610	36	19.0000	21	0.2500
10611	1	18.0000	6	0.0000
10611	2	19.0000	10	0.0000
10611	60	34.0000	15	0.0000
10612	10	31.0000	70	0.0000
10612	36	19.0000	55	0.0000
10612	49	20.0000	18	0.0000
10612	60	34.0000	40	0.0000
10612	76	18.0000	80	0.0000
10613	13	6.0000	8	0.1000
10613	75	7.7500	40	0.0000
10614	11	21.0000	14	0.0000
10614	21	10.0000	8	0.0000
10614	39	18.0000	5	0.0000
10615	55	24.0000	5	0.0000
10616	38	263.5000	15	0.0500
10616	56	38.0000	14	0.0000
10616	70	15.0000	15	0.0500
10616	71	21.5000	15	0.0500
10617	59	55.0000	30	0.1500
10618	6	25.0000	70	0.0000
10618	56	38.0000	20	0.0000
10618	68	12.5000	15	0.0000
10619	21	10.0000	42	0.0000
10619	22	21.0000	40	0.0000
10620	24	4.5000	5	0.0000
10620	52	7.0000	5	0.0000
10621	19	9.2000	5	0.0000
10621	23	9.0000	10	0.0000
10621	70	15.0000	20	0.0000
10621	71	21.5000	15	0.0000
10622	2	19.0000	20	0.0000
10622	68	12.5000	18	0.2000
10623	14	23.2500	21	0.0000
10623	19	9.2000	15	0.1000
10623	21	10.0000	25	0.1000
10623	24	4.5000	3	0.0000
10623	35	18.0000	30	0.1000
10624	28	45.6000	10	0.0000
10624	29	123.7900	6	0.0000
10624	44	19.4500	10	0.0000
10625	14	23.2500	3	0.0000
10625	42	14.0000	5	0.0000
10625	60	34.0000	10	0.0000
10626	53	32.8000	12	0.0000
10626	60	34.0000	20	0.0000
10626	71	21.5000	20	0.0000
10627	62	49.3000	15	0.0000
10627	73	15.0000	35	0.1500
10628	1	18.0000	25	0.0000
10629	29	123.7900	20	0.0000
10629	64	33.2500	9	0.0000
10630	55	24.0000	12	0.0500
10630	76	18.0000	35	0.0000
10631	75	7.7500	8	0.1000
10632	2	19.0000	30	0.0500
10632	33	2.5000	20	0.0500
10633	12	38.0000	36	0.1500
10633	13	6.0000	13	0.1500
10633	26	31.2300	35	0.1500
10633	62	49.3000	80	0.1500
10634	7	30.0000	35	0.0000
10634	18	62.5000	50	0.0000
10634	51	53.0000	15	0.0000
10634	75	7.7500	2	0.0000
10635	4	22.0000	10	0.1000
10635	5	21.3500	15	0.1000
10635	22	21.0000	40	0.0000
10636	4	22.0000	25	0.0000
10636	58	13.2500	6	0.0000
10637	11	21.0000	10	0.0000
10637	50	16.2500	25	0.0500
10637	56	38.0000	60	0.0500
10638	45	9.5000	20	0.0000
10638	65	21.0500	21	0.0000
10638	72	34.8000	60	0.0000
10639	18	62.5000	8	0.0000
10640	69	36.0000	20	0.2500
10640	70	15.0000	15	0.2500
10641	2	19.0000	50	0.0000
10641	40	18.4000	60	0.0000
10642	21	10.0000	30	0.2000
10642	61	28.5000	20	0.2000
10643	28	45.6000	15	0.2500
10643	39	18.0000	21	0.2500
10643	46	12.0000	2	0.2500
10644	18	62.5000	4	0.1000
10644	43	46.0000	20	0.0000
10644	46	12.0000	21	0.1000
10645	18	62.5000	20	0.0000
10645	36	19.0000	15	0.0000
10646	1	18.0000	15	0.2500
10646	10	31.0000	18	0.2500
10646	71	21.5000	30	0.2500
10646	77	13.0000	35	0.2500
10647	19	9.2000	30	0.0000
10647	39	18.0000	20	0.0000
10648	22	21.0000	15	0.0000
10648	24	4.5000	15	0.1500
10649	28	45.6000	20	0.0000
10649	72	34.8000	15	0.0000
10650	30	25.8900	30	0.0000
10650	53	32.8000	25	0.0500
10650	54	7.4500	30	0.0000
10651	19	9.2000	12	0.2500
10651	22	21.0000	20	0.2500
10652	30	25.8900	2	0.2500
10652	42	14.0000	20	0.0000
10653	16	17.4500	30	0.1000
10653	60	34.0000	20	0.1000
10654	4	22.0000	12	0.1000
10654	39	18.0000	20	0.1000
10654	54	7.4500	6	0.1000
10655	41	9.6500	20	0.2000
10656	14	23.2500	3	0.1000
10656	44	19.4500	28	0.1000
10656	47	9.5000	6	0.1000
10657	15	15.5000	50	0.0000
10657	41	9.6500	24	0.0000
10657	46	12.0000	45	0.0000
10657	47	9.5000	10	0.0000
10657	56	38.0000	45	0.0000
10657	60	34.0000	30	0.0000
10658	21	10.0000	60	0.0000
10658	40	18.4000	70	0.0500
10658	60	34.0000	55	0.0500
10658	77	13.0000	70	0.0500
10659	31	12.5000	20	0.0500
10659	40	18.4000	24	0.0500
10659	70	15.0000	40	0.0500
10660	20	81.0000	21	0.0000
10661	39	18.0000	3	0.2000
10661	58	13.2500	49	0.2000
10662	68	12.5000	10	0.0000
10663	40	18.4000	30	0.0500
10663	42	14.0000	30	0.0500
10663	51	53.0000	20	0.0500
10664	10	31.0000	24	0.1500
10664	56	38.0000	12	0.1500
10664	65	21.0500	15	0.1500
10665	51	53.0000	20	0.0000
10665	59	55.0000	1	0.0000
10665	76	18.0000	10	0.0000
10666	29	123.7900	36	0.0000
10666	65	21.0500	10	0.0000
10667	69	36.0000	45	0.2000
10667	71	21.5000	14	0.2000
10668	31	12.5000	8	0.1000
10668	55	24.0000	4	0.1000
10668	64	33.2500	15	0.1000
10669	36	19.0000	30	0.0000
10670	23	9.0000	32	0.0000
10670	46	12.0000	60	0.0000
10670	67	14.0000	25	0.0000
10670	73	15.0000	50	0.0000
10670	75	7.7500	25	0.0000
10671	16	17.4500	10	0.0000
10671	62	49.3000	10	0.0000
10671	65	21.0500	12	0.0000
10672	38	263.5000	15	0.1000
10672	71	21.5000	12	0.0000
10673	16	17.4500	3	0.0000
10673	42	14.0000	6	0.0000
10673	43	46.0000	6	0.0000
10674	23	9.0000	5	0.0000
10675	14	23.2500	30	0.0000
10675	53	32.8000	10	0.0000
10675	58	13.2500	30	0.0000
10676	10	31.0000	2	0.0000
10676	19	9.2000	7	0.0000
10676	44	19.4500	21	0.0000
10677	26	31.2300	30	0.1500
10677	33	2.5000	8	0.1500
10678	12	38.0000	100	0.0000
10678	33	2.5000	30	0.0000
10678	41	9.6500	120	0.0000
10678	54	7.4500	30	0.0000
10679	59	55.0000	12	0.0000
10680	16	17.4500	50	0.2500
10680	31	12.5000	20	0.2500
10680	42	14.0000	40	0.2500
10681	19	9.2000	30	0.1000
10681	21	10.0000	12	0.1000
10681	64	33.2500	28	0.0000
10682	33	2.5000	30	0.0000
10682	66	17.0000	4	0.0000
10682	75	7.7500	30	0.0000
10683	52	7.0000	9	0.0000
10684	40	18.4000	20	0.0000
10684	47	9.5000	40	0.0000
10684	60	34.0000	30	0.0000
10685	10	31.0000	20	0.0000
10685	41	9.6500	4	0.0000
10685	47	9.5000	15	0.0000
10686	17	39.0000	30	0.2000
10686	26	31.2300	15	0.0000
10687	9	97.0000	50	0.2500
10687	29	123.7900	10	0.0000
10687	36	19.0000	6	0.2500
10688	10	31.0000	18	0.1000
10688	28	45.6000	60	0.1000
10688	34	14.0000	14	0.0000
10689	1	18.0000	35	0.2500
10690	56	38.0000	20	0.2500
10690	77	13.0000	30	0.2500
10691	1	18.0000	30	0.0000
10691	29	123.7900	40	0.0000
10691	43	46.0000	40	0.0000
10691	44	19.4500	24	0.0000
10691	62	49.3000	48	0.0000
10692	63	43.9000	20	0.0000
10693	9	97.0000	6	0.0000
10693	54	7.4500	60	0.1500
10693	69	36.0000	30	0.1500
10693	73	15.0000	15	0.1500
10694	7	30.0000	90	0.0000
10694	59	55.0000	25	0.0000
10694	70	15.0000	50	0.0000
10695	8	40.0000	10	0.0000
10695	12	38.0000	4	0.0000
10695	24	4.5000	20	0.0000
10696	17	39.0000	20	0.0000
10696	46	12.0000	18	0.0000
10697	19	9.2000	7	0.2500
10697	35	18.0000	9	0.2500
10697	58	13.2500	30	0.2500
10697	70	15.0000	30	0.2500
10698	11	21.0000	15	0.0000
10698	17	39.0000	8	0.0500
10698	29	123.7900	12	0.0500
10698	65	21.0500	65	0.0500
10698	70	15.0000	8	0.0500
10699	47	9.5000	12	0.0000
10700	1	18.0000	5	0.2000
10700	34	14.0000	12	0.2000
10700	68	12.5000	40	0.2000
10700	71	21.5000	60	0.2000
10701	59	55.0000	42	0.1500
10701	71	21.5000	20	0.1500
10701	76	18.0000	35	0.1500
10702	3	10.0000	6	0.0000
10702	76	18.0000	15	0.0000
10703	2	19.0000	5	0.0000
10703	59	55.0000	35	0.0000
10703	73	15.0000	35	0.0000
10704	4	22.0000	6	0.0000
10704	24	4.5000	35	0.0000
10704	48	12.7500	24	0.0000
10705	31	12.5000	20	0.0000
10705	32	32.0000	4	0.0000
10706	16	17.4500	20	0.0000
10706	43	46.0000	24	0.0000
10706	59	55.0000	8	0.0000
10707	55	24.0000	21	0.0000
10707	57	19.5000	40	0.0000
10707	70	15.0000	28	0.1500
10708	5	21.3500	4	0.0000
10708	36	19.0000	5	0.0000
10709	8	40.0000	40	0.0000
10709	51	53.0000	28	0.0000
10709	60	34.0000	10	0.0000
10710	19	9.2000	5	0.0000
10710	47	9.5000	5	0.0000
10711	19	9.2000	12	0.0000
10711	41	9.6500	42	0.0000
10711	53	32.8000	120	0.0000
10712	53	32.8000	3	0.0500
10712	56	38.0000	30	0.0000
10713	10	31.0000	18	0.0000
10713	26	31.2300	30	0.0000
10713	45	9.5000	110	0.0000
10713	46	12.0000	24	0.0000
10714	2	19.0000	30	0.2500
10714	17	39.0000	27	0.2500
10714	47	9.5000	50	0.2500
10714	56	38.0000	18	0.2500
10714	58	13.2500	12	0.2500
10715	10	31.0000	21	0.0000
10715	71	21.5000	30	0.0000
10716	21	10.0000	5	0.0000
10716	51	53.0000	7	0.0000
10716	61	28.5000	10	0.0000
10717	21	10.0000	32	0.0500
10717	54	7.4500	15	0.0000
10717	69	36.0000	25	0.0500
10718	12	38.0000	36	0.0000
10718	16	17.4500	20	0.0000
10718	36	19.0000	40	0.0000
10718	62	49.3000	20	0.0000
10719	18	62.5000	12	0.2500
10719	30	25.8900	3	0.2500
10719	54	7.4500	40	0.2500
10720	35	18.0000	21	0.0000
10720	71	21.5000	8	0.0000
10721	44	19.4500	50	0.0500
10722	2	19.0000	3	0.0000
10722	31	12.5000	50	0.0000
10722	68	12.5000	45	0.0000
10722	75	7.7500	42	0.0000
10723	26	31.2300	15	0.0000
10724	10	31.0000	16	0.0000
10724	61	28.5000	5	0.0000
10725	41	9.6500	12	0.0000
10725	52	7.0000	4	0.0000
10725	55	24.0000	6	0.0000
10726	4	22.0000	25	0.0000
10726	11	21.0000	5	0.0000
10727	17	39.0000	20	0.0500
10727	56	38.0000	10	0.0500
10727	59	55.0000	10	0.0500
10728	30	25.8900	15	0.0000
10728	40	18.4000	6	0.0000
10728	55	24.0000	12	0.0000
10728	60	34.0000	15	0.0000
10729	1	18.0000	50	0.0000
10729	21	10.0000	30	0.0000
10729	50	16.2500	40	0.0000
10730	16	17.4500	15	0.0500
10730	31	12.5000	3	0.0500
10730	65	21.0500	10	0.0500
10731	21	10.0000	40	0.0500
10731	51	53.0000	30	0.0500
10732	76	18.0000	20	0.0000
10733	14	23.2500	16	0.0000
10733	28	45.6000	20	0.0000
10733	52	7.0000	25	0.0000
10734	6	25.0000	30	0.0000
10734	30	25.8900	15	0.0000
10734	76	18.0000	20	0.0000
10735	61	28.5000	20	0.1000
10735	77	13.0000	2	0.1000
10736	65	21.0500	40	0.0000
10736	75	7.7500	20	0.0000
10737	13	6.0000	4	0.0000
10737	41	9.6500	12	0.0000
10738	16	17.4500	3	0.0000
10739	36	19.0000	6	0.0000
10739	52	7.0000	18	0.0000
10740	28	45.6000	5	0.2000
10740	35	18.0000	35	0.2000
10740	45	9.5000	40	0.2000
10740	56	38.0000	14	0.2000
10741	2	19.0000	15	0.2000
10742	3	10.0000	20	0.0000
10742	60	34.0000	50	0.0000
10742	72	34.8000	35	0.0000
10743	46	12.0000	28	0.0500
10744	40	18.4000	50	0.2000
10745	18	62.5000	24	0.0000
10745	44	19.4500	16	0.0000
10745	59	55.0000	45	0.0000
10745	72	34.8000	7	0.0000
10746	13	6.0000	6	0.0000
10746	42	14.0000	28	0.0000
10746	62	49.3000	9	0.0000
10746	69	36.0000	40	0.0000
10747	31	12.5000	8	0.0000
10747	41	9.6500	35	0.0000
10747	63	43.9000	9	0.0000
10747	69	36.0000	30	0.0000
10748	23	9.0000	44	0.0000
10748	40	18.4000	40	0.0000
10748	56	38.0000	28	0.0000
10749	56	38.0000	15	0.0000
10749	59	55.0000	6	0.0000
10749	76	18.0000	10	0.0000
10750	14	23.2500	5	0.1500
10750	45	9.5000	40	0.1500
10750	59	55.0000	25	0.1500
10751	26	31.2300	12	0.1000
10751	30	25.8900	30	0.0000
10751	50	16.2500	20	0.1000
10751	73	15.0000	15	0.0000
10752	1	18.0000	8	0.0000
10752	69	36.0000	3	0.0000
10753	45	9.5000	4	0.0000
10753	74	10.0000	5	0.0000
10754	40	18.4000	3	0.0000
10755	47	9.5000	30	0.2500
10755	56	38.0000	30	0.2500
10755	57	19.5000	14	0.2500
10755	69	36.0000	25	0.2500
10756	18	62.5000	21	0.2000
10756	36	19.0000	20	0.2000
10756	68	12.5000	6	0.2000
10756	69	36.0000	20	0.2000
10757	34	14.0000	30	0.0000
10757	59	55.0000	7	0.0000
10757	62	49.3000	30	0.0000
10757	64	33.2500	24	0.0000
10758	26	31.2300	20	0.0000
10758	52	7.0000	60	0.0000
10758	70	15.0000	40	0.0000
10759	32	32.0000	10	0.0000
10760	25	14.0000	12	0.2500
10760	27	43.9000	40	0.0000
10760	43	46.0000	30	0.2500
10761	25	14.0000	35	0.2500
10761	75	7.7500	18	0.0000
10762	39	18.0000	16	0.0000
10762	47	9.5000	30	0.0000
10762	51	53.0000	28	0.0000
10762	56	38.0000	60	0.0000
10763	21	10.0000	40	0.0000
10763	22	21.0000	6	0.0000
10763	24	4.5000	20	0.0000
10764	3	10.0000	20	0.1000
10764	39	18.0000	130	0.1000
10765	65	21.0500	80	0.1000
10766	2	19.0000	40	0.0000
10766	7	30.0000	35	0.0000
10766	68	12.5000	40	0.0000
10767	42	14.0000	2	0.0000
10768	22	21.0000	4	0.0000
10768	31	12.5000	50	0.0000
10768	60	34.0000	15	0.0000
10768	71	21.5000	12	0.0000
10769	41	9.6500	30	0.0500
10769	52	7.0000	15	0.0500
10769	61	28.5000	20	0.0000
10769	62	49.3000	15	0.0000
10770	11	21.0000	15	0.2500
10771	71	21.5000	16	0.0000
10772	29	123.7900	18	0.0000
10772	59	55.0000	25	0.0000
10773	17	39.0000	33	0.0000
10773	31	12.5000	70	0.2000
10773	75	7.7500	7	0.2000
10774	31	12.5000	2	0.2500
10774	66	17.0000	50	0.0000
10775	10	31.0000	6	0.0000
10775	67	14.0000	3	0.0000
10776	31	12.5000	16	0.0500
10776	42	14.0000	12	0.0500
10776	45	9.5000	27	0.0500
10776	51	53.0000	120	0.0500
10777	42	14.0000	20	0.2000
10778	41	9.6500	10	0.0000
10779	16	17.4500	20	0.0000
10779	62	49.3000	20	0.0000
10780	70	15.0000	35	0.0000
10780	77	13.0000	15	0.0000
10781	54	7.4500	3	0.2000
10781	56	38.0000	20	0.2000
10781	74	10.0000	35	0.0000
10782	31	12.5000	1	0.0000
10783	31	12.5000	10	0.0000
10783	38	263.5000	5	0.0000
10784	36	19.0000	30	0.0000
10784	39	18.0000	2	0.1500
10784	72	34.8000	30	0.1500
10785	10	31.0000	10	0.0000
10785	75	7.7500	10	0.0000
10786	8	40.0000	30	0.2000
10786	30	25.8900	15	0.2000
10786	75	7.7500	42	0.2000
10787	2	19.0000	15	0.0500
10787	29	123.7900	20	0.0500
10788	19	9.2000	50	0.0500
10788	75	7.7500	40	0.0500
10789	18	62.5000	30	0.0000
10789	35	18.0000	15	0.0000
10789	63	43.9000	30	0.0000
10789	68	12.5000	18	0.0000
10790	7	30.0000	3	0.1500
10790	56	38.0000	20	0.1500
10791	29	123.7900	14	0.0500
10791	41	9.6500	20	0.0500
10792	2	19.0000	10	0.0000
10792	54	7.4500	3	0.0000
10792	68	12.5000	15	0.0000
10793	41	9.6500	14	0.0000
10793	52	7.0000	8	0.0000
10794	14	23.2500	15	0.2000
10794	54	7.4500	6	0.2000
10795	16	17.4500	65	0.0000
10795	17	39.0000	35	0.2500
10796	26	31.2300	21	0.2000
10796	44	19.4500	10	0.0000
10796	64	33.2500	35	0.2000
10796	69	36.0000	24	0.2000
10797	11	21.0000	20	0.0000
10798	62	49.3000	2	0.0000
10798	72	34.8000	10	0.0000
10799	13	6.0000	20	0.1500
10799	24	4.5000	20	0.1500
10799	59	55.0000	25	0.0000
10800	11	21.0000	50	0.1000
10800	51	53.0000	10	0.1000
10800	54	7.4500	7	0.1000
10801	17	39.0000	40	0.2500
10801	29	123.7900	20	0.2500
10802	30	25.8900	25	0.2500
10802	51	53.0000	30	0.2500
10802	55	24.0000	60	0.2500
10802	62	49.3000	5	0.2500
10803	19	9.2000	24	0.0500
10803	25	14.0000	15	0.0500
10803	59	55.0000	15	0.0500
10804	10	31.0000	36	0.0000
10804	28	45.6000	24	0.0000
10804	49	20.0000	4	0.1500
10805	34	14.0000	10	0.0000
10805	38	263.5000	10	0.0000
10806	2	19.0000	20	0.2500
10806	65	21.0500	2	0.0000
10806	74	10.0000	15	0.2500
10807	40	18.4000	1	0.0000
10808	56	38.0000	20	0.1500
10808	76	18.0000	50	0.1500
10809	52	7.0000	20	0.0000
10810	13	6.0000	7	0.0000
10810	25	14.0000	5	0.0000
10810	70	15.0000	5	0.0000
10811	19	9.2000	15	0.0000
10811	23	9.0000	18	0.0000
10811	40	18.4000	30	0.0000
10812	31	12.5000	16	0.1000
10812	72	34.8000	40	0.1000
10812	77	13.0000	20	0.0000
10813	2	19.0000	12	0.2000
10813	46	12.0000	35	0.0000
10814	41	9.6500	20	0.0000
10814	43	46.0000	20	0.1500
10814	48	12.7500	8	0.1500
10814	61	28.5000	30	0.1500
10815	33	2.5000	16	0.0000
10816	38	263.5000	30	0.0500
10816	62	49.3000	20	0.0500
10817	26	31.2300	40	0.1500
10817	38	263.5000	30	0.0000
10817	40	18.4000	60	0.1500
10817	62	49.3000	25	0.1500
10818	32	32.0000	20	0.0000
10818	41	9.6500	20	0.0000
10819	43	46.0000	7	0.0000
10819	75	7.7500	20	0.0000
10820	56	38.0000	30	0.0000
10821	35	18.0000	20	0.0000
10821	51	53.0000	6	0.0000
10822	62	49.3000	3	0.0000
10822	70	15.0000	6	0.0000
10823	11	21.0000	20	0.1000
10823	57	19.5000	15	0.0000
10823	59	55.0000	40	0.1000
10823	77	13.0000	15	0.1000
10824	41	9.6500	12	0.0000
10824	70	15.0000	9	0.0000
10825	26	31.2300	12	0.0000
10825	53	32.8000	20	0.0000
10826	31	12.5000	35	0.0000
10826	57	19.5000	15	0.0000
10827	10	31.0000	15	0.0000
10827	39	18.0000	21	0.0000
10828	20	81.0000	5	0.0000
10828	38	263.5000	2	0.0000
10829	2	19.0000	10	0.0000
10829	8	40.0000	20	0.0000
10829	13	6.0000	10	0.0000
10829	60	34.0000	21	0.0000
10830	6	25.0000	6	0.0000
10830	39	18.0000	28	0.0000
10830	60	34.0000	30	0.0000
10830	68	12.5000	24	0.0000
10831	19	9.2000	2	0.0000
10831	35	18.0000	8	0.0000
10831	38	263.5000	8	0.0000
10831	43	46.0000	9	0.0000
10832	13	6.0000	3	0.2000
10832	25	14.0000	10	0.2000
10832	44	19.4500	16	0.2000
10832	64	33.2500	3	0.0000
10833	7	30.0000	20	0.1000
10833	31	12.5000	9	0.1000
10833	53	32.8000	9	0.1000
10834	29	123.7900	8	0.0500
10834	30	25.8900	20	0.0500
10835	59	55.0000	15	0.0000
10835	77	13.0000	2	0.2000
10836	22	21.0000	52	0.0000
10836	35	18.0000	6	0.0000
10836	57	19.5000	24	0.0000
10836	60	34.0000	60	0.0000
10836	64	33.2500	30	0.0000
10837	13	6.0000	6	0.0000
10837	40	18.4000	25	0.0000
10837	47	9.5000	40	0.2500
10837	76	18.0000	21	0.2500
10838	1	18.0000	4	0.2500
10838	18	62.5000	25	0.2500
10838	36	19.0000	50	0.2500
10839	58	13.2500	30	0.1000
10839	72	34.8000	15	0.1000
10840	25	14.0000	6	0.2000
10840	39	18.0000	10	0.2000
10841	10	31.0000	16	0.0000
10841	56	38.0000	30	0.0000
10841	59	55.0000	50	0.0000
10841	77	13.0000	15	0.0000
10842	11	21.0000	15	0.0000
10842	43	46.0000	5	0.0000
10842	68	12.5000	20	0.0000
10842	70	15.0000	12	0.0000
10843	51	53.0000	4	0.2500
10844	22	21.0000	35	0.0000
10845	23	9.0000	70	0.1000
10845	35	18.0000	25	0.1000
10845	42	14.0000	42	0.1000
10845	58	13.2500	60	0.1000
10845	64	33.2500	48	0.0000
10846	4	22.0000	21	0.0000
10846	70	15.0000	30	0.0000
10846	74	10.0000	20	0.0000
10847	1	18.0000	80	0.2000
10847	19	9.2000	12	0.2000
10847	37	26.0000	60	0.2000
10847	45	9.5000	36	0.2000
10847	60	34.0000	45	0.2000
10847	71	21.5000	55	0.2000
10848	5	21.3500	30	0.0000
10848	9	97.0000	3	0.0000
10849	3	10.0000	49	0.0000
10849	26	31.2300	18	0.1500
10850	25	14.0000	20	0.1500
10850	33	2.5000	4	0.1500
10850	70	15.0000	30	0.1500
10851	2	19.0000	5	0.0500
10851	25	14.0000	10	0.0500
10851	57	19.5000	10	0.0500
10851	59	55.0000	42	0.0500
10852	2	19.0000	15	0.0000
10852	17	39.0000	6	0.0000
10852	62	49.3000	50	0.0000
10853	18	62.5000	10	0.0000
10854	10	31.0000	100	0.1500
10854	13	6.0000	65	0.1500
10855	16	17.4500	50	0.0000
10855	31	12.5000	14	0.0000
10855	56	38.0000	24	0.0000
10855	65	21.0500	15	0.1500
10856	2	19.0000	20	0.0000
10856	42	14.0000	20	0.0000
10857	3	10.0000	30	0.0000
10857	26	31.2300	35	0.2500
10857	29	123.7900	10	0.2500
10858	7	30.0000	5	0.0000
10858	27	43.9000	10	0.0000
10858	70	15.0000	4	0.0000
10859	24	4.5000	40	0.2500
10859	54	7.4500	35	0.2500
10859	64	33.2500	30	0.2500
10860	51	53.0000	3	0.0000
10860	76	18.0000	20	0.0000
10861	17	39.0000	42	0.0000
10861	18	62.5000	20	0.0000
10861	21	10.0000	40	0.0000
10861	33	2.5000	35	0.0000
10861	62	49.3000	3	0.0000
10862	11	21.0000	25	0.0000
10862	52	7.0000	8	0.0000
10863	1	18.0000	20	0.1500
10863	58	13.2500	12	0.1500
10864	35	18.0000	4	0.0000
10864	67	14.0000	15	0.0000
10865	38	263.5000	60	0.0500
10865	39	18.0000	80	0.0500
10866	2	19.0000	21	0.2500
10866	24	4.5000	6	0.2500
10866	30	25.8900	40	0.2500
10867	53	32.8000	3	0.0000
10868	26	31.2300	20	0.0000
10868	35	18.0000	30	0.0000
10868	49	20.0000	42	0.1000
10869	1	18.0000	40	0.0000
10869	11	21.0000	10	0.0000
10869	23	9.0000	50	0.0000
10869	68	12.5000	20	0.0000
10870	35	18.0000	3	0.0000
10870	51	53.0000	2	0.0000
10871	6	25.0000	50	0.0500
10871	16	17.4500	12	0.0500
10871	17	39.0000	16	0.0500
10872	55	24.0000	10	0.0500
10872	62	49.3000	20	0.0500
10872	64	33.2500	15	0.0500
10872	65	21.0500	21	0.0500
10873	21	10.0000	20	0.0000
10873	28	45.6000	3	0.0000
10874	10	31.0000	10	0.0000
10875	19	9.2000	25	0.0000
10875	47	9.5000	21	0.1000
10875	49	20.0000	15	0.0000
10876	46	12.0000	21	0.0000
10876	64	33.2500	20	0.0000
10877	16	17.4500	30	0.2500
10877	18	62.5000	25	0.0000
10878	20	81.0000	20	0.0500
10879	40	18.4000	12	0.0000
10879	65	21.0500	10	0.0000
10879	76	18.0000	10	0.0000
10880	23	9.0000	30	0.2000
10880	61	28.5000	30	0.2000
10880	70	15.0000	50	0.2000
10881	73	15.0000	10	0.0000
10882	42	14.0000	25	0.0000
10882	49	20.0000	20	0.1500
10882	54	7.4500	32	0.1500
10883	24	4.5000	8	0.0000
10884	21	10.0000	40	0.0500
10884	56	38.0000	21	0.0500
10884	65	21.0500	12	0.0500
10885	2	19.0000	20	0.0000
10885	24	4.5000	12	0.0000
10885	70	15.0000	30	0.0000
10885	77	13.0000	25	0.0000
10886	10	31.0000	70	0.0000
10886	31	12.5000	35	0.0000
10886	77	13.0000	40	0.0000
10887	25	14.0000	5	0.0000
10888	2	19.0000	20	0.0000
10888	68	12.5000	18	0.0000
10889	11	21.0000	40	0.0000
10889	38	263.5000	40	0.0000
10890	17	39.0000	15	0.0000
10890	34	14.0000	10	0.0000
10890	41	9.6500	14	0.0000
10891	30	25.8900	15	0.0500
10892	59	55.0000	40	0.0500
10893	8	40.0000	30	0.0000
10893	24	4.5000	10	0.0000
10893	29	123.7900	24	0.0000
10893	30	25.8900	35	0.0000
10893	36	19.0000	20	0.0000
10894	13	6.0000	28	0.0500
10894	69	36.0000	50	0.0500
10894	75	7.7500	120	0.0500
10895	24	4.5000	110	0.0000
10895	39	18.0000	45	0.0000
10895	40	18.4000	91	0.0000
10895	60	34.0000	100	0.0000
10896	45	9.5000	15	0.0000
10896	56	38.0000	16	0.0000
10897	29	123.7900	80	0.0000
10897	30	25.8900	36	0.0000
10898	13	6.0000	5	0.0000
10899	39	18.0000	8	0.1500
10900	70	15.0000	3	0.2500
10901	41	9.6500	30	0.0000
10901	71	21.5000	30	0.0000
10902	55	24.0000	30	0.1500
10902	62	49.3000	6	0.1500
10903	13	6.0000	40	0.0000
10903	65	21.0500	21	0.0000
10903	68	12.5000	20	0.0000
10904	58	13.2500	15	0.0000
10904	62	49.3000	35	0.0000
10905	1	18.0000	20	0.0500
10906	61	28.5000	15	0.0000
10907	75	7.7500	14	0.0000
10908	7	30.0000	20	0.0500
10908	52	7.0000	14	0.0500
10909	7	30.0000	12	0.0000
10909	16	17.4500	15	0.0000
10909	41	9.6500	5	0.0000
10910	19	9.2000	12	0.0000
10910	49	20.0000	10	0.0000
10910	61	28.5000	5	0.0000
10911	1	18.0000	10	0.0000
10911	17	39.0000	12	0.0000
10911	67	14.0000	15	0.0000
10912	11	21.0000	40	0.2500
10912	29	123.7900	60	0.2500
10913	4	22.0000	30	0.2500
10913	33	2.5000	40	0.2500
10913	58	13.2500	15	0.0000
10914	71	21.5000	25	0.0000
10915	17	39.0000	10	0.0000
10915	33	2.5000	30	0.0000
10915	54	7.4500	10	0.0000
10916	16	17.4500	6	0.0000
10916	32	32.0000	6	0.0000
10916	57	19.5000	20	0.0000
10917	30	25.8900	1	0.0000
10917	60	34.0000	10	0.0000
10918	1	18.0000	60	0.2500
10918	60	34.0000	25	0.2500
10919	16	17.4500	24	0.0000
10919	25	14.0000	24	0.0000
10919	40	18.4000	20	0.0000
10920	50	16.2500	24	0.0000
10921	35	18.0000	10	0.0000
10921	63	43.9000	40	0.0000
10922	17	39.0000	15	0.0000
10922	24	4.5000	35	0.0000
10923	42	14.0000	10	0.2000
10923	43	46.0000	10	0.2000
10923	67	14.0000	24	0.2000
10924	10	31.0000	20	0.1000
10924	28	45.6000	30	0.1000
10924	75	7.7500	6	0.0000
10925	36	19.0000	25	0.1500
10925	52	7.0000	12	0.1500
10926	11	21.0000	2	0.0000
10926	13	6.0000	10	0.0000
10926	19	9.2000	7	0.0000
10926	72	34.8000	10	0.0000
10927	20	81.0000	5	0.0000
10927	52	7.0000	5	0.0000
10927	76	18.0000	20	0.0000
10928	47	9.5000	5	0.0000
10928	76	18.0000	5	0.0000
10929	21	10.0000	60	0.0000
10929	75	7.7500	49	0.0000
10929	77	13.0000	15	0.0000
10930	21	10.0000	36	0.0000
10930	27	43.9000	25	0.0000
10930	55	24.0000	25	0.2000
10930	58	13.2500	30	0.2000
10931	13	6.0000	42	0.1500
10931	57	19.5000	30	0.0000
10932	16	17.4500	30	0.1000
10932	62	49.3000	14	0.1000
10932	72	34.8000	16	0.0000
10932	75	7.7500	20	0.1000
10933	53	32.8000	2	0.0000
10933	61	28.5000	30	0.0000
10934	6	25.0000	20	0.0000
10935	1	18.0000	21	0.0000
10935	18	62.5000	4	0.2500
10935	23	9.0000	8	0.2500
10936	36	19.0000	30	0.2000
10937	28	45.6000	8	0.0000
10937	34	14.0000	20	0.0000
10938	13	6.0000	20	0.2500
10938	43	46.0000	24	0.2500
10938	60	34.0000	49	0.2500
10938	71	21.5000	35	0.2500
10939	2	19.0000	10	0.1500
10939	67	14.0000	40	0.1500
10940	7	30.0000	8	0.0000
10940	13	6.0000	20	0.0000
10941	31	12.5000	44	0.2500
10941	62	49.3000	30	0.2500
10941	68	12.5000	80	0.2500
10941	72	34.8000	50	0.0000
10942	49	20.0000	28	0.0000
10943	13	6.0000	15	0.0000
10943	22	21.0000	21	0.0000
10943	46	12.0000	15	0.0000
10944	11	21.0000	5	0.2500
10944	44	19.4500	18	0.2500
10944	56	38.0000	18	0.0000
10945	13	6.0000	20	0.0000
10945	31	12.5000	10	0.0000
10946	10	31.0000	25	0.0000
10946	24	4.5000	25	0.0000
10946	77	13.0000	40	0.0000
10947	59	55.0000	4	0.0000
10948	50	16.2500	9	0.0000
10948	51	53.0000	40	0.0000
10948	55	24.0000	4	0.0000
10949	6	25.0000	12	0.0000
10949	10	31.0000	30	0.0000
10949	17	39.0000	6	0.0000
10949	62	49.3000	60	0.0000
10950	4	22.0000	5	0.0000
10951	33	2.5000	15	0.0500
10951	41	9.6500	6	0.0500
10951	75	7.7500	50	0.0500
10952	6	25.0000	16	0.0500
10952	28	45.6000	2	0.0000
10953	20	81.0000	50	0.0500
10953	31	12.5000	50	0.0500
10954	16	17.4500	28	0.1500
10954	31	12.5000	25	0.1500
10954	45	9.5000	30	0.0000
10954	60	34.0000	24	0.1500
10955	75	7.7500	12	0.2000
10956	21	10.0000	12	0.0000
10956	47	9.5000	14	0.0000
10956	51	53.0000	8	0.0000
10957	30	25.8900	30	0.0000
10957	35	18.0000	40	0.0000
10957	64	33.2500	8	0.0000
10958	5	21.3500	20	0.0000
10958	7	30.0000	6	0.0000
10958	72	34.8000	5	0.0000
10959	75	7.7500	20	0.1500
10960	24	4.5000	10	0.2500
10960	41	9.6500	24	0.0000
10961	52	7.0000	6	0.0500
10961	76	18.0000	60	0.0000
10962	7	30.0000	45	0.0000
10962	13	6.0000	77	0.0000
10962	53	32.8000	20	0.0000
10962	69	36.0000	9	0.0000
10962	76	18.0000	44	0.0000
10963	60	34.0000	2	0.1500
10964	18	62.5000	6	0.0000
10964	38	263.5000	5	0.0000
10964	69	36.0000	10	0.0000
10965	51	53.0000	16	0.0000
10966	37	26.0000	8	0.0000
10966	56	38.0000	12	0.1500
10966	62	49.3000	12	0.1500
10967	19	9.2000	12	0.0000
10967	49	20.0000	40	0.0000
10968	12	38.0000	30	0.0000
10968	24	4.5000	30	0.0000
10968	64	33.2500	4	0.0000
10969	46	12.0000	9	0.0000
10970	52	7.0000	40	0.2000
10971	29	123.7900	14	0.0000
10972	17	39.0000	6	0.0000
10972	33	2.5000	7	0.0000
10973	26	31.2300	5	0.0000
10973	41	9.6500	6	0.0000
10973	75	7.7500	10	0.0000
10974	63	43.9000	10	0.0000
10975	8	40.0000	16	0.0000
10975	75	7.7500	10	0.0000
10976	28	45.6000	20	0.0000
10977	39	18.0000	30	0.0000
10977	47	9.5000	30	0.0000
10977	51	53.0000	10	0.0000
10977	63	43.9000	20	0.0000
10978	8	40.0000	20	0.1500
10978	21	10.0000	40	0.1500
10978	40	18.4000	10	0.0000
10978	44	19.4500	6	0.1500
10979	7	30.0000	18	0.0000
10979	12	38.0000	20	0.0000
10979	24	4.5000	80	0.0000
10979	27	43.9000	30	0.0000
10979	31	12.5000	24	0.0000
10979	63	43.9000	35	0.0000
10980	75	7.7500	40	0.2000
10981	38	263.5000	60	0.0000
10982	7	30.0000	20	0.0000
10982	43	46.0000	9	0.0000
10983	13	6.0000	84	0.1500
10983	57	19.5000	15	0.0000
10984	16	17.4500	55	0.0000
10984	24	4.5000	20	0.0000
10984	36	19.0000	40	0.0000
10985	16	17.4500	36	0.1000
10985	18	62.5000	8	0.1000
10985	32	32.0000	35	0.1000
10986	11	21.0000	30	0.0000
10986	20	81.0000	15	0.0000
10986	76	18.0000	10	0.0000
10986	77	13.0000	15	0.0000
10987	7	30.0000	60	0.0000
10987	43	46.0000	6	0.0000
10987	72	34.8000	20	0.0000
10988	7	30.0000	60	0.0000
10988	62	49.3000	40	0.1000
10989	6	25.0000	40	0.0000
10989	11	21.0000	15	0.0000
10989	41	9.6500	4	0.0000
10990	21	10.0000	65	0.0000
10990	34	14.0000	60	0.1500
10990	55	24.0000	65	0.1500
10990	61	28.5000	66	0.1500
10991	2	19.0000	50	0.2000
10991	70	15.0000	20	0.2000
10991	76	18.0000	90	0.2000
10992	72	34.8000	2	0.0000
10993	29	123.7900	50	0.2500
10993	41	9.6500	35	0.2500
10994	59	55.0000	18	0.0500
10995	51	53.0000	20	0.0000
10995	60	34.0000	4	0.0000
10996	42	14.0000	40	0.0000
10997	32	32.0000	50	0.0000
10997	46	12.0000	20	0.2500
10997	52	7.0000	20	0.2500
10998	24	4.5000	12	0.0000
10998	61	28.5000	7	0.0000
10998	74	10.0000	20	0.0000
10998	75	7.7500	30	0.0000
10999	41	9.6500	20	0.0500
10999	51	53.0000	15	0.0500
10999	77	13.0000	21	0.0500
11000	4	22.0000	25	0.2500
11000	24	4.5000	30	0.2500
11000	77	13.0000	30	0.0000
11001	7	30.0000	60	0.0000
11001	22	21.0000	25	0.0000
11001	46	12.0000	25	0.0000
11001	55	24.0000	6	0.0000
11002	13	6.0000	56	0.0000
11002	35	18.0000	15	0.1500
11002	42	14.0000	24	0.1500
11002	55	24.0000	40	0.0000
11003	1	18.0000	4	0.0000
11003	40	18.4000	10	0.0000
11003	52	7.0000	10	0.0000
11004	26	31.2300	6	0.0000
11004	76	18.0000	6	0.0000
11005	1	18.0000	2	0.0000
11005	59	55.0000	10	0.0000
11006	1	18.0000	8	0.0000
11006	29	123.7900	2	0.2500
11007	8	40.0000	30	0.0000
11007	29	123.7900	10	0.0000
11007	42	14.0000	14	0.0000
11008	28	45.6000	70	0.0500
11008	34	14.0000	90	0.0500
11008	71	21.5000	21	0.0000
11009	24	4.5000	12	0.0000
11009	36	19.0000	18	0.2500
11009	60	34.0000	9	0.0000
11010	7	30.0000	20	0.0000
11010	24	4.5000	10	0.0000
11011	58	13.2500	40	0.0500
11011	71	21.5000	20	0.0000
11012	19	9.2000	50	0.0500
11012	60	34.0000	36	0.0500
11012	71	21.5000	60	0.0500
11013	23	9.0000	10	0.0000
11013	42	14.0000	4	0.0000
11013	45	9.5000	20	0.0000
11013	68	12.5000	2	0.0000
11014	41	9.6500	28	0.1000
11015	30	25.8900	15	0.0000
11015	77	13.0000	18	0.0000
11016	31	12.5000	15	0.0000
11016	36	19.0000	16	0.0000
11017	3	10.0000	25	0.0000
11017	59	55.0000	110	0.0000
11017	70	15.0000	30	0.0000
11018	12	38.0000	20	0.0000
11018	18	62.5000	10	0.0000
11018	56	38.0000	5	0.0000
11019	46	12.0000	3	0.0000
11019	49	20.0000	2	0.0000
11020	10	31.0000	24	0.1500
11021	2	19.0000	11	0.2500
11021	20	81.0000	15	0.0000
11021	26	31.2300	63	0.0000
11021	51	53.0000	44	0.2500
11021	72	34.8000	35	0.0000
11022	19	9.2000	35	0.0000
11022	69	36.0000	30	0.0000
11023	7	30.0000	4	0.0000
11023	43	46.0000	30	0.0000
11024	26	31.2300	12	0.0000
11024	33	2.5000	30	0.0000
11024	65	21.0500	21	0.0000
11024	71	21.5000	50	0.0000
11025	1	18.0000	10	0.1000
11025	13	6.0000	20	0.1000
11026	18	62.5000	8	0.0000
11026	51	53.0000	10	0.0000
11027	24	4.5000	30	0.2500
11027	62	49.3000	21	0.2500
11028	55	24.0000	35	0.0000
11028	59	55.0000	24	0.0000
11029	56	38.0000	20	0.0000
11029	63	43.9000	12	0.0000
11030	2	19.0000	100	0.2500
11030	5	21.3500	70	0.0000
11030	29	123.7900	60	0.2500
11030	59	55.0000	100	0.2500
11031	1	18.0000	45	0.0000
11031	13	6.0000	80	0.0000
11031	24	4.5000	21	0.0000
11031	64	33.2500	20	0.0000
11031	71	21.5000	16	0.0000
11032	36	19.0000	35	0.0000
11032	38	263.5000	25	0.0000
11032	59	55.0000	30	0.0000
11033	53	32.8000	70	0.1000
11033	69	36.0000	36	0.1000
11034	21	10.0000	15	0.1000
11034	44	19.4500	12	0.0000
11034	61	28.5000	6	0.0000
11035	1	18.0000	10	0.0000
11035	35	18.0000	60	0.0000
11035	42	14.0000	30	0.0000
11035	54	7.4500	10	0.0000
11036	13	6.0000	7	0.0000
11036	59	55.0000	30	0.0000
11037	70	15.0000	4	0.0000
11038	40	18.4000	5	0.2000
11038	52	7.0000	2	0.0000
11038	71	21.5000	30	0.0000
11039	28	45.6000	20	0.0000
11039	35	18.0000	24	0.0000
11039	49	20.0000	60	0.0000
11039	57	19.5000	28	0.0000
11040	21	10.0000	20	0.0000
11041	2	19.0000	30	0.2000
11041	63	43.9000	30	0.0000
11042	44	19.4500	15	0.0000
11042	61	28.5000	4	0.0000
11043	11	21.0000	10	0.0000
11044	62	49.3000	12	0.0000
11045	33	2.5000	15	0.0000
11045	51	53.0000	24	0.0000
11046	12	38.0000	20	0.0500
11046	32	32.0000	15	0.0500
11046	35	18.0000	18	0.0500
11047	1	18.0000	25	0.2500
11047	5	21.3500	30	0.2500
11048	68	12.5000	42	0.0000
11049	2	19.0000	10	0.2000
11049	12	38.0000	4	0.2000
11050	76	18.0000	50	0.1000
11051	24	4.5000	10	0.2000
11052	43	46.0000	30	0.2000
11052	61	28.5000	10	0.2000
11053	18	62.5000	35	0.2000
11053	32	32.0000	20	0.0000
11053	64	33.2500	25	0.2000
11054	33	2.5000	10	0.0000
11054	67	14.0000	20	0.0000
11055	24	4.5000	15	0.0000
11055	25	14.0000	15	0.0000
11055	51	53.0000	20	0.0000
11055	57	19.5000	20	0.0000
11056	7	30.0000	40	0.0000
11056	55	24.0000	35	0.0000
11056	60	34.0000	50	0.0000
11057	70	15.0000	3	0.0000
11058	21	10.0000	3	0.0000
11058	60	34.0000	21	0.0000
11058	61	28.5000	4	0.0000
11059	13	6.0000	30	0.0000
11059	17	39.0000	12	0.0000
11059	60	34.0000	35	0.0000
11060	60	34.0000	4	0.0000
11060	77	13.0000	10	0.0000
11061	60	34.0000	15	0.0000
11062	53	32.8000	10	0.2000
11062	70	15.0000	12	0.2000
11063	34	14.0000	30	0.0000
11063	40	18.4000	40	0.1000
11063	41	9.6500	30	0.1000
11064	17	39.0000	77	0.1000
11064	41	9.6500	12	0.0000
11064	53	32.8000	25	0.1000
11064	55	24.0000	4	0.1000
11064	68	12.5000	55	0.0000
11065	30	25.8900	4	0.2500
11065	54	7.4500	20	0.2500
11066	16	17.4500	3	0.0000
11066	19	9.2000	42	0.0000
11066	34	14.0000	35	0.0000
11067	41	9.6500	9	0.0000
11068	28	45.6000	8	0.1500
11068	43	46.0000	36	0.1500
11068	77	13.0000	28	0.1500
11070	1	18.0000	40	0.1500
11070	2	19.0000	20	0.1500
11070	16	17.4500	30	0.1500
11070	31	12.5000	20	0.0000
11071	7	30.0000	15	0.0500
11071	13	6.0000	10	0.0500
11072	2	19.0000	8	0.0000
11072	41	9.6500	40	0.0000
11072	50	16.2500	22	0.0000
11072	64	33.2500	130	0.0000
11073	11	21.0000	10	0.0000
11073	24	4.5000	20	0.0000
11074	16	17.4500	14	0.0500
11075	2	19.0000	10	0.1500
11075	46	12.0000	30	0.1500
11075	76	18.0000	2	0.1500
11076	6	25.0000	20	0.2500
11076	14	23.2500	20	0.2500
11076	19	9.2000	10	0.2500
11077	2	19.0000	24	0.2000
11077	3	10.0000	4	0.0000
11077	4	22.0000	1	0.0000
11077	6	25.0000	1	0.0200
11077	7	30.0000	1	0.0500
11077	8	40.0000	2	0.1000
11077	10	31.0000	1	0.0000
11077	12	38.0000	2	0.0500
11077	13	6.0000	4	0.0000
11077	14	23.2500	1	0.0300
11077	16	17.4500	2	0.0300
11077	20	81.0000	1	0.0400
11077	23	9.0000	2	0.0000
11077	32	32.0000	1	0.0000
11077	39	18.0000	2	0.0500
11077	41	9.6500	3	0.0000
11077	46	12.0000	3	0.0200
11077	52	7.0000	2	0.0000
11077	55	24.0000	2	0.0000
11077	60	34.0000	2	0.0600
11077	64	33.2500	2	0.0300
11077	66	17.0000	1	0.0000
11077	73	15.0000	2	0.0100
11077	75	7.7500	4	0.0000
11077	77	13.0000	2	0.0000
\.


--
-- TOC entry 3399 (class 0 OID 16405)
-- Dependencies: 220
-- Data for Name: orders; Type: TABLE DATA; Schema: northwind; Owner: -
--

COPY northwind.orders (orderid, customerid, employeeid, orderdate, requireddate, shippeddate, freight, shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry, shipperid) FROM stdin;
10331	BONAP	9	1994-11-16 00:00:00	1994-12-28 00:00:00	1994-11-21 00:00:00	10.1900	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10333	WARTH	5	1994-11-18 00:00:00	1994-12-16 00:00:00	1994-11-25 00:00:00	0.5900	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland	\N
10334	VICTE	8	1994-11-21 00:00:00	1994-12-19 00:00:00	1994-11-28 00:00:00	8.5600	Victuailles en stock	2, rue du Commerce	Lyon	\N	69004	France	\N
10335	HUNGO	7	1994-11-22 00:00:00	1994-12-20 00:00:00	1994-11-24 00:00:00	42.1100	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10336	PRINI	7	1994-11-23 00:00:00	1994-12-21 00:00:00	1994-11-25 00:00:00	15.5100	Princesa Isabel Vinhos	Estrada da saÃºde n. 58	Lisboa	\N	1756	Portugal	\N
10337	FRANK	4	1994-11-24 00:00:00	1994-12-22 00:00:00	1994-11-29 00:00:00	108.2600	Frankenversand	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	\N
10338	OLDWO	4	1994-11-25 00:00:00	1994-12-23 00:00:00	1994-11-29 00:00:00	84.2100	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA	\N
10339	MEREP	2	1994-11-28 00:00:00	1994-12-26 00:00:00	1994-12-05 00:00:00	15.6600	MÃ¨re Paillarde	43 rue St. Laurent	MontrÃ©al	QuÃ©bec	H1J 1C3	Canada	\N
10340	BONAP	1	1994-11-29 00:00:00	1994-12-27 00:00:00	1994-12-09 00:00:00	166.3100	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10341	SIMOB	7	1994-11-29 00:00:00	1994-12-27 00:00:00	1994-12-06 00:00:00	26.7800	Simons bistro	VinbÃ¦ltet 34	KÃ¸benhavn	\N	1734	Denmark	\N
10342	FRANK	4	1994-11-30 00:00:00	1994-12-14 00:00:00	1994-12-05 00:00:00	54.8300	Frankenversand	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	\N
10343	LEHMS	4	1994-12-01 00:00:00	1994-12-29 00:00:00	1994-12-07 00:00:00	110.3700	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	\N
10344	WHITC	4	1994-12-02 00:00:00	1994-12-30 00:00:00	1994-12-06 00:00:00	23.2900	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA	\N
10345	QUICK	2	1994-12-05 00:00:00	1995-01-02 00:00:00	1994-12-12 00:00:00	249.0600	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10346	RATTC	3	1994-12-06 00:00:00	1995-01-17 00:00:00	1994-12-09 00:00:00	142.0800	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10248	VINET	5	1994-08-04 00:00:00	1994-09-01 00:00:00	1994-08-16 00:00:00	32.3800	Vins et alcools Chevalier	59 rue de l'Abbaye	Reims	\N	51100	France	\N
10249	TOMSP	6	1994-08-05 00:00:00	1994-09-16 00:00:00	1994-08-10 00:00:00	11.6100	Toms SpezialitÃ¤ten	Luisenstr. 48	MÃ¼nster	\N	44087	Germany	\N
10250	HANAR	4	1994-08-08 00:00:00	1994-09-05 00:00:00	1994-08-12 00:00:00	65.8300	Hanari Carnes	Rua do PaÃ§o, 67	Rio de Janeiro	RJ	05454-876	Brazil	\N
10251	VICTE	3	1994-08-08 00:00:00	1994-09-05 00:00:00	1994-08-15 00:00:00	41.3400	Victuailles en stock	2, rue du Commerce	Lyon	\N	69004	France	\N
10252	SUPRD	4	1994-08-09 00:00:00	1994-09-06 00:00:00	1994-08-11 00:00:00	51.3000	SuprÃªmes dÃ©lices	Boulevard Tirou, 255	Charleroi	\N	B-6000	Belgium	\N
10253	HANAR	3	1994-08-10 00:00:00	1994-08-24 00:00:00	1994-08-16 00:00:00	58.1700	Hanari Carnes	Rua do PaÃ§o, 67	Rio de Janeiro	RJ	05454-876	Brazil	\N
10254	CHOPS	5	1994-08-11 00:00:00	1994-09-08 00:00:00	1994-08-23 00:00:00	22.9800	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland	\N
10255	RICSU	9	1994-08-12 00:00:00	1994-09-09 00:00:00	1994-08-15 00:00:00	148.3300	Richter Supermarkt	Starenweg 5	GenÃ¨ve	\N	1204	Switzerland	\N
10256	WELLI	3	1994-08-15 00:00:00	1994-09-12 00:00:00	1994-08-17 00:00:00	13.9700	Wellington Importadora	Rua do Mercado, 12	Resende	SP	08737-363	Brazil	\N
10257	HILAA	4	1994-08-16 00:00:00	1994-09-13 00:00:00	1994-08-22 00:00:00	81.9100	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10258	ERNSH	1	1994-08-17 00:00:00	1994-09-14 00:00:00	1994-08-23 00:00:00	140.5100	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10259	CENTC	4	1994-08-18 00:00:00	1994-09-15 00:00:00	1994-08-25 00:00:00	3.2500	Centro comercial Moctezuma	Sierras de Granada 9993	MÃ©xico D.F.	\N	05022	Mexico	\N
10260	OTTIK	4	1994-08-19 00:00:00	1994-09-16 00:00:00	1994-08-29 00:00:00	55.0900	Ottilies KÃ¤seladen	Mehrheimerstr. 369	KÃ¶ln	\N	50739	Germany	\N
10261	QUEDE	4	1994-08-19 00:00:00	1994-09-16 00:00:00	1994-08-30 00:00:00	3.0500	Que DelÃ­cia	Rua da Panificadora, 12	Rio de Janeiro	RJ	02389-673	Brazil	\N
10262	RATTC	8	1994-08-22 00:00:00	1994-09-19 00:00:00	1994-08-25 00:00:00	48.2900	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10263	ERNSH	9	1994-08-23 00:00:00	1994-09-20 00:00:00	1994-08-31 00:00:00	146.0600	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10264	FOLKO	6	1994-08-24 00:00:00	1994-09-21 00:00:00	1994-09-23 00:00:00	3.6700	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10265	BLONP	2	1994-08-25 00:00:00	1994-09-22 00:00:00	1994-09-12 00:00:00	55.2800	Blondel pÃ¨re et fils	24, place KlÃ©ber	Strasbourg	\N	67000	France	\N
10266	WARTH	3	1994-08-26 00:00:00	1994-10-07 00:00:00	1994-08-31 00:00:00	25.7300	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland	\N
10267	FRANK	4	1994-08-29 00:00:00	1994-09-26 00:00:00	1994-09-06 00:00:00	208.5800	Frankenversand	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	\N
10268	GROSR	8	1994-08-30 00:00:00	1994-09-27 00:00:00	1994-09-02 00:00:00	66.2900	GROSELLA-Restaurante	5Âª Ave. Los Palos Grandes	Caracas	DF	1081	Venezuela	\N
10269	WHITC	5	1994-08-31 00:00:00	1994-09-14 00:00:00	1994-09-09 00:00:00	4.5600	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA	\N
10270	WARTH	1	1994-09-01 00:00:00	1994-09-29 00:00:00	1994-09-02 00:00:00	136.5400	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland	\N
10271	SPLIR	6	1994-09-01 00:00:00	1994-09-29 00:00:00	1994-09-30 00:00:00	4.5400	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA	\N
10272	RATTC	6	1994-09-02 00:00:00	1994-09-30 00:00:00	1994-09-06 00:00:00	98.0300	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10273	QUICK	3	1994-09-05 00:00:00	1994-10-03 00:00:00	1994-09-12 00:00:00	76.0700	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10274	VINET	6	1994-09-06 00:00:00	1994-10-04 00:00:00	1994-09-16 00:00:00	6.0100	Vins et alcools Chevalier	59 rue de l'Abbaye	Reims	\N	51100	France	\N
10275	MAGAA	1	1994-09-07 00:00:00	1994-10-05 00:00:00	1994-09-09 00:00:00	26.9300	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy	\N
10276	TORTU	8	1994-09-08 00:00:00	1994-09-22 00:00:00	1994-09-14 00:00:00	13.8400	Tortuga Restaurante	Avda. Azteca 123	MÃ©xico D.F.	\N	05033	Mexico	\N
10277	MORGK	2	1994-09-09 00:00:00	1994-10-07 00:00:00	1994-09-13 00:00:00	125.7700	Morgenstern Gesundkost	Heerstr. 22	Leipzig	\N	04179	Germany	\N
10278	BERGS	8	1994-09-12 00:00:00	1994-10-10 00:00:00	1994-09-16 00:00:00	92.6900	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10279	LEHMS	8	1994-09-13 00:00:00	1994-10-11 00:00:00	1994-09-16 00:00:00	25.8300	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	\N
10280	BERGS	2	1994-09-14 00:00:00	1994-10-12 00:00:00	1994-10-13 00:00:00	8.9800	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10281	ROMEY	4	1994-09-14 00:00:00	1994-09-28 00:00:00	1994-09-21 00:00:00	2.9400	Romero y tomillo	Gran VÃ­a, 1	Madrid	\N	28001	Spain	\N
10282	ROMEY	4	1994-09-15 00:00:00	1994-10-13 00:00:00	1994-09-21 00:00:00	12.6900	Romero y tomillo	Gran VÃ­a, 1	Madrid	\N	28001	Spain	\N
10283	LILAS	3	1994-09-16 00:00:00	1994-10-14 00:00:00	1994-09-23 00:00:00	84.8100	LILA-Supermercado	Carrera 52 con Ave. BolÃ­var #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela	\N
10284	LEHMS	4	1994-09-19 00:00:00	1994-10-17 00:00:00	1994-09-27 00:00:00	76.5600	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	\N
10285	QUICK	1	1994-09-20 00:00:00	1994-10-18 00:00:00	1994-09-26 00:00:00	76.8300	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10286	QUICK	8	1994-09-21 00:00:00	1994-10-19 00:00:00	1994-09-30 00:00:00	229.2400	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10287	RICAR	8	1994-09-22 00:00:00	1994-10-20 00:00:00	1994-09-28 00:00:00	12.7600	Ricardo Adocicados	Av. Copacabana, 267	Rio de Janeiro	RJ	02389-890	Brazil	\N
10288	REGGC	4	1994-09-23 00:00:00	1994-10-21 00:00:00	1994-10-04 00:00:00	7.4500	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy	\N
10289	BSBEV	7	1994-09-26 00:00:00	1994-10-24 00:00:00	1994-09-28 00:00:00	22.7700	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK	\N
10290	COMMI	8	1994-09-27 00:00:00	1994-10-25 00:00:00	1994-10-04 00:00:00	79.7000	ComÃ©rcio Mineiro	Av. dos LusÃ­adas, 23	SÃ£o Paulo	SP	05432-043	Brazil	\N
10291	QUEDE	6	1994-09-27 00:00:00	1994-10-25 00:00:00	1994-10-05 00:00:00	6.4000	Que DelÃ­cia	Rua da Panificadora, 12	Rio de Janeiro	RJ	02389-673	Brazil	\N
10292	TRADH	1	1994-09-28 00:00:00	1994-10-26 00:00:00	1994-10-03 00:00:00	1.3500	TradiÃ§Ã£o Hipermercados	Av. InÃªs de Castro, 414	SÃ£o Paulo	SP	05634-030	Brazil	\N
10293	TORTU	1	1994-09-29 00:00:00	1994-10-27 00:00:00	1994-10-12 00:00:00	21.1800	Tortuga Restaurante	Avda. Azteca 123	MÃ©xico D.F.	\N	05033	Mexico	\N
10294	RATTC	4	1994-09-30 00:00:00	1994-10-28 00:00:00	1994-10-06 00:00:00	147.2600	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10295	VINET	2	1994-10-03 00:00:00	1994-10-31 00:00:00	1994-10-11 00:00:00	1.1500	Vins et alcools Chevalier	59 rue de l'Abbaye	Reims	\N	51100	France	\N
10296	LILAS	6	1994-10-04 00:00:00	1994-11-01 00:00:00	1994-10-12 00:00:00	0.1200	LILA-Supermercado	Carrera 52 con Ave. BolÃ­var #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela	\N
10297	BLONP	5	1994-10-05 00:00:00	1994-11-16 00:00:00	1994-10-11 00:00:00	5.7400	Blondel pÃ¨re et fils	24, place KlÃ©ber	Strasbourg	\N	67000	France	\N
10298	HUNGO	6	1994-10-06 00:00:00	1994-11-03 00:00:00	1994-10-12 00:00:00	168.2200	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10299	RICAR	4	1994-10-07 00:00:00	1994-11-04 00:00:00	1994-10-14 00:00:00	29.7600	Ricardo Adocicados	Av. Copacabana, 267	Rio de Janeiro	RJ	02389-890	Brazil	\N
10300	MAGAA	2	1994-10-10 00:00:00	1994-11-07 00:00:00	1994-10-19 00:00:00	17.6800	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy	\N
10301	WANDK	8	1994-10-10 00:00:00	1994-11-07 00:00:00	1994-10-18 00:00:00	45.0800	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany	\N
10302	SUPRD	4	1994-10-11 00:00:00	1994-11-08 00:00:00	1994-11-09 00:00:00	6.2700	SuprÃªmes dÃ©lices	Boulevard Tirou, 255	Charleroi	\N	B-6000	Belgium	\N
10303	GODOS	7	1994-10-12 00:00:00	1994-11-09 00:00:00	1994-10-19 00:00:00	107.8300	Godos Cocina TÃ­pica	C/ Romero, 33	Sevilla	\N	41101	Spain	\N
10304	TORTU	1	1994-10-13 00:00:00	1994-11-10 00:00:00	1994-10-18 00:00:00	63.7900	Tortuga Restaurante	Avda. Azteca 123	MÃ©xico D.F.	\N	05033	Mexico	\N
10305	OLDWO	8	1994-10-14 00:00:00	1994-11-11 00:00:00	1994-11-09 00:00:00	257.6200	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA	\N
10306	ROMEY	1	1994-10-17 00:00:00	1994-11-14 00:00:00	1994-10-24 00:00:00	7.5600	Romero y tomillo	Gran VÃ­a, 1	Madrid	\N	28001	Spain	\N
10307	LONEP	2	1994-10-18 00:00:00	1994-11-15 00:00:00	1994-10-26 00:00:00	0.5600	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA	\N
10308	ANATR	7	1994-10-19 00:00:00	1994-11-16 00:00:00	1994-10-25 00:00:00	1.6100	Ana Trujillo Emparedados y helados	Avda. de la ConstituciÃ³n 2222	MÃ©xico D.F.	\N	05021	Mexico	\N
10309	HUNGO	3	1994-10-20 00:00:00	1994-11-17 00:00:00	1994-11-23 00:00:00	47.3000	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10310	THEBI	8	1994-10-21 00:00:00	1994-11-18 00:00:00	1994-10-28 00:00:00	17.5200	The Big Cheese	89 Jefferson Way\nSuite 2	Portland	OR	97201	USA	\N
10311	DUMON	1	1994-10-21 00:00:00	1994-11-04 00:00:00	1994-10-27 00:00:00	24.6900	Du monde entier	67, rue des Cinquante Otages	Nantes	\N	44000	France	\N
10312	WANDK	2	1994-10-24 00:00:00	1994-11-21 00:00:00	1994-11-03 00:00:00	40.2600	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany	\N
10313	QUICK	2	1994-10-25 00:00:00	1994-11-22 00:00:00	1994-11-04 00:00:00	1.9600	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10314	RATTC	1	1994-10-26 00:00:00	1994-11-23 00:00:00	1994-11-04 00:00:00	74.1600	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10315	ISLAT	4	1994-10-27 00:00:00	1994-11-24 00:00:00	1994-11-03 00:00:00	41.7600	Island Trading	Garden House\nCrowther Way	Cowes	Isle of Wight	PO31 7PJ	UK	\N
10316	RATTC	1	1994-10-28 00:00:00	1994-11-25 00:00:00	1994-11-08 00:00:00	150.1500	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10317	LONEP	6	1994-10-31 00:00:00	1994-11-28 00:00:00	1994-11-10 00:00:00	12.6900	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA	\N
10318	ISLAT	8	1994-11-01 00:00:00	1994-11-29 00:00:00	1994-11-04 00:00:00	4.7300	Island Trading	Garden House\nCrowther Way	Cowes	Isle of Wight	PO31 7PJ	UK	\N
10319	TORTU	7	1994-11-02 00:00:00	1994-11-30 00:00:00	1994-11-11 00:00:00	64.5000	Tortuga Restaurante	Avda. Azteca 123	MÃ©xico D.F.	\N	05033	Mexico	\N
10320	WARTH	5	1994-11-03 00:00:00	1994-11-17 00:00:00	1994-11-18 00:00:00	34.5700	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland	\N
10321	ISLAT	3	1994-11-03 00:00:00	1994-12-01 00:00:00	1994-11-11 00:00:00	3.4300	Island Trading	Garden House\nCrowther Way	Cowes	Isle of Wight	PO31 7PJ	UK	\N
10322	PERIC	7	1994-11-04 00:00:00	1994-12-02 00:00:00	1994-11-23 00:00:00	0.4000	Pericles Comidas clÃ¡sicas	Calle Dr. Jorge Cash 321	MÃ©xico D.F.	\N	05033	Mexico	\N
10323	KOENE	4	1994-11-07 00:00:00	1994-12-05 00:00:00	1994-11-14 00:00:00	4.8800	KÃ¶niglich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany	\N
10324	SAVEA	9	1994-11-08 00:00:00	1994-12-06 00:00:00	1994-11-10 00:00:00	214.2700	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10325	KOENE	1	1994-11-09 00:00:00	1994-11-23 00:00:00	1994-11-14 00:00:00	64.8600	KÃ¶niglich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany	\N
10326	BOLID	4	1994-11-10 00:00:00	1994-12-08 00:00:00	1994-11-14 00:00:00	77.9200	BÃ³lido Comidas preparadas	C/ Araquil, 67	Madrid	\N	28023	Spain	\N
10327	FOLKO	2	1994-11-11 00:00:00	1994-12-09 00:00:00	1994-11-14 00:00:00	63.3600	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10328	FURIB	4	1994-11-14 00:00:00	1994-12-12 00:00:00	1994-11-17 00:00:00	87.0300	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal	\N
10329	SPLIR	4	1994-11-15 00:00:00	1994-12-27 00:00:00	1994-11-23 00:00:00	191.6700	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA	\N
10347	FAMIA	4	1994-12-07 00:00:00	1995-01-04 00:00:00	1994-12-09 00:00:00	3.1000	Familia Arquibaldo	Rua OrÃ³s, 92	SÃ£o Paulo	SP	05442-030	Brazil	\N
10348	WANDK	4	1994-12-08 00:00:00	1995-01-05 00:00:00	1994-12-16 00:00:00	0.7800	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany	\N
10349	SPLIR	7	1994-12-09 00:00:00	1995-01-06 00:00:00	1994-12-16 00:00:00	8.6300	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA	\N
10350	LAMAI	6	1994-12-12 00:00:00	1995-01-09 00:00:00	1995-01-03 00:00:00	64.1900	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France	\N
10351	ERNSH	1	1994-12-12 00:00:00	1995-01-09 00:00:00	1994-12-21 00:00:00	162.3300	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10352	FURIB	3	1994-12-13 00:00:00	1994-12-27 00:00:00	1994-12-19 00:00:00	1.3000	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal	\N
10353	PICCO	7	1994-12-14 00:00:00	1995-01-11 00:00:00	1994-12-26 00:00:00	360.6300	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria	\N
10354	PERIC	8	1994-12-15 00:00:00	1995-01-12 00:00:00	1994-12-21 00:00:00	53.8000	Pericles Comidas clÃ¡sicas	Calle Dr. Jorge Cash 321	MÃ©xico D.F.	\N	05033	Mexico	\N
10355	AROUT	6	1994-12-16 00:00:00	1995-01-13 00:00:00	1994-12-21 00:00:00	41.9500	Around the Horn	Brook Farm\nStratford St. Mary	Colchester	Essex	CO7 6JX	UK	\N
10356	WANDK	6	1994-12-19 00:00:00	1995-01-16 00:00:00	1994-12-28 00:00:00	36.7100	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany	\N
10357	LILAS	1	1994-12-20 00:00:00	1995-01-17 00:00:00	1995-01-02 00:00:00	34.8800	LILA-Supermercado	Carrera 52 con Ave. BolÃ­var #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela	\N
10358	LAMAI	5	1994-12-21 00:00:00	1995-01-18 00:00:00	1994-12-28 00:00:00	19.6400	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France	\N
10359	SEVES	5	1994-12-22 00:00:00	1995-01-19 00:00:00	1994-12-27 00:00:00	288.4300	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK	\N
10360	BLONP	4	1994-12-23 00:00:00	1995-01-20 00:00:00	1995-01-02 00:00:00	131.7000	Blondel pÃ¨re et fils	24, place KlÃ©ber	Strasbourg	\N	67000	France	\N
10361	QUICK	1	1994-12-23 00:00:00	1995-01-20 00:00:00	1995-01-03 00:00:00	183.1700	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10362	BONAP	3	1994-12-26 00:00:00	1995-01-23 00:00:00	1994-12-29 00:00:00	96.0400	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10363	DRACD	4	1994-12-27 00:00:00	1995-01-24 00:00:00	1995-01-04 00:00:00	30.5400	Drachenblut Delikatessen	Walserweg 21	Aachen	\N	52066	Germany	\N
10364	EASTC	1	1994-12-27 00:00:00	1995-02-07 00:00:00	1995-01-04 00:00:00	71.9700	Eastern Connection	35 King George	London	\N	WX3 6FW	UK	\N
10365	ANTON	3	1994-12-28 00:00:00	1995-01-25 00:00:00	1995-01-02 00:00:00	22.0000	Antonio Moreno TaquerÃ­a	Mataderos  2312	MÃ©xico D.F.	\N	05023	Mexico	\N
10366	GALED	8	1994-12-29 00:00:00	1995-02-09 00:00:00	1995-01-30 00:00:00	10.1400	GalerÃ­a del gastronÃ³mo	Rambla de CataluÃ±a, 23	Barcelona	\N	8022	Spain	\N
10367	VAFFE	7	1994-12-29 00:00:00	1995-01-26 00:00:00	1995-01-02 00:00:00	13.5500	Vaffeljernet	SmagslÃ¸get 45	Ã…rhus	\N	8200	Denmark	\N
10368	ERNSH	2	1994-12-30 00:00:00	1995-01-27 00:00:00	1995-01-02 00:00:00	101.9500	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10369	SPLIR	8	1995-01-02 00:00:00	1995-01-30 00:00:00	1995-01-09 00:00:00	195.6800	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA	\N
10370	CHOPS	6	1995-01-03 00:00:00	1995-01-31 00:00:00	1995-01-27 00:00:00	1.1700	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland	\N
10371	LAMAI	1	1995-01-03 00:00:00	1995-01-31 00:00:00	1995-01-24 00:00:00	0.4500	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France	\N
10372	QUEEN	5	1995-01-04 00:00:00	1995-02-01 00:00:00	1995-01-09 00:00:00	890.7800	Queen Cozinha	Alameda dos CanÃ rios, 891	SÃ£o Paulo	SP	05487-020	Brazil	\N
10373	HUNGO	4	1995-01-05 00:00:00	1995-02-02 00:00:00	1995-01-11 00:00:00	124.1200	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10374	WOLZA	1	1995-01-05 00:00:00	1995-02-02 00:00:00	1995-01-09 00:00:00	3.9400	Wolski Zajazd	ul. Filtrowa 68	Warszawa	\N	01-012	Poland	\N
10375	HUNGC	3	1995-01-06 00:00:00	1995-02-03 00:00:00	1995-01-09 00:00:00	20.1200	Hungry Coyote Import Store	City Center Plaza\n516 Main St.	Elgin	OR	97827	USA	\N
10376	MEREP	1	1995-01-09 00:00:00	1995-02-06 00:00:00	1995-01-13 00:00:00	20.3900	MÃ¨re Paillarde	43 rue St. Laurent	MontrÃ©al	QuÃ©bec	H1J 1C3	Canada	\N
10377	SEVES	1	1995-01-09 00:00:00	1995-02-06 00:00:00	1995-01-13 00:00:00	22.2100	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK	\N
10378	FOLKO	5	1995-01-10 00:00:00	1995-02-07 00:00:00	1995-01-19 00:00:00	5.4400	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10379	QUEDE	2	1995-01-11 00:00:00	1995-02-08 00:00:00	1995-01-13 00:00:00	45.0300	Que DelÃ­cia	Rua da Panificadora, 12	Rio de Janeiro	RJ	02389-673	Brazil	\N
10380	HUNGO	8	1995-01-12 00:00:00	1995-02-09 00:00:00	1995-02-16 00:00:00	35.0300	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10381	LILAS	3	1995-01-12 00:00:00	1995-02-09 00:00:00	1995-01-13 00:00:00	7.9900	LILA-Supermercado	Carrera 52 con Ave. BolÃ­var #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela	\N
10382	ERNSH	4	1995-01-13 00:00:00	1995-02-10 00:00:00	1995-01-16 00:00:00	94.7700	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10383	AROUT	8	1995-01-16 00:00:00	1995-02-13 00:00:00	1995-01-18 00:00:00	34.2400	Around the Horn	Brook Farm\nStratford St. Mary	Colchester	Essex	CO7 6JX	UK	\N
10384	BERGS	3	1995-01-16 00:00:00	1995-02-13 00:00:00	1995-01-20 00:00:00	168.6400	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10385	SPLIR	1	1995-01-17 00:00:00	1995-02-14 00:00:00	1995-01-23 00:00:00	30.9600	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA	\N
10386	FAMIA	9	1995-01-18 00:00:00	1995-02-01 00:00:00	1995-01-25 00:00:00	13.9900	Familia Arquibaldo	Rua OrÃ³s, 92	SÃ£o Paulo	SP	05442-030	Brazil	\N
10387	SANTG	1	1995-01-18 00:00:00	1995-02-15 00:00:00	1995-01-20 00:00:00	93.6300	SantÃ© Gourmet	Erling Skakkes gate 78	Stavern	\N	4110	Norway	\N
10388	SEVES	2	1995-01-19 00:00:00	1995-02-16 00:00:00	1995-01-20 00:00:00	34.8600	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK	\N
10389	BOTTM	4	1995-01-20 00:00:00	1995-02-17 00:00:00	1995-01-24 00:00:00	47.4200	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	\N
10390	ERNSH	6	1995-01-23 00:00:00	1995-02-20 00:00:00	1995-01-26 00:00:00	126.3800	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10391	DRACD	3	1995-01-23 00:00:00	1995-02-20 00:00:00	1995-01-31 00:00:00	5.4500	Drachenblut Delikatessen	Walserweg 21	Aachen	\N	52066	Germany	\N
10392	PICCO	2	1995-01-24 00:00:00	1995-02-21 00:00:00	1995-02-01 00:00:00	122.4600	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria	\N
10393	SAVEA	1	1995-01-25 00:00:00	1995-02-22 00:00:00	1995-02-03 00:00:00	126.5600	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10394	HUNGC	1	1995-01-25 00:00:00	1995-02-22 00:00:00	1995-02-03 00:00:00	30.3400	Hungry Coyote Import Store	City Center Plaza\n516 Main St.	Elgin	OR	97827	USA	\N
10395	HILAA	6	1995-01-26 00:00:00	1995-02-23 00:00:00	1995-02-03 00:00:00	184.4100	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10396	FRANK	1	1995-01-27 00:00:00	1995-02-10 00:00:00	1995-02-06 00:00:00	135.3500	Frankenversand	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	\N
10397	PRINI	5	1995-01-27 00:00:00	1995-02-24 00:00:00	1995-02-02 00:00:00	60.2600	Princesa Isabel Vinhos	Estrada da saÃºde n. 58	Lisboa	\N	1756	Portugal	\N
10398	SAVEA	2	1995-01-30 00:00:00	1995-02-27 00:00:00	1995-02-09 00:00:00	89.1600	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10399	VAFFE	8	1995-01-31 00:00:00	1995-02-14 00:00:00	1995-02-08 00:00:00	27.3600	Vaffeljernet	SmagslÃ¸get 45	Ã…rhus	\N	8200	Denmark	\N
10400	EASTC	1	1995-02-01 00:00:00	1995-03-01 00:00:00	1995-02-16 00:00:00	83.9300	Eastern Connection	35 King George	London	\N	WX3 6FW	UK	\N
10401	RATTC	1	1995-02-01 00:00:00	1995-03-01 00:00:00	1995-02-10 00:00:00	12.5100	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10402	ERNSH	8	1995-02-02 00:00:00	1995-03-16 00:00:00	1995-02-10 00:00:00	67.8800	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10403	ERNSH	4	1995-02-03 00:00:00	1995-03-03 00:00:00	1995-02-09 00:00:00	73.7900	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10404	MAGAA	2	1995-02-03 00:00:00	1995-03-03 00:00:00	1995-02-08 00:00:00	155.9700	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy	\N
10405	LINOD	1	1995-02-06 00:00:00	1995-03-06 00:00:00	1995-02-22 00:00:00	34.8200	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela	\N
10406	QUEEN	7	1995-02-07 00:00:00	1995-03-21 00:00:00	1995-02-13 00:00:00	108.0400	Queen Cozinha	Alameda dos CanÃ rios, 891	SÃ£o Paulo	SP	05487-020	Brazil	\N
10407	OTTIK	2	1995-02-07 00:00:00	1995-03-07 00:00:00	1995-03-02 00:00:00	91.4800	Ottilies KÃ¤seladen	Mehrheimerstr. 369	KÃ¶ln	\N	50739	Germany	\N
10408	FOLIG	8	1995-02-08 00:00:00	1995-03-08 00:00:00	1995-02-14 00:00:00	11.2600	Folies gourmandes	184, chaussÃ©e de Tournai	Lille	\N	59000	France	\N
10409	OCEAN	3	1995-02-09 00:00:00	1995-03-09 00:00:00	1995-02-14 00:00:00	29.8300	OcÃ©ano AtlÃ¡ntico Ltda.	Ing. Gustavo Moncada 8585\nPiso 20-A	Buenos Aires	\N	1010	Argentina	\N
10410	BOTTM	3	1995-02-10 00:00:00	1995-03-10 00:00:00	1995-02-15 00:00:00	2.4000	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	\N
10411	BOTTM	9	1995-02-10 00:00:00	1995-03-10 00:00:00	1995-02-21 00:00:00	23.6500	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	\N
10412	WARTH	8	1995-02-13 00:00:00	1995-03-13 00:00:00	1995-02-15 00:00:00	3.7700	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland	\N
10413	LAMAI	3	1995-02-14 00:00:00	1995-03-14 00:00:00	1995-02-16 00:00:00	95.6600	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France	\N
10414	FAMIA	2	1995-02-14 00:00:00	1995-03-14 00:00:00	1995-02-17 00:00:00	21.4800	Familia Arquibaldo	Rua OrÃ³s, 92	SÃ£o Paulo	SP	05442-030	Brazil	\N
10415	HUNGC	3	1995-02-15 00:00:00	1995-03-15 00:00:00	1995-02-24 00:00:00	0.2000	Hungry Coyote Import Store	City Center Plaza\n516 Main St.	Elgin	OR	97827	USA	\N
10416	WARTH	8	1995-02-16 00:00:00	1995-03-16 00:00:00	1995-02-27 00:00:00	22.7200	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland	\N
10417	SIMOB	4	1995-02-16 00:00:00	1995-03-16 00:00:00	1995-02-28 00:00:00	70.2900	Simons bistro	VinbÃ¦ltet 34	KÃ¸benhavn	\N	1734	Denmark	\N
10418	QUICK	4	1995-02-17 00:00:00	1995-03-17 00:00:00	1995-02-24 00:00:00	17.5500	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10419	RICSU	4	1995-02-20 00:00:00	1995-03-20 00:00:00	1995-03-02 00:00:00	137.3500	Richter Supermarkt	Starenweg 5	GenÃ¨ve	\N	1204	Switzerland	\N
10420	WELLI	3	1995-02-21 00:00:00	1995-03-21 00:00:00	1995-02-27 00:00:00	44.1200	Wellington Importadora	Rua do Mercado, 12	Resende	SP	08737-363	Brazil	\N
10421	QUEDE	8	1995-02-21 00:00:00	1995-04-04 00:00:00	1995-02-27 00:00:00	99.2300	Que DelÃ­cia	Rua da Panificadora, 12	Rio de Janeiro	RJ	02389-673	Brazil	\N
10422	FRANS	2	1995-02-22 00:00:00	1995-03-22 00:00:00	1995-03-03 00:00:00	3.0200	Franchi S.p.A.	Via Monte Bianco 34	Torino	\N	10100	Italy	\N
10423	GOURL	6	1995-02-23 00:00:00	1995-03-09 00:00:00	1995-03-27 00:00:00	24.5000	Gourmet Lanchonetes	Av. Brasil, 442	Campinas	SP	04876-786	Brazil	\N
10424	MEREP	7	1995-02-23 00:00:00	1995-03-23 00:00:00	1995-02-27 00:00:00	370.6100	MÃ¨re Paillarde	43 rue St. Laurent	MontrÃ©al	QuÃ©bec	H1J 1C3	Canada	\N
10425	LAMAI	6	1995-02-24 00:00:00	1995-03-24 00:00:00	1995-03-17 00:00:00	7.9300	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France	\N
10426	GALED	4	1995-02-27 00:00:00	1995-03-27 00:00:00	1995-03-09 00:00:00	18.6900	GalerÃ­a del gastronÃ³mo	Rambla de CataluÃ±a, 23	Barcelona	\N	8022	Spain	\N
10427	PICCO	4	1995-02-27 00:00:00	1995-03-27 00:00:00	1995-04-03 00:00:00	31.2900	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria	\N
10428	REGGC	7	1995-02-28 00:00:00	1995-03-28 00:00:00	1995-03-07 00:00:00	11.0900	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy	\N
10429	HUNGO	3	1995-03-01 00:00:00	1995-04-12 00:00:00	1995-03-10 00:00:00	56.6300	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10430	ERNSH	4	1995-03-02 00:00:00	1995-03-16 00:00:00	1995-03-06 00:00:00	458.7800	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10431	BOTTM	4	1995-03-02 00:00:00	1995-03-16 00:00:00	1995-03-10 00:00:00	44.1700	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	\N
10432	SPLIR	3	1995-03-03 00:00:00	1995-03-17 00:00:00	1995-03-10 00:00:00	4.3400	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA	\N
10433	PRINI	3	1995-03-06 00:00:00	1995-04-03 00:00:00	1995-04-04 00:00:00	73.8300	Princesa Isabel Vinhos	Estrada da saÃºde n. 58	Lisboa	\N	1756	Portugal	\N
10434	FOLKO	3	1995-03-06 00:00:00	1995-04-03 00:00:00	1995-03-16 00:00:00	17.9200	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10435	CONSH	8	1995-03-07 00:00:00	1995-04-18 00:00:00	1995-03-10 00:00:00	9.2100	Consolidated Holdings	Berkeley Gardens\n12  Brewery 	London	\N	WX1 6LT	UK	\N
10436	BLONP	3	1995-03-08 00:00:00	1995-04-05 00:00:00	1995-03-14 00:00:00	156.6600	Blondel pÃ¨re et fils	24, place KlÃ©ber	Strasbourg	\N	67000	France	\N
10437	WARTH	8	1995-03-08 00:00:00	1995-04-05 00:00:00	1995-03-15 00:00:00	19.9700	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland	\N
10438	TOMSP	3	1995-03-09 00:00:00	1995-04-06 00:00:00	1995-03-17 00:00:00	8.2400	Toms SpezialitÃ¤ten	Luisenstr. 48	MÃ¼nster	\N	44087	Germany	\N
10439	MEREP	6	1995-03-10 00:00:00	1995-04-07 00:00:00	1995-03-13 00:00:00	4.0700	MÃ¨re Paillarde	43 rue St. Laurent	MontrÃ©al	QuÃ©bec	H1J 1C3	Canada	\N
10440	SAVEA	4	1995-03-13 00:00:00	1995-04-10 00:00:00	1995-03-31 00:00:00	86.5300	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10441	OLDWO	3	1995-03-13 00:00:00	1995-04-24 00:00:00	1995-04-14 00:00:00	73.0200	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA	\N
10442	ERNSH	3	1995-03-14 00:00:00	1995-04-11 00:00:00	1995-03-21 00:00:00	47.9400	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10443	REGGC	8	1995-03-15 00:00:00	1995-04-12 00:00:00	1995-03-17 00:00:00	13.9500	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy	\N
10444	BERGS	3	1995-03-15 00:00:00	1995-04-12 00:00:00	1995-03-24 00:00:00	3.5000	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10445	BERGS	3	1995-03-16 00:00:00	1995-04-13 00:00:00	1995-03-23 00:00:00	9.3000	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10446	TOMSP	6	1995-03-17 00:00:00	1995-04-14 00:00:00	1995-03-22 00:00:00	14.6800	Toms SpezialitÃ¤ten	Luisenstr. 48	MÃ¼nster	\N	44087	Germany	\N
10447	RICAR	4	1995-03-17 00:00:00	1995-04-14 00:00:00	1995-04-07 00:00:00	68.6600	Ricardo Adocicados	Av. Copacabana, 267	Rio de Janeiro	RJ	02389-890	Brazil	\N
10448	RANCH	4	1995-03-20 00:00:00	1995-04-17 00:00:00	1995-03-27 00:00:00	38.8200	Rancho grande	Av. del Libertador 900	Buenos Aires	\N	1010	Argentina	\N
10449	BLONP	3	1995-03-21 00:00:00	1995-04-18 00:00:00	1995-03-30 00:00:00	53.3000	Blondel pÃ¨re et fils	24, place KlÃ©ber	Strasbourg	\N	67000	France	\N
10450	VICTE	8	1995-03-22 00:00:00	1995-04-19 00:00:00	1995-04-11 00:00:00	7.2300	Victuailles en stock	2, rue du Commerce	Lyon	\N	69004	France	\N
10451	QUICK	4	1995-03-22 00:00:00	1995-04-05 00:00:00	1995-04-12 00:00:00	189.0900	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10452	SAVEA	8	1995-03-23 00:00:00	1995-04-20 00:00:00	1995-03-29 00:00:00	140.2600	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10453	AROUT	1	1995-03-24 00:00:00	1995-04-21 00:00:00	1995-03-29 00:00:00	25.3600	Around the Horn	Brook Farm\nStratford St. Mary	Colchester	Essex	CO7 6JX	UK	\N
10454	LAMAI	4	1995-03-24 00:00:00	1995-04-21 00:00:00	1995-03-28 00:00:00	2.7400	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France	\N
10455	WARTH	8	1995-03-27 00:00:00	1995-05-08 00:00:00	1995-04-03 00:00:00	180.4500	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland	\N
10456	KOENE	8	1995-03-28 00:00:00	1995-05-09 00:00:00	1995-03-31 00:00:00	8.1200	KÃ¶niglich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany	\N
10457	KOENE	2	1995-03-28 00:00:00	1995-04-25 00:00:00	1995-04-03 00:00:00	11.5700	KÃ¶niglich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany	\N
10458	SUPRD	7	1995-03-29 00:00:00	1995-04-26 00:00:00	1995-04-04 00:00:00	147.0600	SuprÃªmes dÃ©lices	Boulevard Tirou, 255	Charleroi	\N	B-6000	Belgium	\N
10459	VICTE	4	1995-03-30 00:00:00	1995-04-27 00:00:00	1995-03-31 00:00:00	25.0900	Victuailles en stock	2, rue du Commerce	Lyon	\N	69004	France	\N
10460	FOLKO	8	1995-03-31 00:00:00	1995-04-28 00:00:00	1995-04-03 00:00:00	16.2700	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10461	LILAS	1	1995-03-31 00:00:00	1995-04-28 00:00:00	1995-04-05 00:00:00	148.6100	LILA-Supermercado	Carrera 52 con Ave. BolÃ­var #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela	\N
10462	CONSH	2	1995-04-03 00:00:00	1995-05-01 00:00:00	1995-04-18 00:00:00	6.1700	Consolidated Holdings	Berkeley Gardens\n12  Brewery 	London	\N	WX1 6LT	UK	\N
10463	SUPRD	5	1995-04-04 00:00:00	1995-05-02 00:00:00	1995-04-06 00:00:00	14.7800	SuprÃªmes dÃ©lices	Boulevard Tirou, 255	Charleroi	\N	B-6000	Belgium	\N
10464	FURIB	4	1995-04-04 00:00:00	1995-05-02 00:00:00	1995-04-14 00:00:00	89.0000	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal	\N
10465	VAFFE	1	1995-04-05 00:00:00	1995-05-03 00:00:00	1995-04-14 00:00:00	145.0400	Vaffeljernet	SmagslÃ¸get 45	Ã…rhus	\N	8200	Denmark	\N
10466	COMMI	4	1995-04-06 00:00:00	1995-05-04 00:00:00	1995-04-13 00:00:00	11.9300	ComÃ©rcio Mineiro	Av. dos LusÃ­adas, 23	SÃ£o Paulo	SP	05432-043	Brazil	\N
10467	MAGAA	8	1995-04-06 00:00:00	1995-05-04 00:00:00	1995-04-11 00:00:00	4.9300	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy	\N
10468	KOENE	3	1995-04-07 00:00:00	1995-05-05 00:00:00	1995-04-12 00:00:00	44.1200	KÃ¶niglich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany	\N
10469	WHITC	1	1995-04-10 00:00:00	1995-05-08 00:00:00	1995-04-14 00:00:00	60.1800	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA	\N
10470	BONAP	4	1995-04-11 00:00:00	1995-05-09 00:00:00	1995-04-14 00:00:00	64.5600	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10471	BSBEV	2	1995-04-11 00:00:00	1995-05-09 00:00:00	1995-04-18 00:00:00	45.5900	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK	\N
10472	SEVES	8	1995-04-12 00:00:00	1995-05-10 00:00:00	1995-04-19 00:00:00	4.2000	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK	\N
10473	ISLAT	1	1995-04-13 00:00:00	1995-04-27 00:00:00	1995-04-21 00:00:00	16.3700	Island Trading	Garden House\nCrowther Way	Cowes	Isle of Wight	PO31 7PJ	UK	\N
10474	PERIC	5	1995-04-13 00:00:00	1995-05-11 00:00:00	1995-04-21 00:00:00	83.4900	Pericles Comidas clÃ¡sicas	Calle Dr. Jorge Cash 321	MÃ©xico D.F.	\N	05033	Mexico	\N
10475	SUPRD	9	1995-04-14 00:00:00	1995-05-12 00:00:00	1995-05-05 00:00:00	68.5200	SuprÃªmes dÃ©lices	Boulevard Tirou, 255	Charleroi	\N	B-6000	Belgium	\N
10476	HILAA	8	1995-04-17 00:00:00	1995-05-15 00:00:00	1995-04-24 00:00:00	4.4100	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10477	PRINI	5	1995-04-17 00:00:00	1995-05-15 00:00:00	1995-04-25 00:00:00	13.0200	Princesa Isabel Vinhos	Estrada da saÃºde n. 58	Lisboa	\N	1756	Portugal	\N
10478	VICTE	2	1995-04-18 00:00:00	1995-05-02 00:00:00	1995-04-26 00:00:00	4.8100	Victuailles en stock	2, rue du Commerce	Lyon	\N	69004	France	\N
10479	RATTC	3	1995-04-19 00:00:00	1995-05-17 00:00:00	1995-04-21 00:00:00	708.9500	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10480	FOLIG	6	1995-04-20 00:00:00	1995-05-18 00:00:00	1995-04-24 00:00:00	1.3500	Folies gourmandes	184, chaussÃ©e de Tournai	Lille	\N	59000	France	\N
10481	RICAR	8	1995-04-20 00:00:00	1995-05-18 00:00:00	1995-04-25 00:00:00	64.3300	Ricardo Adocicados	Av. Copacabana, 267	Rio de Janeiro	RJ	02389-890	Brazil	\N
10482	LAZYK	1	1995-04-21 00:00:00	1995-05-19 00:00:00	1995-05-11 00:00:00	7.4800	Lazy K Kountry Store	12 Orchestra Terrace	Walla Walla	WA	99362	USA	\N
10483	WHITC	7	1995-04-24 00:00:00	1995-05-22 00:00:00	1995-05-26 00:00:00	15.2800	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA	\N
10484	BSBEV	3	1995-04-24 00:00:00	1995-05-22 00:00:00	1995-05-02 00:00:00	6.8800	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK	\N
10485	LINOD	4	1995-04-25 00:00:00	1995-05-09 00:00:00	1995-05-01 00:00:00	64.4500	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela	\N
10486	HILAA	1	1995-04-26 00:00:00	1995-05-24 00:00:00	1995-05-03 00:00:00	30.5300	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10487	QUEEN	2	1995-04-26 00:00:00	1995-05-24 00:00:00	1995-04-28 00:00:00	71.0700	Queen Cozinha	Alameda dos CanÃ rios, 891	SÃ£o Paulo	SP	05487-020	Brazil	\N
10488	FRANK	8	1995-04-27 00:00:00	1995-05-25 00:00:00	1995-05-03 00:00:00	4.9300	Frankenversand	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	\N
10489	PICCO	6	1995-04-28 00:00:00	1995-05-26 00:00:00	1995-05-10 00:00:00	5.2900	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria	\N
10490	HILAA	7	1995-05-01 00:00:00	1995-05-29 00:00:00	1995-05-04 00:00:00	210.1900	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10491	FURIB	8	1995-05-01 00:00:00	1995-05-29 00:00:00	1995-05-09 00:00:00	16.9600	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal	\N
10492	BOTTM	3	1995-05-02 00:00:00	1995-05-30 00:00:00	1995-05-12 00:00:00	62.8900	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	\N
10493	LAMAI	4	1995-05-03 00:00:00	1995-05-31 00:00:00	1995-05-11 00:00:00	10.6400	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France	\N
10494	COMMI	4	1995-05-03 00:00:00	1995-05-31 00:00:00	1995-05-10 00:00:00	65.9900	ComÃ©rcio Mineiro	Av. dos LusÃ­adas, 23	SÃ£o Paulo	SP	05432-043	Brazil	\N
10495	LAUGB	3	1995-05-04 00:00:00	1995-06-01 00:00:00	1995-05-12 00:00:00	4.6500	Laughing Bacchus Wine Cellars	2319 Elm St.	Vancouver	BC	V3F 2K1	Canada	\N
10496	TRADH	7	1995-05-05 00:00:00	1995-06-02 00:00:00	1995-05-08 00:00:00	46.7700	TradiÃ§Ã£o Hipermercados	Av. InÃªs de Castro, 414	SÃ£o Paulo	SP	05634-030	Brazil	\N
10497	LEHMS	7	1995-05-05 00:00:00	1995-06-02 00:00:00	1995-05-08 00:00:00	36.2100	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	\N
10498	HILAA	8	1995-05-08 00:00:00	1995-06-05 00:00:00	1995-05-12 00:00:00	29.7500	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10499	LILAS	4	1995-05-09 00:00:00	1995-06-06 00:00:00	1995-05-17 00:00:00	102.0200	LILA-Supermercado	Carrera 52 con Ave. BolÃ­var #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela	\N
10500	LAMAI	6	1995-05-10 00:00:00	1995-06-07 00:00:00	1995-05-18 00:00:00	42.6800	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France	\N
10501	BLAUS	9	1995-05-10 00:00:00	1995-06-07 00:00:00	1995-05-17 00:00:00	8.8500	Blauer See Delikatessen	Forsterstr. 57	Mannheim	\N	68306	Germany	\N
10502	PERIC	2	1995-05-11 00:00:00	1995-06-08 00:00:00	1995-05-30 00:00:00	69.3200	Pericles Comidas clÃ¡sicas	Calle Dr. Jorge Cash 321	MÃ©xico D.F.	\N	05033	Mexico	\N
10503	HUNGO	6	1995-05-12 00:00:00	1995-06-09 00:00:00	1995-05-17 00:00:00	16.7400	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10504	WHITC	4	1995-05-12 00:00:00	1995-06-09 00:00:00	1995-05-19 00:00:00	59.1300	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA	\N
10505	MEREP	3	1995-05-15 00:00:00	1995-06-12 00:00:00	1995-05-22 00:00:00	7.1300	MÃ¨re Paillarde	43 rue St. Laurent	MontrÃ©al	QuÃ©bec	H1J 1C3	Canada	\N
10506	KOENE	9	1995-05-16 00:00:00	1995-06-13 00:00:00	1995-06-02 00:00:00	21.1900	KÃ¶niglich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany	\N
10507	ANTON	7	1995-05-16 00:00:00	1995-06-13 00:00:00	1995-05-23 00:00:00	47.4500	Antonio Moreno TaquerÃ­a	Mataderos  2312	MÃ©xico D.F.	\N	05023	Mexico	\N
10508	OTTIK	1	1995-05-17 00:00:00	1995-06-14 00:00:00	1995-06-13 00:00:00	4.9900	Ottilies KÃ¤seladen	Mehrheimerstr. 369	KÃ¶ln	\N	50739	Germany	\N
10509	BLAUS	4	1995-05-18 00:00:00	1995-06-15 00:00:00	1995-05-30 00:00:00	0.1500	Blauer See Delikatessen	Forsterstr. 57	Mannheim	\N	68306	Germany	\N
10510	SAVEA	6	1995-05-19 00:00:00	1995-06-16 00:00:00	1995-05-29 00:00:00	367.6300	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10511	BONAP	4	1995-05-19 00:00:00	1995-06-16 00:00:00	1995-05-22 00:00:00	350.6400	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10512	FAMIA	7	1995-05-22 00:00:00	1995-06-19 00:00:00	1995-05-25 00:00:00	3.5300	Familia Arquibaldo	Rua OrÃ³s, 92	SÃ£o Paulo	SP	05442-030	Brazil	\N
10513	WANDK	7	1995-05-23 00:00:00	1995-07-04 00:00:00	1995-05-29 00:00:00	105.6500	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany	\N
10514	ERNSH	3	1995-05-23 00:00:00	1995-06-20 00:00:00	1995-06-16 00:00:00	789.9500	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10515	QUICK	2	1995-05-24 00:00:00	1995-06-07 00:00:00	1995-06-23 00:00:00	204.4700	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10516	HUNGO	2	1995-05-25 00:00:00	1995-06-22 00:00:00	1995-06-01 00:00:00	62.7800	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10517	NORTS	3	1995-05-25 00:00:00	1995-06-22 00:00:00	1995-05-30 00:00:00	32.0700	North/South	South House\n300 Queensbridge	London	\N	SW7 1RZ	UK	\N
10518	TORTU	4	1995-05-26 00:00:00	1995-06-09 00:00:00	1995-06-05 00:00:00	218.1500	Tortuga Restaurante	Avda. Azteca 123	MÃ©xico D.F.	\N	05033	Mexico	\N
10519	CHOPS	6	1995-05-29 00:00:00	1995-06-26 00:00:00	1995-06-01 00:00:00	91.7600	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland	\N
10520	SANTG	7	1995-05-30 00:00:00	1995-06-27 00:00:00	1995-06-01 00:00:00	13.3700	SantÃ© Gourmet	Erling Skakkes gate 78	Stavern	\N	4110	Norway	\N
10521	CACTU	8	1995-05-30 00:00:00	1995-06-27 00:00:00	1995-06-02 00:00:00	17.2200	Cactus Comidas para llevar	Cerrito 333	Buenos Aires	\N	1010	Argentina	\N
10522	LEHMS	4	1995-05-31 00:00:00	1995-06-28 00:00:00	1995-06-06 00:00:00	45.3300	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	\N
10523	SEVES	7	1995-06-01 00:00:00	1995-06-29 00:00:00	1995-06-30 00:00:00	77.6300	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK	\N
10524	BERGS	1	1995-06-01 00:00:00	1995-06-29 00:00:00	1995-06-07 00:00:00	244.7900	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10525	BONAP	1	1995-06-02 00:00:00	1995-06-30 00:00:00	1995-06-23 00:00:00	11.0600	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10526	WARTH	4	1995-06-05 00:00:00	1995-07-03 00:00:00	1995-06-15 00:00:00	58.5900	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland	\N
10527	QUICK	7	1995-06-05 00:00:00	1995-07-03 00:00:00	1995-06-07 00:00:00	41.9000	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10528	GREAL	6	1995-06-06 00:00:00	1995-06-20 00:00:00	1995-06-09 00:00:00	3.3500	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA	\N
10529	MAISD	5	1995-06-07 00:00:00	1995-07-05 00:00:00	1995-06-09 00:00:00	66.6900	Maison Dewey	Rue Joseph-Bens 532	Bruxelles	\N	B-1180	Belgium	\N
10530	PICCO	3	1995-06-08 00:00:00	1995-07-06 00:00:00	1995-06-12 00:00:00	339.2200	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria	\N
10531	OCEAN	7	1995-06-08 00:00:00	1995-07-06 00:00:00	1995-06-19 00:00:00	8.1200	OcÃ©ano AtlÃ¡ntico Ltda.	Ing. Gustavo Moncada 8585\nPiso 20-A	Buenos Aires	\N	1010	Argentina	\N
10532	EASTC	7	1995-06-09 00:00:00	1995-07-07 00:00:00	1995-06-12 00:00:00	74.4600	Eastern Connection	35 King George	London	\N	WX3 6FW	UK	\N
10533	FOLKO	8	1995-06-12 00:00:00	1995-07-10 00:00:00	1995-06-22 00:00:00	188.0400	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10534	LEHMS	8	1995-06-12 00:00:00	1995-07-10 00:00:00	1995-06-14 00:00:00	27.9400	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	\N
10535	ANTON	4	1995-06-13 00:00:00	1995-07-11 00:00:00	1995-06-21 00:00:00	15.6400	Antonio Moreno TaquerÃ­a	Mataderos  2312	MÃ©xico D.F.	\N	05023	Mexico	\N
10536	LEHMS	3	1995-06-14 00:00:00	1995-07-12 00:00:00	1995-07-07 00:00:00	58.8800	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	\N
10537	RICSU	1	1995-06-14 00:00:00	1995-06-28 00:00:00	1995-06-19 00:00:00	78.8500	Richter Supermarkt	Starenweg 5	GenÃ¨ve	\N	1204	Switzerland	\N
10538	BSBEV	9	1995-06-15 00:00:00	1995-07-13 00:00:00	1995-06-16 00:00:00	4.8700	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK	\N
10539	BSBEV	6	1995-06-16 00:00:00	1995-07-14 00:00:00	1995-06-23 00:00:00	12.3600	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK	\N
10540	QUICK	3	1995-06-19 00:00:00	1995-07-17 00:00:00	1995-07-14 00:00:00	1007.6400	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10541	HANAR	2	1995-06-19 00:00:00	1995-07-17 00:00:00	1995-06-29 00:00:00	68.6500	Hanari Carnes	Rua do PaÃ§o, 67	Rio de Janeiro	RJ	05454-876	Brazil	\N
10542	KOENE	1	1995-06-20 00:00:00	1995-07-18 00:00:00	1995-06-26 00:00:00	10.9500	KÃ¶niglich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany	\N
10543	LILAS	8	1995-06-21 00:00:00	1995-07-19 00:00:00	1995-06-23 00:00:00	48.1700	LILA-Supermercado	Carrera 52 con Ave. BolÃ­var #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela	\N
10544	LONEP	4	1995-06-21 00:00:00	1995-07-19 00:00:00	1995-06-30 00:00:00	24.9100	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA	\N
10545	LAZYK	8	1995-06-22 00:00:00	1995-07-20 00:00:00	1995-07-27 00:00:00	11.9200	Lazy K Kountry Store	12 Orchestra Terrace	Walla Walla	WA	99362	USA	\N
10546	VICTE	1	1995-06-23 00:00:00	1995-07-21 00:00:00	1995-06-27 00:00:00	194.7200	Victuailles en stock	2, rue du Commerce	Lyon	\N	69004	France	\N
10547	SEVES	3	1995-06-23 00:00:00	1995-07-21 00:00:00	1995-07-03 00:00:00	178.4300	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK	\N
10548	TOMSP	3	1995-06-26 00:00:00	1995-07-24 00:00:00	1995-07-03 00:00:00	1.4300	Toms SpezialitÃ¤ten	Luisenstr. 48	MÃ¼nster	\N	44087	Germany	\N
10549	QUICK	5	1995-06-27 00:00:00	1995-07-11 00:00:00	1995-06-30 00:00:00	171.2400	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10550	GODOS	7	1995-06-28 00:00:00	1995-07-26 00:00:00	1995-07-07 00:00:00	4.3200	Godos Cocina TÃ­pica	C/ Romero, 33	Sevilla	\N	41101	Spain	\N
10551	FURIB	4	1995-06-28 00:00:00	1995-08-09 00:00:00	1995-07-07 00:00:00	72.9500	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal	\N
10552	HILAA	2	1995-06-29 00:00:00	1995-07-27 00:00:00	1995-07-06 00:00:00	83.2200	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10553	WARTH	2	1995-06-30 00:00:00	1995-07-28 00:00:00	1995-07-04 00:00:00	149.4900	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland	\N
10554	OTTIK	4	1995-06-30 00:00:00	1995-07-28 00:00:00	1995-07-06 00:00:00	120.9700	Ottilies KÃ¤seladen	Mehrheimerstr. 369	KÃ¶ln	\N	50739	Germany	\N
10555	SAVEA	6	1995-07-03 00:00:00	1995-07-31 00:00:00	1995-07-05 00:00:00	252.4900	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10556	SIMOB	2	1995-07-04 00:00:00	1995-08-15 00:00:00	1995-07-14 00:00:00	9.8000	Simons bistro	VinbÃ¦ltet 34	KÃ¸benhavn	\N	1734	Denmark	\N
10557	LEHMS	9	1995-07-04 00:00:00	1995-07-18 00:00:00	1995-07-07 00:00:00	96.7200	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	\N
10558	AROUT	1	1995-07-05 00:00:00	1995-08-02 00:00:00	1995-07-11 00:00:00	72.9700	Around the Horn	Brook Farm\nStratford St. Mary	Colchester	Essex	CO7 6JX	UK	\N
10559	BLONP	6	1995-07-06 00:00:00	1995-08-03 00:00:00	1995-07-14 00:00:00	8.0500	Blondel pÃ¨re et fils	24, place KlÃ©ber	Strasbourg	\N	67000	France	\N
10560	FRANK	8	1995-07-07 00:00:00	1995-08-04 00:00:00	1995-07-10 00:00:00	36.6500	Frankenversand	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	\N
10561	FOLKO	2	1995-07-07 00:00:00	1995-08-04 00:00:00	1995-07-10 00:00:00	242.2100	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10562	REGGC	1	1995-07-10 00:00:00	1995-08-07 00:00:00	1995-07-13 00:00:00	22.9500	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy	\N
10563	RICAR	2	1995-07-11 00:00:00	1995-08-22 00:00:00	1995-07-25 00:00:00	60.4300	Ricardo Adocicados	Av. Copacabana, 267	Rio de Janeiro	RJ	02389-890	Brazil	\N
10564	RATTC	4	1995-07-11 00:00:00	1995-08-08 00:00:00	1995-07-17 00:00:00	13.7500	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10565	MEREP	8	1995-07-12 00:00:00	1995-08-09 00:00:00	1995-07-19 00:00:00	7.1500	MÃ¨re Paillarde	43 rue St. Laurent	MontrÃ©al	QuÃ©bec	H1J 1C3	Canada	\N
10566	BLONP	9	1995-07-13 00:00:00	1995-08-10 00:00:00	1995-07-19 00:00:00	88.4000	Blondel pÃ¨re et fils	24, place KlÃ©ber	Strasbourg	\N	67000	France	\N
10567	HUNGO	1	1995-07-13 00:00:00	1995-08-10 00:00:00	1995-07-18 00:00:00	33.9700	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10568	GALED	3	1995-07-14 00:00:00	1995-08-11 00:00:00	1995-08-09 00:00:00	6.5400	GalerÃ­a del gastronÃ³mo	Rambla de CataluÃ±a, 23	Barcelona	\N	8022	Spain	\N
10569	RATTC	5	1995-07-17 00:00:00	1995-08-14 00:00:00	1995-08-11 00:00:00	58.9800	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10570	MEREP	3	1995-07-18 00:00:00	1995-08-15 00:00:00	1995-07-20 00:00:00	188.9900	MÃ¨re Paillarde	43 rue St. Laurent	MontrÃ©al	QuÃ©bec	H1J 1C3	Canada	\N
10571	ERNSH	8	1995-07-18 00:00:00	1995-08-29 00:00:00	1995-08-04 00:00:00	26.0600	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10572	BERGS	3	1995-07-19 00:00:00	1995-08-16 00:00:00	1995-07-26 00:00:00	116.4300	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10573	ANTON	7	1995-07-20 00:00:00	1995-08-17 00:00:00	1995-07-21 00:00:00	84.8400	Antonio Moreno TaquerÃ­a	Mataderos  2312	MÃ©xico D.F.	\N	05023	Mexico	\N
10574	TRAIH	4	1995-07-20 00:00:00	1995-08-17 00:00:00	1995-07-31 00:00:00	37.6000	Trail's Head Gourmet Provisioners	722 DaVinci Blvd.	Kirkland	WA	98034	USA	\N
10575	MORGK	5	1995-07-21 00:00:00	1995-08-04 00:00:00	1995-07-31 00:00:00	127.3400	Morgenstern Gesundkost	Heerstr. 22	Leipzig	\N	04179	Germany	\N
10576	TORTU	3	1995-07-24 00:00:00	1995-08-07 00:00:00	1995-07-31 00:00:00	18.5600	Tortuga Restaurante	Avda. Azteca 123	MÃ©xico D.F.	\N	05033	Mexico	\N
10577	TRAIH	9	1995-07-24 00:00:00	1995-09-04 00:00:00	1995-07-31 00:00:00	25.4100	Trail's Head Gourmet Provisioners	722 DaVinci Blvd.	Kirkland	WA	98034	USA	\N
10578	BSBEV	4	1995-07-25 00:00:00	1995-08-22 00:00:00	1995-08-25 00:00:00	29.6000	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK	\N
10579	LETSS	1	1995-07-26 00:00:00	1995-08-23 00:00:00	1995-08-04 00:00:00	13.7300	Let's Stop N Shop	87 Polk St.\nSuite 5	San Francisco	CA	94117	USA	\N
10580	OTTIK	4	1995-07-27 00:00:00	1995-08-24 00:00:00	1995-08-01 00:00:00	75.8900	Ottilies KÃ¤seladen	Mehrheimerstr. 369	KÃ¶ln	\N	50739	Germany	\N
10581	FAMIA	3	1995-07-27 00:00:00	1995-08-24 00:00:00	1995-08-02 00:00:00	3.0100	Familia Arquibaldo	Rua OrÃ³s, 92	SÃ£o Paulo	SP	05442-030	Brazil	\N
10582	BLAUS	3	1995-07-28 00:00:00	1995-08-25 00:00:00	1995-08-14 00:00:00	27.7100	Blauer See Delikatessen	Forsterstr. 57	Mannheim	\N	68306	Germany	\N
10583	WARTH	2	1995-07-31 00:00:00	1995-08-28 00:00:00	1995-08-04 00:00:00	7.2800	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland	\N
10584	BLONP	4	1995-07-31 00:00:00	1995-08-28 00:00:00	1995-08-04 00:00:00	59.1400	Blondel pÃ¨re et fils	24, place KlÃ©ber	Strasbourg	\N	67000	France	\N
10585	WELLI	7	1995-08-01 00:00:00	1995-08-29 00:00:00	1995-08-10 00:00:00	13.4100	Wellington Importadora	Rua do Mercado, 12	Resende	SP	08737-363	Brazil	\N
10586	REGGC	9	1995-08-02 00:00:00	1995-08-30 00:00:00	1995-08-09 00:00:00	0.4800	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy	\N
10587	QUEDE	1	1995-08-02 00:00:00	1995-08-30 00:00:00	1995-08-09 00:00:00	62.5200	Que DelÃ­cia	Rua da Panificadora, 12	Rio de Janeiro	RJ	02389-673	Brazil	\N
10588	QUICK	2	1995-08-03 00:00:00	1995-08-31 00:00:00	1995-08-10 00:00:00	194.6700	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10589	GREAL	8	1995-08-04 00:00:00	1995-09-01 00:00:00	1995-08-14 00:00:00	4.4200	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA	\N
10590	MEREP	4	1995-08-07 00:00:00	1995-09-04 00:00:00	1995-08-14 00:00:00	44.7700	MÃ¨re Paillarde	43 rue St. Laurent	MontrÃ©al	QuÃ©bec	H1J 1C3	Canada	\N
10591	VAFFE	1	1995-08-07 00:00:00	1995-08-21 00:00:00	1995-08-16 00:00:00	55.9200	Vaffeljernet	SmagslÃ¸get 45	Ã…rhus	\N	8200	Denmark	\N
10592	LEHMS	3	1995-08-08 00:00:00	1995-09-05 00:00:00	1995-08-16 00:00:00	32.1000	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	\N
10593	LEHMS	7	1995-08-09 00:00:00	1995-09-06 00:00:00	1995-09-13 00:00:00	174.2000	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	\N
10594	OLDWO	3	1995-08-09 00:00:00	1995-09-06 00:00:00	1995-08-16 00:00:00	5.2400	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA	\N
10595	ERNSH	2	1995-08-10 00:00:00	1995-09-07 00:00:00	1995-08-14 00:00:00	96.7800	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10596	WHITC	8	1995-08-11 00:00:00	1995-09-08 00:00:00	1995-09-12 00:00:00	16.3400	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA	\N
10597	PICCO	7	1995-08-11 00:00:00	1995-09-08 00:00:00	1995-08-18 00:00:00	35.1200	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria	\N
10598	RATTC	1	1995-08-14 00:00:00	1995-09-11 00:00:00	1995-08-18 00:00:00	44.4200	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10599	BSBEV	6	1995-08-15 00:00:00	1995-09-26 00:00:00	1995-08-21 00:00:00	29.9800	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK	\N
10600	HUNGC	4	1995-08-16 00:00:00	1995-09-13 00:00:00	1995-08-21 00:00:00	45.1300	Hungry Coyote Import Store	City Center Plaza\n516 Main St.	Elgin	OR	97827	USA	\N
10601	HILAA	7	1995-08-16 00:00:00	1995-09-27 00:00:00	1995-08-22 00:00:00	58.3000	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10602	VAFFE	8	1995-08-17 00:00:00	1995-09-14 00:00:00	1995-08-22 00:00:00	2.9200	Vaffeljernet	SmagslÃ¸get 45	Ã…rhus	\N	8200	Denmark	\N
10603	SAVEA	8	1995-08-18 00:00:00	1995-09-15 00:00:00	1995-09-08 00:00:00	48.7700	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10604	FURIB	1	1995-08-18 00:00:00	1995-09-15 00:00:00	1995-08-29 00:00:00	7.4600	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal	\N
10605	MEREP	1	1995-08-21 00:00:00	1995-09-18 00:00:00	1995-08-29 00:00:00	379.1300	MÃ¨re Paillarde	43 rue St. Laurent	MontrÃ©al	QuÃ©bec	H1J 1C3	Canada	\N
10606	TRADH	4	1995-08-22 00:00:00	1995-09-19 00:00:00	1995-08-31 00:00:00	79.4000	TradiÃ§Ã£o Hipermercados	Av. InÃªs de Castro, 414	SÃ£o Paulo	SP	05634-030	Brazil	\N
10607	SAVEA	5	1995-08-22 00:00:00	1995-09-19 00:00:00	1995-08-25 00:00:00	200.2400	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10608	TOMSP	4	1995-08-23 00:00:00	1995-09-20 00:00:00	1995-09-01 00:00:00	27.7900	Toms SpezialitÃ¤ten	Luisenstr. 48	MÃ¼nster	\N	44087	Germany	\N
10609	DUMON	7	1995-08-24 00:00:00	1995-09-21 00:00:00	1995-08-30 00:00:00	1.8500	Du monde entier	67, rue des Cinquante Otages	Nantes	\N	44000	France	\N
10610	LAMAI	8	1995-08-25 00:00:00	1995-09-22 00:00:00	1995-09-06 00:00:00	26.7800	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France	\N
10611	WOLZA	6	1995-08-25 00:00:00	1995-09-22 00:00:00	1995-09-01 00:00:00	80.6500	Wolski Zajazd	ul. Filtrowa 68	Warszawa	\N	01-012	Poland	\N
10612	SAVEA	1	1995-08-28 00:00:00	1995-09-25 00:00:00	1995-09-01 00:00:00	544.0800	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10613	HILAA	4	1995-08-29 00:00:00	1995-09-26 00:00:00	1995-09-01 00:00:00	8.1100	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10614	BLAUS	8	1995-08-29 00:00:00	1995-09-26 00:00:00	1995-09-01 00:00:00	1.9300	Blauer See Delikatessen	Forsterstr. 57	Mannheim	\N	68306	Germany	\N
10615	WILMK	2	1995-08-30 00:00:00	1995-09-27 00:00:00	1995-09-06 00:00:00	0.7500	Wilman Kala	Keskuskatu 45	Helsinki	\N	21240	Finland	\N
10616	GREAL	1	1995-08-31 00:00:00	1995-09-28 00:00:00	1995-09-05 00:00:00	116.5300	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA	\N
10617	GREAL	4	1995-08-31 00:00:00	1995-09-28 00:00:00	1995-09-04 00:00:00	18.5300	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA	\N
10618	MEREP	1	1995-09-01 00:00:00	1995-10-13 00:00:00	1995-09-08 00:00:00	154.6800	MÃ¨re Paillarde	43 rue St. Laurent	MontrÃ©al	QuÃ©bec	H1J 1C3	Canada	\N
10619	MEREP	3	1995-09-04 00:00:00	1995-10-02 00:00:00	1995-09-07 00:00:00	91.0500	MÃ¨re Paillarde	43 rue St. Laurent	MontrÃ©al	QuÃ©bec	H1J 1C3	Canada	\N
10620	LAUGB	2	1995-09-05 00:00:00	1995-10-03 00:00:00	1995-09-14 00:00:00	0.9400	Laughing Bacchus Wine Cellars	2319 Elm St.	Vancouver	BC	V3F 2K1	Canada	\N
10621	ISLAT	4	1995-09-05 00:00:00	1995-10-03 00:00:00	1995-09-11 00:00:00	23.7300	Island Trading	Garden House\nCrowther Way	Cowes	Isle of Wight	PO31 7PJ	UK	\N
10836	ERNSH	7	1996-02-16 00:00:00	1996-03-15 00:00:00	1996-02-21 00:00:00	411.8800	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10622	RICAR	4	1995-09-06 00:00:00	1995-10-04 00:00:00	1995-09-11 00:00:00	50.9700	Ricardo Adocicados	Av. Copacabana, 267	Rio de Janeiro	RJ	02389-890	Brazil	\N
10623	FRANK	8	1995-09-07 00:00:00	1995-10-05 00:00:00	1995-09-12 00:00:00	97.1800	Frankenversand	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	\N
10624	THECR	4	1995-09-07 00:00:00	1995-10-05 00:00:00	1995-09-19 00:00:00	94.8000	The Cracker Box	55 Grizzly Peak Rd.	Butte	MT	59801	USA	\N
10625	ANATR	3	1995-09-08 00:00:00	1995-10-06 00:00:00	1995-09-14 00:00:00	43.9000	Ana Trujillo Emparedados y helados	Avda. de la ConstituciÃ³n 2222	MÃ©xico D.F.	\N	05021	Mexico	\N
10626	BERGS	1	1995-09-11 00:00:00	1995-10-09 00:00:00	1995-09-20 00:00:00	138.6900	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10627	SAVEA	8	1995-09-11 00:00:00	1995-10-23 00:00:00	1995-09-21 00:00:00	107.4600	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10628	BLONP	4	1995-09-12 00:00:00	1995-10-10 00:00:00	1995-09-20 00:00:00	30.3600	Blondel pÃ¨re et fils	24, place KlÃ©ber	Strasbourg	\N	67000	France	\N
10629	GODOS	4	1995-09-12 00:00:00	1995-10-10 00:00:00	1995-09-20 00:00:00	85.4600	Godos Cocina TÃ­pica	C/ Romero, 33	Sevilla	\N	41101	Spain	\N
10630	KOENE	1	1995-09-13 00:00:00	1995-10-11 00:00:00	1995-09-19 00:00:00	32.3500	KÃ¶niglich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany	\N
10631	LAMAI	8	1995-09-14 00:00:00	1995-10-12 00:00:00	1995-09-15 00:00:00	0.8700	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France	\N
10632	WANDK	8	1995-09-14 00:00:00	1995-10-12 00:00:00	1995-09-19 00:00:00	41.3800	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany	\N
10633	ERNSH	7	1995-09-15 00:00:00	1995-10-13 00:00:00	1995-09-18 00:00:00	477.9000	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10634	FOLIG	4	1995-09-15 00:00:00	1995-10-13 00:00:00	1995-09-21 00:00:00	487.3800	Folies gourmandes	184, chaussÃ©e de Tournai	Lille	\N	59000	France	\N
10635	MAGAA	8	1995-09-18 00:00:00	1995-10-16 00:00:00	1995-09-21 00:00:00	47.4600	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy	\N
10636	WARTH	4	1995-09-19 00:00:00	1995-10-17 00:00:00	1995-09-26 00:00:00	1.1500	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland	\N
10637	QUEEN	6	1995-09-19 00:00:00	1995-10-17 00:00:00	1995-09-26 00:00:00	201.2900	Queen Cozinha	Alameda dos CanÃ rios, 891	SÃ£o Paulo	SP	05487-020	Brazil	\N
10638	LINOD	3	1995-09-20 00:00:00	1995-10-18 00:00:00	1995-10-02 00:00:00	158.4400	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela	\N
10639	SANTG	7	1995-09-20 00:00:00	1995-10-18 00:00:00	1995-09-27 00:00:00	38.6400	SantÃ© Gourmet	Erling Skakkes gate 78	Stavern	\N	4110	Norway	\N
10640	WANDK	4	1995-09-21 00:00:00	1995-10-19 00:00:00	1995-09-28 00:00:00	23.5500	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany	\N
10641	HILAA	4	1995-09-22 00:00:00	1995-10-20 00:00:00	1995-09-26 00:00:00	179.6100	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10642	SIMOB	7	1995-09-22 00:00:00	1995-10-20 00:00:00	1995-10-06 00:00:00	41.8900	Simons bistro	VinbÃ¦ltet 34	KÃ¸benhavn	\N	1734	Denmark	\N
10643	ALFKI	6	1995-09-25 00:00:00	1995-10-23 00:00:00	1995-10-03 00:00:00	29.4600	Alfreds Futterkiste	Obere Str. 57	Berlin	\N	12209	Germany	\N
10644	WELLI	3	1995-09-25 00:00:00	1995-10-23 00:00:00	1995-10-02 00:00:00	0.1400	Wellington Importadora	Rua do Mercado, 12	Resende	SP	08737-363	Brazil	\N
10645	HANAR	4	1995-09-26 00:00:00	1995-10-24 00:00:00	1995-10-03 00:00:00	12.4100	Hanari Carnes	Rua do PaÃ§o, 67	Rio de Janeiro	RJ	05454-876	Brazil	\N
10646	HUNGO	9	1995-09-27 00:00:00	1995-11-08 00:00:00	1995-10-04 00:00:00	142.3300	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10647	QUEDE	4	1995-09-27 00:00:00	1995-10-11 00:00:00	1995-10-04 00:00:00	45.5400	Que DelÃ­cia	Rua da Panificadora, 12	Rio de Janeiro	RJ	02389-673	Brazil	\N
10648	RICAR	5	1995-09-28 00:00:00	1995-11-09 00:00:00	1995-10-10 00:00:00	14.2500	Ricardo Adocicados	Av. Copacabana, 267	Rio de Janeiro	RJ	02389-890	Brazil	\N
10649	MAISD	5	1995-09-28 00:00:00	1995-10-26 00:00:00	1995-09-29 00:00:00	6.2000	Maison Dewey	Rue Joseph-Bens 532	Bruxelles	\N	B-1180	Belgium	\N
10650	FAMIA	5	1995-09-29 00:00:00	1995-10-27 00:00:00	1995-10-04 00:00:00	176.8100	Familia Arquibaldo	Rua OrÃ³s, 92	SÃ£o Paulo	SP	05442-030	Brazil	\N
10651	WANDK	8	1995-10-02 00:00:00	1995-10-30 00:00:00	1995-10-12 00:00:00	20.6000	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany	\N
10652	GOURL	4	1995-10-02 00:00:00	1995-10-30 00:00:00	1995-10-09 00:00:00	7.1400	Gourmet Lanchonetes	Av. Brasil, 442	Campinas	SP	04876-786	Brazil	\N
10653	FRANK	1	1995-10-03 00:00:00	1995-10-31 00:00:00	1995-10-20 00:00:00	93.2500	Frankenversand	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	\N
10654	BERGS	5	1995-10-03 00:00:00	1995-10-31 00:00:00	1995-10-12 00:00:00	55.2600	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10655	REGGC	1	1995-10-04 00:00:00	1995-11-01 00:00:00	1995-10-12 00:00:00	4.4100	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy	\N
10656	GREAL	6	1995-10-05 00:00:00	1995-11-02 00:00:00	1995-10-11 00:00:00	57.1500	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA	\N
10657	SAVEA	2	1995-10-05 00:00:00	1995-11-02 00:00:00	1995-10-16 00:00:00	352.6900	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10658	QUICK	4	1995-10-06 00:00:00	1995-11-03 00:00:00	1995-10-09 00:00:00	364.1500	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10659	QUEEN	7	1995-10-06 00:00:00	1995-11-03 00:00:00	1995-10-11 00:00:00	105.8100	Queen Cozinha	Alameda dos CanÃ rios, 891	SÃ£o Paulo	SP	05487-020	Brazil	\N
10660	HUNGC	8	1995-10-09 00:00:00	1995-11-06 00:00:00	1995-11-15 00:00:00	111.2900	Hungry Coyote Import Store	City Center Plaza\n516 Main St.	Elgin	OR	97827	USA	\N
10661	HUNGO	7	1995-10-10 00:00:00	1995-11-07 00:00:00	1995-10-16 00:00:00	17.5500	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10662	LONEP	3	1995-10-10 00:00:00	1995-11-07 00:00:00	1995-10-19 00:00:00	1.2800	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA	\N
10663	BONAP	2	1995-10-11 00:00:00	1995-10-25 00:00:00	1995-11-03 00:00:00	113.1500	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10664	FURIB	1	1995-10-11 00:00:00	1995-11-08 00:00:00	1995-10-20 00:00:00	1.2700	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal	\N
10665	LONEP	1	1995-10-12 00:00:00	1995-11-09 00:00:00	1995-10-18 00:00:00	26.3100	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA	\N
10666	RICSU	7	1995-10-13 00:00:00	1995-11-10 00:00:00	1995-10-23 00:00:00	232.4200	Richter Supermarkt	Starenweg 5	GenÃ¨ve	\N	1204	Switzerland	\N
10667	ERNSH	7	1995-10-13 00:00:00	1995-11-10 00:00:00	1995-10-20 00:00:00	78.0900	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10668	WANDK	1	1995-10-16 00:00:00	1995-11-13 00:00:00	1995-10-24 00:00:00	47.2200	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany	\N
10669	SIMOB	2	1995-10-16 00:00:00	1995-11-13 00:00:00	1995-10-23 00:00:00	24.3900	Simons bistro	VinbÃ¦ltet 34	KÃ¸benhavn	\N	1734	Denmark	\N
10670	FRANK	4	1995-10-17 00:00:00	1995-11-14 00:00:00	1995-10-19 00:00:00	203.4800	Frankenversand	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	\N
10671	FRANR	1	1995-10-18 00:00:00	1995-11-15 00:00:00	1995-10-25 00:00:00	30.3400	France restauration	54, rue Royale	Nantes	\N	44000	France	\N
10672	BERGS	9	1995-10-18 00:00:00	1995-11-01 00:00:00	1995-10-27 00:00:00	95.7500	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10673	WILMK	2	1995-10-19 00:00:00	1995-11-16 00:00:00	1995-10-20 00:00:00	22.7600	Wilman Kala	Keskuskatu 45	Helsinki	\N	21240	Finland	\N
10674	ISLAT	4	1995-10-19 00:00:00	1995-11-16 00:00:00	1995-10-31 00:00:00	0.9000	Island Trading	Garden House\nCrowther Way	Cowes	Isle of Wight	PO31 7PJ	UK	\N
10675	FRANK	5	1995-10-20 00:00:00	1995-11-17 00:00:00	1995-10-24 00:00:00	31.8500	Frankenversand	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	\N
10676	TORTU	2	1995-10-23 00:00:00	1995-11-20 00:00:00	1995-10-30 00:00:00	2.0100	Tortuga Restaurante	Avda. Azteca 123	MÃ©xico D.F.	\N	05033	Mexico	\N
10677	ANTON	1	1995-10-23 00:00:00	1995-11-20 00:00:00	1995-10-27 00:00:00	4.0300	Antonio Moreno TaquerÃ­a	Mataderos  2312	MÃ©xico D.F.	\N	05023	Mexico	\N
10678	SAVEA	7	1995-10-24 00:00:00	1995-11-21 00:00:00	1995-11-16 00:00:00	388.9800	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10679	BLONP	8	1995-10-24 00:00:00	1995-11-21 00:00:00	1995-10-31 00:00:00	27.9400	Blondel pÃ¨re et fils	24, place KlÃ©ber	Strasbourg	\N	67000	France	\N
10680	OLDWO	1	1995-10-25 00:00:00	1995-11-22 00:00:00	1995-10-27 00:00:00	26.6100	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA	\N
10681	GREAL	3	1995-10-26 00:00:00	1995-11-23 00:00:00	1995-10-31 00:00:00	76.1300	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA	\N
10682	ANTON	3	1995-10-26 00:00:00	1995-11-23 00:00:00	1995-11-01 00:00:00	36.1300	Antonio Moreno TaquerÃ­a	Mataderos  2312	MÃ©xico D.F.	\N	05023	Mexico	\N
10683	DUMON	2	1995-10-27 00:00:00	1995-11-24 00:00:00	1995-11-01 00:00:00	4.4000	Du monde entier	67, rue des Cinquante Otages	Nantes	\N	44000	France	\N
10684	OTTIK	3	1995-10-27 00:00:00	1995-11-24 00:00:00	1995-10-31 00:00:00	145.6300	Ottilies KÃ¤seladen	Mehrheimerstr. 369	KÃ¶ln	\N	50739	Germany	\N
10685	GOURL	4	1995-10-30 00:00:00	1995-11-13 00:00:00	1995-11-03 00:00:00	33.7500	Gourmet Lanchonetes	Av. Brasil, 442	Campinas	SP	04876-786	Brazil	\N
10686	PICCO	2	1995-10-31 00:00:00	1995-11-28 00:00:00	1995-11-08 00:00:00	96.5000	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria	\N
10687	HUNGO	9	1995-10-31 00:00:00	1995-11-28 00:00:00	1995-11-30 00:00:00	296.4300	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10688	VAFFE	4	1995-11-01 00:00:00	1995-11-15 00:00:00	1995-11-07 00:00:00	299.0900	Vaffeljernet	SmagslÃ¸get 45	Ã…rhus	\N	8200	Denmark	\N
10689	BERGS	1	1995-11-01 00:00:00	1995-11-29 00:00:00	1995-11-07 00:00:00	13.4200	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10690	HANAR	1	1995-11-02 00:00:00	1995-11-30 00:00:00	1995-11-03 00:00:00	15.8000	Hanari Carnes	Rua do PaÃ§o, 67	Rio de Janeiro	RJ	05454-876	Brazil	\N
10691	QUICK	2	1995-11-03 00:00:00	1995-12-15 00:00:00	1995-11-22 00:00:00	810.0500	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10692	ALFKI	4	1995-11-03 00:00:00	1995-12-01 00:00:00	1995-11-13 00:00:00	61.0200	Alfred's Futterkiste	Obere Str. 57	Berlin	\N	12209	Germany	\N
10693	WHITC	3	1995-11-06 00:00:00	1995-11-20 00:00:00	1995-11-10 00:00:00	139.3400	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA	\N
10694	QUICK	8	1995-11-06 00:00:00	1995-12-04 00:00:00	1995-11-09 00:00:00	398.3600	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10695	WILMK	7	1995-11-07 00:00:00	1995-12-19 00:00:00	1995-11-14 00:00:00	16.7200	Wilman Kala	Keskuskatu 45	Helsinki	\N	21240	Finland	\N
10696	WHITC	8	1995-11-08 00:00:00	1995-12-20 00:00:00	1995-11-14 00:00:00	102.5500	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA	\N
10697	LINOD	3	1995-11-08 00:00:00	1995-12-06 00:00:00	1995-11-14 00:00:00	45.5200	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela	\N
10698	ERNSH	4	1995-11-09 00:00:00	1995-12-07 00:00:00	1995-11-17 00:00:00	272.4700	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10699	MORGK	3	1995-11-09 00:00:00	1995-12-07 00:00:00	1995-11-13 00:00:00	0.5800	Morgenstern Gesundkost	Heerstr. 22	Leipzig	\N	04179	Germany	\N
10700	SAVEA	3	1995-11-10 00:00:00	1995-12-08 00:00:00	1995-11-16 00:00:00	65.1000	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10701	HUNGO	6	1995-11-13 00:00:00	1995-11-27 00:00:00	1995-11-15 00:00:00	220.3100	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10702	ALFKI	4	1995-11-13 00:00:00	1995-12-25 00:00:00	1995-11-21 00:00:00	23.9400	Alfred's Futterkiste	Obere Str. 57	Berlin	\N	12209	Germany	\N
10703	FOLKO	6	1995-11-14 00:00:00	1995-12-12 00:00:00	1995-11-20 00:00:00	152.3000	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10704	QUEEN	6	1995-11-14 00:00:00	1995-12-12 00:00:00	1995-12-08 00:00:00	4.7800	Queen Cozinha	Alameda dos CanÃ rios, 891	SÃ£o Paulo	SP	05487-020	Brazil	\N
10705	HILAA	9	1995-11-15 00:00:00	1995-12-13 00:00:00	1995-12-19 00:00:00	3.5200	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10706	OLDWO	8	1995-11-16 00:00:00	1995-12-14 00:00:00	1995-11-21 00:00:00	135.6300	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA	\N
10707	AROUT	4	1995-11-16 00:00:00	1995-11-30 00:00:00	1995-11-23 00:00:00	21.7400	Around the Horn	Brook Farm\nStratford St. Mary	Colchester	Essex	CO7 6JX	UK	\N
10708	THEBI	6	1995-11-17 00:00:00	1995-12-29 00:00:00	1995-12-06 00:00:00	2.9600	The Big Cheese	89 Jefferson Way\nSuite 2	Portland	OR	97201	USA	\N
10709	GOURL	1	1995-11-17 00:00:00	1995-12-15 00:00:00	1995-12-21 00:00:00	210.8000	Gourmet Lanchonetes	Av. Brasil, 442	Campinas	SP	04876-786	Brazil	\N
10710	FRANS	1	1995-11-20 00:00:00	1995-12-18 00:00:00	1995-11-23 00:00:00	4.9800	Franchi S.p.A.	Via Monte Bianco 34	Torino	\N	10100	Italy	\N
10711	SAVEA	5	1995-11-21 00:00:00	1996-01-02 00:00:00	1995-11-29 00:00:00	52.4100	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10712	HUNGO	3	1995-11-21 00:00:00	1995-12-19 00:00:00	1995-12-01 00:00:00	89.9300	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10713	SAVEA	1	1995-11-22 00:00:00	1995-12-20 00:00:00	1995-11-24 00:00:00	167.0500	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10714	SAVEA	5	1995-11-22 00:00:00	1995-12-20 00:00:00	1995-11-27 00:00:00	24.4900	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10715	BONAP	3	1995-11-23 00:00:00	1995-12-07 00:00:00	1995-11-29 00:00:00	63.2000	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10716	RANCH	4	1995-11-24 00:00:00	1995-12-22 00:00:00	1995-11-27 00:00:00	22.5700	Rancho grande	Av. del Libertador 900	Buenos Aires	\N	1010	Argentina	\N
10717	FRANK	1	1995-11-24 00:00:00	1995-12-22 00:00:00	1995-11-29 00:00:00	59.2500	Frankenversand	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	\N
10718	KOENE	1	1995-11-27 00:00:00	1995-12-25 00:00:00	1995-11-29 00:00:00	170.8800	KÃ¶niglich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany	\N
10719	LETSS	8	1995-11-27 00:00:00	1995-12-25 00:00:00	1995-12-06 00:00:00	51.4400	Let's Stop N Shop	87 Polk St.\nSuite 5	San Francisco	CA	94117	USA	\N
10720	QUEDE	8	1995-11-28 00:00:00	1995-12-12 00:00:00	1995-12-06 00:00:00	9.5300	Que DelÃ­cia	Rua da Panificadora, 12	Rio de Janeiro	RJ	02389-673	Brazil	\N
10721	QUICK	5	1995-11-29 00:00:00	1995-12-27 00:00:00	1995-12-01 00:00:00	48.9200	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10722	SAVEA	8	1995-11-29 00:00:00	1996-01-10 00:00:00	1995-12-05 00:00:00	74.5800	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10723	WHITC	3	1995-11-30 00:00:00	1995-12-28 00:00:00	1995-12-26 00:00:00	21.7200	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA	\N
10724	MEREP	8	1995-11-30 00:00:00	1996-01-11 00:00:00	1995-12-06 00:00:00	57.7500	MÃ¨re Paillarde	43 rue St. Laurent	MontrÃ©al	QuÃ©bec	H1J 1C3	Canada	\N
10725	FAMIA	4	1995-12-01 00:00:00	1995-12-29 00:00:00	1995-12-06 00:00:00	10.8300	Familia Arquibaldo	Rua OrÃ³s, 92	SÃ£o Paulo	SP	05442-030	Brazil	\N
10726	EASTC	4	1995-12-04 00:00:00	1995-12-18 00:00:00	1996-01-05 00:00:00	16.5600	Eastern Connection	35 King George	London	\N	WX3 6FW	UK	\N
10727	REGGC	2	1995-12-04 00:00:00	1996-01-01 00:00:00	1996-01-05 00:00:00	89.9000	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy	\N
10728	QUEEN	4	1995-12-05 00:00:00	1996-01-02 00:00:00	1995-12-12 00:00:00	58.3300	Queen Cozinha	Alameda dos CanÃ rios, 891	SÃ£o Paulo	SP	05487-020	Brazil	\N
10729	LINOD	8	1995-12-05 00:00:00	1996-01-16 00:00:00	1995-12-15 00:00:00	141.0600	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela	\N
10730	BONAP	5	1995-12-06 00:00:00	1996-01-03 00:00:00	1995-12-15 00:00:00	20.1200	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10731	CHOPS	7	1995-12-07 00:00:00	1996-01-04 00:00:00	1995-12-15 00:00:00	96.6500	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland	\N
10732	BONAP	3	1995-12-07 00:00:00	1996-01-04 00:00:00	1995-12-08 00:00:00	16.9700	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10733	BERGS	1	1995-12-08 00:00:00	1996-01-05 00:00:00	1995-12-11 00:00:00	110.1100	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10734	GOURL	2	1995-12-08 00:00:00	1996-01-05 00:00:00	1995-12-13 00:00:00	1.6300	Gourmet Lanchonetes	Av. Brasil, 442	Campinas	SP	04876-786	Brazil	\N
10735	LETSS	6	1995-12-11 00:00:00	1996-01-08 00:00:00	1995-12-22 00:00:00	45.9700	Let's Stop N Shop	87 Polk St.\nSuite 5	San Francisco	CA	94117	USA	\N
10736	HUNGO	9	1995-12-12 00:00:00	1996-01-09 00:00:00	1995-12-22 00:00:00	44.1000	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10737	VINET	2	1995-12-12 00:00:00	1996-01-09 00:00:00	1995-12-19 00:00:00	7.7900	Vins et alcools Chevalier	59 rue de l'Abbaye	Reims	\N	51100	France	\N
10738	SPECD	2	1995-12-13 00:00:00	1996-01-10 00:00:00	1995-12-19 00:00:00	2.9100	SpÃ©cialitÃ©s du monde	25, rue Lauriston	Paris	\N	75016	France	\N
10739	VINET	3	1995-12-13 00:00:00	1996-01-10 00:00:00	1995-12-18 00:00:00	11.0800	Vins et alcools Chevalier	59 rue de l'Abbaye	Reims	\N	51100	France	\N
10740	WHITC	4	1995-12-14 00:00:00	1996-01-11 00:00:00	1995-12-26 00:00:00	81.8800	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA	\N
10741	AROUT	4	1995-12-15 00:00:00	1995-12-29 00:00:00	1995-12-19 00:00:00	10.9600	Around the Horn	Brook Farm\nStratford St. Mary	Colchester	Essex	CO7 6JX	UK	\N
10742	BOTTM	3	1995-12-15 00:00:00	1996-01-12 00:00:00	1995-12-19 00:00:00	243.7300	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	\N
10743	AROUT	1	1995-12-18 00:00:00	1996-01-15 00:00:00	1995-12-22 00:00:00	23.7200	Around the Horn	Brook Farm\nStratford St. Mary	Colchester	Essex	CO7 6JX	UK	\N
10744	VAFFE	6	1995-12-18 00:00:00	1996-01-15 00:00:00	1995-12-25 00:00:00	69.1900	Vaffeljernet	SmagslÃ¸get 45	Ã…rhus	\N	8200	Denmark	\N
10745	QUICK	9	1995-12-19 00:00:00	1996-01-16 00:00:00	1995-12-28 00:00:00	3.5200	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10746	CHOPS	1	1995-12-20 00:00:00	1996-01-17 00:00:00	1995-12-22 00:00:00	31.4300	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland	\N
10747	PICCO	6	1995-12-20 00:00:00	1996-01-17 00:00:00	1995-12-27 00:00:00	117.3300	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria	\N
10748	SAVEA	3	1995-12-21 00:00:00	1996-01-18 00:00:00	1995-12-29 00:00:00	232.5500	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10749	ISLAT	4	1995-12-21 00:00:00	1996-01-18 00:00:00	1996-01-19 00:00:00	61.5300	Island Trading	Garden House\nCrowther Way	Cowes	Isle of Wight	PO31 7PJ	UK	\N
10750	WARTH	9	1995-12-22 00:00:00	1996-01-19 00:00:00	1995-12-25 00:00:00	79.3000	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland	\N
10751	RICSU	3	1995-12-25 00:00:00	1996-01-22 00:00:00	1996-01-03 00:00:00	130.7900	Richter Supermarkt	Starenweg 5	GenÃ¨ve	\N	1204	Switzerland	\N
10752	NORTS	2	1995-12-25 00:00:00	1996-01-22 00:00:00	1995-12-29 00:00:00	1.3900	North/South	South House\n300 Queensbridge	London	\N	SW7 1RZ	UK	\N
10753	FRANS	3	1995-12-26 00:00:00	1996-01-23 00:00:00	1995-12-28 00:00:00	7.7000	Franchi S.p.A.	Via Monte Bianco 34	Torino	\N	10100	Italy	\N
10754	MAGAA	6	1995-12-26 00:00:00	1996-01-23 00:00:00	1995-12-28 00:00:00	2.3800	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy	\N
10755	BONAP	4	1995-12-27 00:00:00	1996-01-24 00:00:00	1995-12-29 00:00:00	16.7100	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10756	SPLIR	8	1995-12-28 00:00:00	1996-01-25 00:00:00	1996-01-02 00:00:00	73.2100	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA	\N
10757	SAVEA	6	1995-12-28 00:00:00	1996-01-25 00:00:00	1996-01-15 00:00:00	8.1900	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10758	RICSU	3	1995-12-29 00:00:00	1996-01-26 00:00:00	1996-01-04 00:00:00	138.1700	Richter Supermarkt	Starenweg 5	GenÃ¨ve	\N	1204	Switzerland	\N
10759	ANATR	3	1995-12-29 00:00:00	1996-01-26 00:00:00	1996-01-12 00:00:00	11.9900	Ana Trujillo Emparedados y helados	Avda. de la ConstituciÃ³n 2222	MÃ©xico D.F.	\N	05021	Mexico	\N
10760	MAISD	4	1996-01-01 00:00:00	1996-01-29 00:00:00	1996-01-10 00:00:00	155.6400	Maison Dewey	Rue Joseph-Bens 532	Bruxelles	\N	B-1180	Belgium	\N
10761	RATTC	5	1996-01-02 00:00:00	1996-01-30 00:00:00	1996-01-08 00:00:00	18.6600	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10762	FOLKO	3	1996-01-02 00:00:00	1996-01-30 00:00:00	1996-01-09 00:00:00	328.7400	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10763	FOLIG	3	1996-01-03 00:00:00	1996-01-31 00:00:00	1996-01-08 00:00:00	37.3500	Folies gourmandes	184, chaussÃ©e de Tournai	Lille	\N	59000	France	\N
10764	ERNSH	6	1996-01-03 00:00:00	1996-01-31 00:00:00	1996-01-08 00:00:00	145.4500	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10765	QUICK	3	1996-01-04 00:00:00	1996-02-01 00:00:00	1996-01-09 00:00:00	42.7400	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10766	OTTIK	4	1996-01-05 00:00:00	1996-02-02 00:00:00	1996-01-09 00:00:00	157.5500	Ottilies KÃ¤seladen	Mehrheimerstr. 369	KÃ¶ln	\N	50739	Germany	\N
10767	SUPRD	4	1996-01-05 00:00:00	1996-02-02 00:00:00	1996-01-15 00:00:00	1.5900	SuprÃªmes dÃ©lices	Boulevard Tirou, 255	Charleroi	\N	B-6000	Belgium	\N
10768	AROUT	3	1996-01-08 00:00:00	1996-02-05 00:00:00	1996-01-15 00:00:00	146.3200	Around the Horn	Brook Farm\nStratford St. Mary	Colchester	Essex	CO7 6JX	UK	\N
10769	VAFFE	3	1996-01-08 00:00:00	1996-02-05 00:00:00	1996-01-12 00:00:00	65.0600	Vaffeljernet	SmagslÃ¸get 45	Ã…rhus	\N	8200	Denmark	\N
10770	HANAR	8	1996-01-09 00:00:00	1996-02-06 00:00:00	1996-01-17 00:00:00	5.3200	Hanari Carnes	Rua do PaÃ§o, 67	Rio de Janeiro	RJ	05454-876	Brazil	\N
10771	ERNSH	9	1996-01-10 00:00:00	1996-02-07 00:00:00	1996-02-02 00:00:00	11.1900	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10772	LEHMS	3	1996-01-10 00:00:00	1996-02-07 00:00:00	1996-01-19 00:00:00	91.2800	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	\N
10773	ERNSH	1	1996-01-11 00:00:00	1996-02-08 00:00:00	1996-01-16 00:00:00	96.4300	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10774	FOLKO	4	1996-01-11 00:00:00	1996-01-25 00:00:00	1996-01-12 00:00:00	48.2000	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10775	THECR	7	1996-01-12 00:00:00	1996-02-09 00:00:00	1996-01-26 00:00:00	20.2500	The Cracker Box	55 Grizzly Peak Rd.	Butte	MT	59801	USA	\N
10776	ERNSH	1	1996-01-15 00:00:00	1996-02-12 00:00:00	1996-01-18 00:00:00	351.5300	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10777	GOURL	7	1996-01-15 00:00:00	1996-01-29 00:00:00	1996-02-21 00:00:00	3.0100	Gourmet Lanchonetes	Av. Brasil, 442	Campinas	SP	04876-786	Brazil	\N
10778	BERGS	3	1996-01-16 00:00:00	1996-02-13 00:00:00	1996-01-24 00:00:00	6.7900	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10779	MORGK	3	1996-01-16 00:00:00	1996-02-13 00:00:00	1996-02-14 00:00:00	58.1300	Morgenstern Gesundkost	Heerstr. 22	Leipzig	\N	04179	Germany	\N
10780	LILAS	2	1996-01-16 00:00:00	1996-01-30 00:00:00	1996-01-25 00:00:00	42.1300	LILA-Supermercado	Carrera 52 con Ave. BolÃ­var #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela	\N
10781	WARTH	2	1996-01-17 00:00:00	1996-02-14 00:00:00	1996-01-19 00:00:00	73.1600	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland	\N
10782	CACTU	9	1996-01-17 00:00:00	1996-02-14 00:00:00	1996-01-22 00:00:00	1.1000	Cactus Comidas para llevar	Cerrito 333	Buenos Aires	\N	1010	Argentina	\N
10783	HANAR	4	1996-01-18 00:00:00	1996-02-15 00:00:00	1996-01-19 00:00:00	124.9800	Hanari Carnes	Rua do PaÃ§o, 67	Rio de Janeiro	RJ	05454-876	Brazil	\N
10784	MAGAA	4	1996-01-18 00:00:00	1996-02-15 00:00:00	1996-01-22 00:00:00	70.0900	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy	\N
10785	GROSR	1	1996-01-18 00:00:00	1996-02-15 00:00:00	1996-01-24 00:00:00	1.5100	GROSELLA-Restaurante	5Âª Ave. Los Palos Grandes	Caracas	DF	1081	Venezuela	\N
10786	QUEEN	8	1996-01-19 00:00:00	1996-02-16 00:00:00	1996-01-23 00:00:00	110.8700	Queen Cozinha	Alameda dos CanÃ rios, 891	SÃ£o Paulo	SP	05487-020	Brazil	\N
10787	LAMAI	2	1996-01-19 00:00:00	1996-02-02 00:00:00	1996-01-26 00:00:00	249.9300	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France	\N
10788	QUICK	1	1996-01-22 00:00:00	1996-02-19 00:00:00	1996-02-19 00:00:00	42.7000	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10789	FOLIG	1	1996-01-22 00:00:00	1996-02-19 00:00:00	1996-01-31 00:00:00	100.6000	Folies gourmandes	184, chaussÃ©e de Tournai	Lille	\N	59000	France	\N
10790	GOURL	6	1996-01-22 00:00:00	1996-02-19 00:00:00	1996-01-26 00:00:00	28.2300	Gourmet Lanchonetes	Av. Brasil, 442	Campinas	SP	04876-786	Brazil	\N
10791	FRANK	6	1996-01-23 00:00:00	1996-02-20 00:00:00	1996-02-01 00:00:00	16.8500	Frankenversand	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	\N
10792	WOLZA	1	1996-01-23 00:00:00	1996-02-20 00:00:00	1996-01-31 00:00:00	23.7900	Wolski Zajazd	ul. Filtrowa 68	Warszawa	\N	01-012	Poland	\N
10793	AROUT	3	1996-01-24 00:00:00	1996-02-21 00:00:00	1996-02-08 00:00:00	4.5200	Around the Horn	Brook Farm\nStratford St. Mary	Colchester	Essex	CO7 6JX	UK	\N
10794	QUEDE	6	1996-01-24 00:00:00	1996-02-21 00:00:00	1996-02-02 00:00:00	21.4900	Que DelÃ­cia	Rua da Panificadora, 12	Rio de Janeiro	RJ	02389-673	Brazil	\N
10795	ERNSH	8	1996-01-24 00:00:00	1996-02-21 00:00:00	1996-02-20 00:00:00	126.6600	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10796	HILAA	3	1996-01-25 00:00:00	1996-02-22 00:00:00	1996-02-14 00:00:00	26.5200	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10797	DRACD	7	1996-01-25 00:00:00	1996-02-22 00:00:00	1996-02-05 00:00:00	33.3500	Drachenblut Delikatessen	Walserweg 21	Aachen	\N	52066	Germany	\N
10798	ISLAT	2	1996-01-26 00:00:00	1996-02-23 00:00:00	1996-02-05 00:00:00	2.3300	Island Trading	Garden House\nCrowther Way	Cowes	Isle of Wight	PO31 7PJ	UK	\N
10799	KOENE	9	1996-01-26 00:00:00	1996-03-08 00:00:00	1996-02-05 00:00:00	30.7600	KÃ¶niglich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany	\N
10800	SEVES	1	1996-01-26 00:00:00	1996-02-23 00:00:00	1996-02-05 00:00:00	137.4400	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK	\N
10801	BOLID	4	1996-01-29 00:00:00	1996-02-26 00:00:00	1996-01-31 00:00:00	97.0900	BÃ³lido Comidas preparadas	C/ Araquil, 67	Madrid	\N	28023	Spain	\N
10802	SIMOB	4	1996-01-29 00:00:00	1996-02-26 00:00:00	1996-02-02 00:00:00	257.2600	Simons bistro	VinbÃ¦ltet 34	KÃ¸benhavn	\N	1734	Denmark	\N
10803	WELLI	4	1996-01-30 00:00:00	1996-02-27 00:00:00	1996-02-06 00:00:00	55.2300	Wellington Importadora	Rua do Mercado, 12	Resende	SP	08737-363	Brazil	\N
10804	SEVES	6	1996-01-30 00:00:00	1996-02-27 00:00:00	1996-02-07 00:00:00	27.3300	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK	\N
10805	THEBI	2	1996-01-30 00:00:00	1996-02-27 00:00:00	1996-02-09 00:00:00	237.3400	The Big Cheese	89 Jefferson Way\nSuite 2	Portland	OR	97201	USA	\N
10806	VICTE	3	1996-01-31 00:00:00	1996-02-28 00:00:00	1996-02-05 00:00:00	22.1100	Victuailles en stock	2, rue du Commerce	Lyon	\N	69004	France	\N
10807	FRANS	4	1996-01-31 00:00:00	1996-02-28 00:00:00	1996-03-01 00:00:00	1.3600	Franchi S.p.A.	Via Monte Bianco 34	Torino	\N	10100	Italy	\N
10808	OLDWO	2	1996-02-01 00:00:00	1996-02-29 00:00:00	1996-02-09 00:00:00	45.5300	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA	\N
10809	WELLI	7	1996-02-01 00:00:00	1996-02-29 00:00:00	1996-02-07 00:00:00	4.8700	Wellington Importadora	Rua do Mercado, 12	Resende	SP	08737-363	Brazil	\N
10810	LAUGB	2	1996-02-01 00:00:00	1996-02-29 00:00:00	1996-02-07 00:00:00	4.3300	Laughing Bacchus Wine Cellars	2319 Elm St.	Vancouver	BC	V3F 2K1	Canada	\N
10811	LINOD	8	1996-02-02 00:00:00	1996-03-01 00:00:00	1996-02-08 00:00:00	31.2200	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela	\N
10812	REGGC	5	1996-02-02 00:00:00	1996-03-01 00:00:00	1996-02-12 00:00:00	59.7800	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy	\N
10813	RICAR	1	1996-02-05 00:00:00	1996-03-04 00:00:00	1996-02-09 00:00:00	47.3800	Ricardo Adocicados	Av. Copacabana, 267	Rio de Janeiro	RJ	02389-890	Brazil	\N
10814	VICTE	3	1996-02-05 00:00:00	1996-03-04 00:00:00	1996-02-14 00:00:00	130.9400	Victuailles en stock	2, rue du Commerce	Lyon	\N	69004	France	\N
10815	SAVEA	2	1996-02-05 00:00:00	1996-03-04 00:00:00	1996-02-14 00:00:00	14.6200	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10816	GREAL	4	1996-02-06 00:00:00	1996-03-05 00:00:00	1996-03-06 00:00:00	719.7800	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA	\N
10817	KOENE	3	1996-02-06 00:00:00	1996-02-20 00:00:00	1996-02-13 00:00:00	306.0700	KÃ¶niglich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany	\N
10818	MAGAA	7	1996-02-07 00:00:00	1996-03-06 00:00:00	1996-02-12 00:00:00	65.4800	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy	\N
10819	CACTU	2	1996-02-07 00:00:00	1996-03-06 00:00:00	1996-02-16 00:00:00	19.7600	Cactus Comidas para llevar	Cerrito 333	Buenos Aires	\N	1010	Argentina	\N
10820	RATTC	3	1996-02-07 00:00:00	1996-03-06 00:00:00	1996-02-13 00:00:00	37.5200	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10821	SPLIR	1	1996-02-08 00:00:00	1996-03-07 00:00:00	1996-02-15 00:00:00	36.6800	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA	\N
10822	TRAIH	6	1996-02-08 00:00:00	1996-03-07 00:00:00	1996-02-16 00:00:00	7.0000	Trail's Head Gourmet Provisioners	722 DaVinci Blvd.	Kirkland	WA	98034	USA	\N
10823	LILAS	5	1996-02-09 00:00:00	1996-03-08 00:00:00	1996-02-13 00:00:00	163.9700	LILA-Supermercado	Carrera 52 con Ave. BolÃ­var #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela	\N
10824	FOLKO	8	1996-02-09 00:00:00	1996-03-08 00:00:00	1996-03-01 00:00:00	1.2300	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10825	DRACD	1	1996-02-09 00:00:00	1996-03-08 00:00:00	1996-02-14 00:00:00	79.2500	Drachenblut Delikatessen	Walserweg 21	Aachen	\N	52066	Germany	\N
10826	BLONP	6	1996-02-12 00:00:00	1996-03-11 00:00:00	1996-03-08 00:00:00	7.0900	Blondel pÃ¨re et fils	24, place KlÃ©ber	Strasbourg	\N	67000	France	\N
10827	BONAP	1	1996-02-12 00:00:00	1996-02-26 00:00:00	1996-03-08 00:00:00	63.5400	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10828	RANCH	9	1996-02-13 00:00:00	1996-02-27 00:00:00	1996-03-06 00:00:00	90.8500	Rancho grande	Av. del Libertador 900	Buenos Aires	\N	1010	Argentina	\N
10829	ISLAT	9	1996-02-13 00:00:00	1996-03-12 00:00:00	1996-02-23 00:00:00	154.7200	Island Trading	Garden House\nCrowther Way	Cowes	Isle of Wight	PO31 7PJ	UK	\N
10830	TRADH	4	1996-02-13 00:00:00	1996-03-26 00:00:00	1996-02-21 00:00:00	81.8300	TradiÃ§Ã£o Hipermercados	Av. InÃªs de Castro, 414	SÃ£o Paulo	SP	05634-030	Brazil	\N
10831	SANTG	3	1996-02-14 00:00:00	1996-03-13 00:00:00	1996-02-23 00:00:00	72.1900	SantÃ© Gourmet	Erling Skakkes gate 78	Stavern	\N	4110	Norway	\N
10832	LAMAI	2	1996-02-14 00:00:00	1996-03-13 00:00:00	1996-02-19 00:00:00	43.2600	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France	\N
10833	OTTIK	6	1996-02-15 00:00:00	1996-03-14 00:00:00	1996-02-23 00:00:00	71.4900	Ottilies KÃ¤seladen	Mehrheimerstr. 369	KÃ¶ln	\N	50739	Germany	\N
10834	TRADH	1	1996-02-15 00:00:00	1996-03-14 00:00:00	1996-02-19 00:00:00	29.7800	TradiÃ§Ã£o Hipermercados	Av. InÃªs de Castro, 414	SÃ£o Paulo	SP	05634-030	Brazil	\N
10835	ALFKI	1	1996-02-15 00:00:00	1996-03-14 00:00:00	1996-02-21 00:00:00	69.5300	Alfred's Futterkiste	Obere Str. 57	Berlin	\N	12209	Germany	\N
10837	BERGS	9	1996-02-16 00:00:00	1996-03-15 00:00:00	1996-02-23 00:00:00	13.3200	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10838	LINOD	3	1996-02-19 00:00:00	1996-03-18 00:00:00	1996-02-23 00:00:00	59.2800	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela	\N
10839	TRADH	3	1996-02-19 00:00:00	1996-03-18 00:00:00	1996-02-22 00:00:00	35.4300	TradiÃ§Ã£o Hipermercados	Av. InÃªs de Castro, 414	SÃ£o Paulo	SP	05634-030	Brazil	\N
10840	LINOD	4	1996-02-19 00:00:00	1996-04-01 00:00:00	1996-03-18 00:00:00	2.7100	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela	\N
10841	SUPRD	5	1996-02-20 00:00:00	1996-03-19 00:00:00	1996-02-29 00:00:00	424.3000	SuprÃªmes dÃ©lices	Boulevard Tirou, 255	Charleroi	\N	B-6000	Belgium	\N
10842	TORTU	1	1996-02-20 00:00:00	1996-03-19 00:00:00	1996-02-29 00:00:00	54.4200	Tortuga Restaurante	Avda. Azteca 123	MÃ©xico D.F.	\N	05033	Mexico	\N
10843	VICTE	4	1996-02-21 00:00:00	1996-03-20 00:00:00	1996-02-26 00:00:00	9.2600	Victuailles en stock	2, rue du Commerce	Lyon	\N	69004	France	\N
10844	PICCO	8	1996-02-21 00:00:00	1996-03-20 00:00:00	1996-02-26 00:00:00	25.2200	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria	\N
10845	QUICK	8	1996-02-21 00:00:00	1996-03-06 00:00:00	1996-03-01 00:00:00	212.9800	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10846	SUPRD	2	1996-02-22 00:00:00	1996-04-04 00:00:00	1996-02-23 00:00:00	56.4600	SuprÃªmes dÃ©lices	Boulevard Tirou, 255	Charleroi	\N	B-6000	Belgium	\N
10847	SAVEA	4	1996-02-22 00:00:00	1996-03-07 00:00:00	1996-03-12 00:00:00	487.5700	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10848	CONSH	7	1996-02-23 00:00:00	1996-03-22 00:00:00	1996-02-29 00:00:00	38.2400	Consolidated Holdings	Berkeley Gardens\n12  Brewery 	London	\N	WX1 6LT	UK	\N
10849	KOENE	9	1996-02-23 00:00:00	1996-03-22 00:00:00	1996-03-01 00:00:00	0.5600	KÃ¶niglich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany	\N
10850	VICTE	1	1996-02-23 00:00:00	1996-04-05 00:00:00	1996-03-01 00:00:00	49.1900	Victuailles en stock	2, rue du Commerce	Lyon	\N	69004	France	\N
10851	RICAR	5	1996-02-26 00:00:00	1996-03-25 00:00:00	1996-03-04 00:00:00	160.5500	Ricardo Adocicados	Av. Copacabana, 267	Rio de Janeiro	RJ	02389-890	Brazil	\N
10852	RATTC	8	1996-02-26 00:00:00	1996-03-11 00:00:00	1996-03-01 00:00:00	174.0500	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10853	BLAUS	9	1996-02-27 00:00:00	1996-03-26 00:00:00	1996-03-05 00:00:00	53.8300	Blauer See Delikatessen	Forsterstr. 57	Mannheim	\N	68306	Germany	\N
10854	ERNSH	3	1996-02-27 00:00:00	1996-03-26 00:00:00	1996-03-07 00:00:00	100.2200	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10855	OLDWO	3	1996-02-27 00:00:00	1996-03-26 00:00:00	1996-03-06 00:00:00	170.9700	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA	\N
10856	ANTON	3	1996-02-28 00:00:00	1996-03-27 00:00:00	1996-03-12 00:00:00	58.4300	Antonio Moreno TaquerÃ­a	Mataderos  2312	MÃ©xico D.F.	\N	05023	Mexico	\N
10857	BERGS	8	1996-02-28 00:00:00	1996-03-27 00:00:00	1996-03-08 00:00:00	188.8500	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10858	LACOR	2	1996-02-29 00:00:00	1996-03-28 00:00:00	1996-03-05 00:00:00	52.5100	La corne d'abondance	67, avenue de l'Europe	Versailles	\N	78000	France	\N
10859	FRANK	1	1996-02-29 00:00:00	1996-03-28 00:00:00	1996-03-04 00:00:00	76.1000	Frankenversand	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	\N
10860	FRANR	3	1996-02-29 00:00:00	1996-03-28 00:00:00	1996-03-06 00:00:00	19.2600	France restauration	54, rue Royale	Nantes	\N	44000	France	\N
10861	WHITC	4	1996-03-01 00:00:00	1996-03-29 00:00:00	1996-03-19 00:00:00	14.9300	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA	\N
10862	LEHMS	8	1996-03-01 00:00:00	1996-04-12 00:00:00	1996-03-04 00:00:00	53.2300	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	\N
10863	HILAA	4	1996-03-04 00:00:00	1996-04-01 00:00:00	1996-03-19 00:00:00	30.2600	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10864	AROUT	4	1996-03-04 00:00:00	1996-04-01 00:00:00	1996-03-11 00:00:00	3.0400	Around the Horn	Brook Farm\nStratford St. Mary	Colchester	Essex	CO7 6JX	UK	\N
10865	QUICK	2	1996-03-04 00:00:00	1996-03-18 00:00:00	1996-03-14 00:00:00	348.1400	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10866	BERGS	5	1996-03-05 00:00:00	1996-04-02 00:00:00	1996-03-14 00:00:00	109.1100	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10867	LONEP	6	1996-03-05 00:00:00	1996-04-16 00:00:00	1996-03-13 00:00:00	1.9300	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA	\N
10868	QUEEN	7	1996-03-06 00:00:00	1996-04-03 00:00:00	1996-03-25 00:00:00	191.2700	Queen Cozinha	Alameda dos CanÃ rios, 891	SÃ£o Paulo	SP	05487-020	Brazil	\N
10869	SEVES	5	1996-03-06 00:00:00	1996-04-03 00:00:00	1996-03-11 00:00:00	143.2800	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK	\N
10870	WOLZA	5	1996-03-06 00:00:00	1996-04-03 00:00:00	1996-03-15 00:00:00	12.0400	Wolski Zajazd	ul. Filtrowa 68	Warszawa	\N	01-012	Poland	\N
10871	BONAP	9	1996-03-07 00:00:00	1996-04-04 00:00:00	1996-03-12 00:00:00	112.2700	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10872	GODOS	5	1996-03-07 00:00:00	1996-04-04 00:00:00	1996-03-11 00:00:00	175.3200	Godos Cocina TÃ­pica	C/ Romero, 33	Sevilla	\N	41101	Spain	\N
10873	WILMK	4	1996-03-08 00:00:00	1996-04-05 00:00:00	1996-03-11 00:00:00	0.8200	Wilman Kala	Keskuskatu 45	Helsinki	\N	21240	Finland	\N
10874	GODOS	5	1996-03-08 00:00:00	1996-04-05 00:00:00	1996-03-13 00:00:00	19.5800	Godos Cocina TÃ­pica	C/ Romero, 33	Sevilla	\N	41101	Spain	\N
10875	BERGS	4	1996-03-08 00:00:00	1996-04-05 00:00:00	1996-04-02 00:00:00	32.3700	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10876	BONAP	7	1996-03-11 00:00:00	1996-04-08 00:00:00	1996-03-14 00:00:00	60.4200	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10877	RICAR	1	1996-03-11 00:00:00	1996-04-08 00:00:00	1996-03-21 00:00:00	38.0600	Ricardo Adocicados	Av. Copacabana, 267	Rio de Janeiro	RJ	02389-890	Brazil	\N
10878	QUICK	4	1996-03-12 00:00:00	1996-04-09 00:00:00	1996-03-14 00:00:00	46.6900	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10879	WILMK	3	1996-03-12 00:00:00	1996-04-09 00:00:00	1996-03-14 00:00:00	8.5000	Wilman Kala	Keskuskatu 45	Helsinki	\N	21240	Finland	\N
10880	FOLKO	7	1996-03-12 00:00:00	1996-04-23 00:00:00	1996-03-20 00:00:00	88.0100	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10881	CACTU	4	1996-03-13 00:00:00	1996-04-10 00:00:00	1996-03-20 00:00:00	2.8400	Cactus Comidas para llevar	Cerrito 333	Buenos Aires	\N	1010	Argentina	\N
10882	SAVEA	4	1996-03-13 00:00:00	1996-04-10 00:00:00	1996-03-22 00:00:00	23.1000	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10883	LONEP	8	1996-03-14 00:00:00	1996-04-11 00:00:00	1996-03-22 00:00:00	0.5300	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA	\N
10884	LETSS	4	1996-03-14 00:00:00	1996-04-11 00:00:00	1996-03-15 00:00:00	90.9700	Let's Stop N Shop	87 Polk St.\nSuite 5	San Francisco	CA	94117	USA	\N
10885	SUPRD	6	1996-03-14 00:00:00	1996-04-11 00:00:00	1996-03-20 00:00:00	5.6400	SuprÃªmes dÃ©lices	Boulevard Tirou, 255	Charleroi	\N	B-6000	Belgium	\N
10886	HANAR	1	1996-03-15 00:00:00	1996-04-12 00:00:00	1996-04-01 00:00:00	4.9900	Hanari Carnes	Rua do PaÃ§o, 67	Rio de Janeiro	RJ	05454-876	Brazil	\N
10887	GALED	8	1996-03-15 00:00:00	1996-04-12 00:00:00	1996-03-18 00:00:00	1.2500	GalerÃ­a del gastronÃ³mo	Rambla de CataluÃ±a, 23	Barcelona	\N	8022	Spain	\N
10888	GODOS	1	1996-03-18 00:00:00	1996-04-15 00:00:00	1996-03-25 00:00:00	51.8700	Godos Cocina TÃ­pica	C/ Romero, 33	Sevilla	\N	41101	Spain	\N
10889	RATTC	9	1996-03-18 00:00:00	1996-04-15 00:00:00	1996-03-25 00:00:00	280.6100	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10890	DUMON	7	1996-03-18 00:00:00	1996-04-15 00:00:00	1996-03-20 00:00:00	32.7600	Du monde entier	67, rue des Cinquante Otages	Nantes	\N	44000	France	\N
10891	LEHMS	7	1996-03-19 00:00:00	1996-04-16 00:00:00	1996-03-21 00:00:00	20.3700	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	\N
10892	MAISD	4	1996-03-19 00:00:00	1996-04-16 00:00:00	1996-03-21 00:00:00	120.2700	Maison Dewey	Rue Joseph-Bens 532	Bruxelles	\N	B-1180	Belgium	\N
10893	KOENE	9	1996-03-20 00:00:00	1996-04-17 00:00:00	1996-03-22 00:00:00	77.7800	KÃ¶niglich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany	\N
10894	SAVEA	1	1996-03-20 00:00:00	1996-04-17 00:00:00	1996-03-22 00:00:00	116.1300	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10895	ERNSH	3	1996-03-20 00:00:00	1996-04-17 00:00:00	1996-03-25 00:00:00	162.7500	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10896	MAISD	7	1996-03-21 00:00:00	1996-04-18 00:00:00	1996-03-29 00:00:00	32.4500	Maison Dewey	Rue Joseph-Bens 532	Bruxelles	\N	B-1180	Belgium	\N
10897	HUNGO	3	1996-03-21 00:00:00	1996-04-18 00:00:00	1996-03-27 00:00:00	603.5400	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10898	OCEAN	4	1996-03-22 00:00:00	1996-04-19 00:00:00	1996-04-05 00:00:00	1.2700	OcÃ©ano AtlÃ¡ntico Ltda.	Ing. Gustavo Moncada 8585\nPiso 20-A	Buenos Aires	\N	1010	Argentina	\N
10899	LILAS	5	1996-03-22 00:00:00	1996-04-19 00:00:00	1996-03-28 00:00:00	1.2100	LILA-Supermercado	Carrera 52 con Ave. BolÃ­var #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela	\N
10900	WELLI	1	1996-03-22 00:00:00	1996-04-19 00:00:00	1996-04-03 00:00:00	1.6600	Wellington Importadora	Rua do Mercado, 12	Resende	SP	08737-363	Brazil	\N
10901	HILAA	4	1996-03-25 00:00:00	1996-04-22 00:00:00	1996-03-28 00:00:00	62.0900	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10902	FOLKO	1	1996-03-25 00:00:00	1996-04-22 00:00:00	1996-04-02 00:00:00	44.1500	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10903	HANAR	3	1996-03-26 00:00:00	1996-04-23 00:00:00	1996-04-03 00:00:00	36.7100	Hanari Carnes	Rua do PaÃ§o, 67	Rio de Janeiro	RJ	05454-876	Brazil	\N
10904	WHITC	3	1996-03-26 00:00:00	1996-04-23 00:00:00	1996-03-29 00:00:00	162.9500	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA	\N
10905	WELLI	9	1996-03-26 00:00:00	1996-04-23 00:00:00	1996-04-05 00:00:00	13.7200	Wellington Importadora	Rua do Mercado, 12	Resende	SP	08737-363	Brazil	\N
10906	WOLZA	4	1996-03-27 00:00:00	1996-04-10 00:00:00	1996-04-02 00:00:00	26.2900	Wolski Zajazd	ul. Filtrowa 68	Warszawa	\N	01-012	Poland	\N
10907	SPECD	6	1996-03-27 00:00:00	1996-04-24 00:00:00	1996-03-29 00:00:00	9.1900	SpÃ©cialitÃ©s du monde	25, rue Lauriston	Paris	\N	75016	France	\N
10908	REGGC	4	1996-03-28 00:00:00	1996-04-25 00:00:00	1996-04-05 00:00:00	32.9600	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy	\N
10909	SANTG	1	1996-03-28 00:00:00	1996-04-25 00:00:00	1996-04-09 00:00:00	53.0500	SantÃ© Gourmet	Erling Skakkes gate 78	Stavern	\N	4110	Norway	\N
10910	WILMK	1	1996-03-28 00:00:00	1996-04-25 00:00:00	1996-04-03 00:00:00	38.1100	Wilman Kala	Keskuskatu 45	Helsinki	\N	21240	Finland	\N
10911	GODOS	3	1996-03-28 00:00:00	1996-04-25 00:00:00	1996-04-04 00:00:00	38.1900	Godos Cocina TÃ­pica	C/ Romero, 33	Sevilla	\N	41101	Spain	\N
10912	HUNGO	2	1996-03-28 00:00:00	1996-04-25 00:00:00	1996-04-17 00:00:00	580.9100	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10913	QUEEN	4	1996-03-28 00:00:00	1996-04-25 00:00:00	1996-04-03 00:00:00	33.0500	Queen Cozinha	Alameda dos CanÃ rios, 891	SÃ£o Paulo	SP	05487-020	Brazil	\N
10914	QUEEN	6	1996-03-29 00:00:00	1996-04-26 00:00:00	1996-04-01 00:00:00	21.1900	Queen Cozinha	Alameda dos CanÃ rios, 891	SÃ£o Paulo	SP	05487-020	Brazil	\N
10915	TORTU	2	1996-03-29 00:00:00	1996-04-26 00:00:00	1996-04-01 00:00:00	3.5100	Tortuga Restaurante	Avda. Azteca 123	MÃ©xico D.F.	\N	05033	Mexico	\N
10916	RANCH	1	1996-03-29 00:00:00	1996-04-26 00:00:00	1996-04-08 00:00:00	63.7700	Rancho grande	Av. del Libertador 900	Buenos Aires	\N	1010	Argentina	\N
10917	ROMEY	4	1996-04-01 00:00:00	1996-04-29 00:00:00	1996-04-10 00:00:00	8.2900	Romero y tomillo	Gran VÃ­a, 1	Madrid	\N	28001	Spain	\N
10918	BOTTM	3	1996-04-01 00:00:00	1996-04-29 00:00:00	1996-04-10 00:00:00	48.8300	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	\N
10919	LINOD	2	1996-04-01 00:00:00	1996-04-29 00:00:00	1996-04-03 00:00:00	19.8000	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela	\N
10920	AROUT	4	1996-04-02 00:00:00	1996-04-30 00:00:00	1996-04-08 00:00:00	29.6100	Around the Horn	Brook Farm\nStratford St. Mary	Colchester	Essex	CO7 6JX	UK	\N
10921	VAFFE	1	1996-04-02 00:00:00	1996-05-14 00:00:00	1996-04-08 00:00:00	176.4800	Vaffeljernet	SmagslÃ¸get 45	Ã…rhus	\N	8200	Denmark	\N
10922	HANAR	5	1996-04-02 00:00:00	1996-04-30 00:00:00	1996-04-04 00:00:00	62.7400	Hanari Carnes	Rua do PaÃ§o, 67	Rio de Janeiro	RJ	05454-876	Brazil	\N
10923	LAMAI	7	1996-04-02 00:00:00	1996-05-14 00:00:00	1996-04-12 00:00:00	68.2600	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France	\N
10924	BERGS	3	1996-04-03 00:00:00	1996-05-01 00:00:00	1996-05-08 00:00:00	151.5200	Berglunds snabbkÃ¶p	BerguvsvÃ¤gen  8	LuleÃ¥	\N	S-958 22	Sweden	\N
10925	HANAR	3	1996-04-03 00:00:00	1996-05-01 00:00:00	1996-04-12 00:00:00	2.2700	Hanari Carnes	Rua do PaÃ§o, 67	Rio de Janeiro	RJ	05454-876	Brazil	\N
10926	ANATR	4	1996-04-03 00:00:00	1996-05-01 00:00:00	1996-04-10 00:00:00	39.9200	Ana Trujillo Emparedados y helados	Avda. de la ConstituciÃ³n 2222	MÃ©xico D.F.	\N	05021	Mexico	\N
10927	LACOR	4	1996-04-04 00:00:00	1996-05-02 00:00:00	1996-05-08 00:00:00	19.7900	La corne d'abondance	67, avenue de l'Europe	Versailles	\N	78000	France	\N
10928	GALED	1	1996-04-04 00:00:00	1996-05-02 00:00:00	1996-04-17 00:00:00	1.3600	GalerÃ­a del gastronÃ³mo	Rambla de CataluÃ±a, 23	Barcelona	\N	8022	Spain	\N
10929	FRANK	6	1996-04-04 00:00:00	1996-05-02 00:00:00	1996-04-11 00:00:00	33.9300	Frankenversand	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	\N
10930	SUPRD	4	1996-04-05 00:00:00	1996-05-17 00:00:00	1996-04-17 00:00:00	15.5500	SuprÃªmes dÃ©lices	Boulevard Tirou, 255	Charleroi	\N	B-6000	Belgium	\N
10931	RICSU	4	1996-04-05 00:00:00	1996-04-19 00:00:00	1996-04-18 00:00:00	13.6000	Richter Supermarkt	Starenweg 5	GenÃ¨ve	\N	1204	Switzerland	\N
10932	BONAP	8	1996-04-05 00:00:00	1996-05-03 00:00:00	1996-04-23 00:00:00	134.6400	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10933	ISLAT	6	1996-04-05 00:00:00	1996-05-03 00:00:00	1996-04-15 00:00:00	54.1500	Island Trading	Garden House\nCrowther Way	Cowes	Isle of Wight	PO31 7PJ	UK	\N
10934	LEHMS	3	1996-04-08 00:00:00	1996-05-06 00:00:00	1996-04-11 00:00:00	32.0100	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	\N
10935	WELLI	4	1996-04-08 00:00:00	1996-05-06 00:00:00	1996-04-17 00:00:00	47.5900	Wellington Importadora	Rua do Mercado, 12	Resende	SP	08737-363	Brazil	\N
10936	GREAL	3	1996-04-08 00:00:00	1996-05-06 00:00:00	1996-04-17 00:00:00	33.6800	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA	\N
10937	CACTU	7	1996-04-09 00:00:00	1996-04-23 00:00:00	1996-04-12 00:00:00	31.5100	Cactus Comidas para llevar	Cerrito 333	Buenos Aires	\N	1010	Argentina	\N
10938	QUICK	3	1996-04-09 00:00:00	1996-05-07 00:00:00	1996-04-15 00:00:00	31.8900	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10939	MAGAA	2	1996-04-09 00:00:00	1996-05-07 00:00:00	1996-04-12 00:00:00	76.3300	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy	\N
10940	BONAP	8	1996-04-10 00:00:00	1996-05-08 00:00:00	1996-04-22 00:00:00	19.7700	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
10941	SAVEA	7	1996-04-10 00:00:00	1996-05-08 00:00:00	1996-04-19 00:00:00	400.8100	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10942	REGGC	9	1996-04-10 00:00:00	1996-05-08 00:00:00	1996-04-17 00:00:00	17.9500	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy	\N
10943	BSBEV	4	1996-04-10 00:00:00	1996-05-08 00:00:00	1996-04-18 00:00:00	2.1700	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK	\N
10944	BOTTM	6	1996-04-11 00:00:00	1996-04-25 00:00:00	1996-04-12 00:00:00	52.9200	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	\N
10945	MORGK	4	1996-04-11 00:00:00	1996-05-09 00:00:00	1996-04-17 00:00:00	10.2200	Morgenstern Gesundkost	Heerstr. 22	Leipzig	\N	04179	Germany	\N
10946	VAFFE	1	1996-04-11 00:00:00	1996-05-09 00:00:00	1996-04-18 00:00:00	27.2000	Vaffeljernet	SmagslÃ¸get 45	Ã…rhus	\N	8200	Denmark	\N
10947	BSBEV	3	1996-04-12 00:00:00	1996-05-10 00:00:00	1996-04-15 00:00:00	3.2600	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK	\N
10948	GODOS	3	1996-04-12 00:00:00	1996-05-10 00:00:00	1996-04-18 00:00:00	23.3900	Godos Cocina TÃ­pica	C/ Romero, 33	Sevilla	\N	41101	Spain	\N
10949	BOTTM	2	1996-04-12 00:00:00	1996-05-10 00:00:00	1996-04-16 00:00:00	74.4400	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	\N
10950	MAGAA	1	1996-04-15 00:00:00	1996-05-13 00:00:00	1996-04-22 00:00:00	2.5000	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy	\N
10951	RICSU	9	1996-04-15 00:00:00	1996-05-27 00:00:00	1996-05-07 00:00:00	30.8500	Richter Supermarkt	Starenweg 5	GenÃ¨ve	\N	1204	Switzerland	\N
10952	ALFKI	1	1996-04-15 00:00:00	1996-05-27 00:00:00	1996-04-23 00:00:00	40.4200	Alfred's Futterkiste	Obere Str. 57	Berlin	\N	12209	Germany	\N
10953	AROUT	9	1996-04-15 00:00:00	1996-04-29 00:00:00	1996-04-24 00:00:00	23.7200	Around the Horn	Brook Farm\nStratford St. Mary	Colchester	Essex	CO7 6JX	UK	\N
10954	LINOD	5	1996-04-16 00:00:00	1996-05-28 00:00:00	1996-04-19 00:00:00	27.9100	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela	\N
10955	FOLKO	8	1996-04-16 00:00:00	1996-05-14 00:00:00	1996-04-19 00:00:00	3.2600	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10956	BLAUS	6	1996-04-16 00:00:00	1996-05-28 00:00:00	1996-04-19 00:00:00	44.6500	Blauer See Delikatessen	Forsterstr. 57	Mannheim	\N	68306	Germany	\N
10957	HILAA	8	1996-04-17 00:00:00	1996-05-15 00:00:00	1996-04-26 00:00:00	105.3600	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10958	OCEAN	7	1996-04-17 00:00:00	1996-05-15 00:00:00	1996-04-26 00:00:00	49.5600	OcÃ©ano AtlÃ¡ntico Ltda.	Ing. Gustavo Moncada 8585\nPiso 20-A	Buenos Aires	\N	1010	Argentina	\N
10959	GOURL	6	1996-04-17 00:00:00	1996-05-29 00:00:00	1996-04-22 00:00:00	4.9800	Gourmet Lanchonetes	Av. Brasil, 442	Campinas	SP	04876-786	Brazil	\N
10960	HILAA	3	1996-04-18 00:00:00	1996-05-02 00:00:00	1996-05-08 00:00:00	2.0800	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10961	QUEEN	8	1996-04-18 00:00:00	1996-05-16 00:00:00	1996-04-29 00:00:00	104.4700	Queen Cozinha	Alameda dos CanÃ rios, 891	SÃ£o Paulo	SP	05487-020	Brazil	\N
10962	QUICK	8	1996-04-18 00:00:00	1996-05-16 00:00:00	1996-04-22 00:00:00	275.7900	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10963	FURIB	9	1996-04-18 00:00:00	1996-05-16 00:00:00	1996-04-25 00:00:00	2.7000	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal	\N
10964	SPECD	3	1996-04-19 00:00:00	1996-05-17 00:00:00	1996-04-23 00:00:00	87.3800	SpÃ©cialitÃ©s du monde	25, rue Lauriston	Paris	\N	75016	France	\N
10965	OLDWO	6	1996-04-19 00:00:00	1996-05-17 00:00:00	1996-04-29 00:00:00	144.3800	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA	\N
10966	CHOPS	4	1996-04-19 00:00:00	1996-05-17 00:00:00	1996-05-08 00:00:00	27.1900	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland	\N
10967	TOMSP	2	1996-04-22 00:00:00	1996-05-20 00:00:00	1996-05-02 00:00:00	62.2200	Toms SpezialitÃ¤ten	Luisenstr. 48	MÃ¼nster	\N	44087	Germany	\N
10968	ERNSH	1	1996-04-22 00:00:00	1996-05-20 00:00:00	1996-05-01 00:00:00	74.6000	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10969	COMMI	1	1996-04-22 00:00:00	1996-05-20 00:00:00	1996-04-29 00:00:00	0.2100	ComÃ©rcio Mineiro	Av. dos LusÃ­adas, 23	SÃ£o Paulo	SP	05432-043	Brazil	\N
10970	BOLID	9	1996-04-23 00:00:00	1996-05-07 00:00:00	1996-05-24 00:00:00	16.1600	BÃ³lido Comidas preparadas	C/ Araquil, 67	Madrid	\N	28023	Spain	\N
10971	FRANR	2	1996-04-23 00:00:00	1996-05-21 00:00:00	1996-05-02 00:00:00	121.8200	France restauration	54, rue Royale	Nantes	\N	44000	France	\N
10972	LACOR	4	1996-04-23 00:00:00	1996-05-21 00:00:00	1996-04-25 00:00:00	0.0200	La corne d'abondance	67, avenue de l'Europe	Versailles	\N	78000	France	\N
10973	LACOR	6	1996-04-23 00:00:00	1996-05-21 00:00:00	1996-04-26 00:00:00	15.1700	La corne d'abondance	67, avenue de l'Europe	Versailles	\N	78000	France	\N
10974	SPLIR	3	1996-04-24 00:00:00	1996-05-08 00:00:00	1996-05-03 00:00:00	12.9600	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA	\N
10975	BOTTM	1	1996-04-24 00:00:00	1996-05-22 00:00:00	1996-04-26 00:00:00	32.2700	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	\N
10976	HILAA	1	1996-04-24 00:00:00	1996-06-05 00:00:00	1996-05-03 00:00:00	37.9700	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
10977	FOLKO	8	1996-04-25 00:00:00	1996-05-23 00:00:00	1996-05-10 00:00:00	208.5000	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10978	MAISD	9	1996-04-25 00:00:00	1996-05-23 00:00:00	1996-05-23 00:00:00	32.8200	Maison Dewey	Rue Joseph-Bens 532	Bruxelles	\N	B-1180	Belgium	\N
10979	ERNSH	8	1996-04-25 00:00:00	1996-05-23 00:00:00	1996-04-30 00:00:00	353.0700	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10980	FOLKO	4	1996-04-26 00:00:00	1996-06-07 00:00:00	1996-05-17 00:00:00	1.2600	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10981	HANAR	1	1996-04-26 00:00:00	1996-05-24 00:00:00	1996-05-02 00:00:00	193.3700	Hanari Carnes	Rua do PaÃ§o, 67	Rio de Janeiro	RJ	05454-876	Brazil	\N
10982	BOTTM	2	1996-04-26 00:00:00	1996-05-24 00:00:00	1996-05-08 00:00:00	14.0100	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	\N
10983	SAVEA	2	1996-04-26 00:00:00	1996-05-24 00:00:00	1996-05-06 00:00:00	657.5400	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10984	SAVEA	1	1996-04-29 00:00:00	1996-05-27 00:00:00	1996-05-03 00:00:00	211.2200	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
10985	HUNGO	2	1996-04-29 00:00:00	1996-05-27 00:00:00	1996-05-02 00:00:00	91.5100	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
10986	OCEAN	8	1996-04-29 00:00:00	1996-05-27 00:00:00	1996-05-21 00:00:00	217.8600	OcÃ©ano AtlÃ¡ntico Ltda.	Ing. Gustavo Moncada 8585\nPiso 20-A	Buenos Aires	\N	1010	Argentina	\N
10987	EASTC	8	1996-04-30 00:00:00	1996-05-28 00:00:00	1996-05-06 00:00:00	185.4800	Eastern Connection	35 King George	London	\N	WX3 6FW	UK	\N
10988	RATTC	3	1996-04-30 00:00:00	1996-05-28 00:00:00	1996-05-10 00:00:00	61.1400	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
10989	QUEDE	2	1996-04-30 00:00:00	1996-05-28 00:00:00	1996-05-02 00:00:00	34.7600	Que DelÃ­cia	Rua da Panificadora, 12	Rio de Janeiro	RJ	02389-673	Brazil	\N
10990	ERNSH	2	1996-05-01 00:00:00	1996-06-12 00:00:00	1996-05-07 00:00:00	117.6100	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
10991	QUICK	1	1996-05-01 00:00:00	1996-05-29 00:00:00	1996-05-07 00:00:00	38.5100	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10992	THEBI	1	1996-05-01 00:00:00	1996-05-29 00:00:00	1996-05-03 00:00:00	4.2700	The Big Cheese	89 Jefferson Way\nSuite 2	Portland	OR	97201	USA	\N
10993	FOLKO	7	1996-05-01 00:00:00	1996-05-29 00:00:00	1996-05-10 00:00:00	8.8100	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
10994	VAFFE	2	1996-05-02 00:00:00	1996-05-16 00:00:00	1996-05-09 00:00:00	65.5300	Vaffeljernet	SmagslÃ¸get 45	Ã…rhus	\N	8200	Denmark	\N
10995	PERIC	1	1996-05-02 00:00:00	1996-05-30 00:00:00	1996-05-06 00:00:00	46.0000	Pericles Comidas clÃ¡sicas	Calle Dr. Jorge Cash 321	MÃ©xico D.F.	\N	05033	Mexico	\N
10996	QUICK	4	1996-05-02 00:00:00	1996-05-30 00:00:00	1996-05-10 00:00:00	1.1200	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
10997	LILAS	8	1996-05-03 00:00:00	1996-06-14 00:00:00	1996-05-13 00:00:00	73.9100	LILA-Supermercado	Carrera 52 con Ave. BolÃ­var #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela	\N
10998	WOLZA	8	1996-05-03 00:00:00	1996-05-17 00:00:00	1996-05-17 00:00:00	20.3100	Wolski Zajazd	ul. Filtrowa 68	Warszawa	\N	01-012	Poland	\N
10999	OTTIK	6	1996-05-03 00:00:00	1996-05-31 00:00:00	1996-05-10 00:00:00	96.3500	Ottilies KÃ¤seladen	Mehrheimerstr. 369	KÃ¶ln	\N	50739	Germany	\N
11000	RATTC	2	1996-05-06 00:00:00	1996-06-03 00:00:00	1996-05-14 00:00:00	55.1200	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
11001	FOLKO	2	1996-05-06 00:00:00	1996-06-03 00:00:00	1996-05-14 00:00:00	197.3000	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
11002	SAVEA	4	1996-05-06 00:00:00	1996-06-03 00:00:00	1996-05-16 00:00:00	141.1600	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
11003	THECR	3	1996-05-06 00:00:00	1996-06-03 00:00:00	1996-05-08 00:00:00	14.9100	The Cracker Box	55 Grizzly Peak Rd.	Butte	MT	59801	USA	\N
11004	MAISD	3	1996-05-07 00:00:00	1996-06-04 00:00:00	1996-05-20 00:00:00	44.8400	Maison Dewey	Rue Joseph-Bens 532	Bruxelles	\N	B-1180	Belgium	\N
11005	WILMK	2	1996-05-07 00:00:00	1996-06-04 00:00:00	1996-05-10 00:00:00	0.7500	Wilman Kala	Keskuskatu 45	Helsinki	\N	21240	Finland	\N
11006	GREAL	3	1996-05-07 00:00:00	1996-06-04 00:00:00	1996-05-15 00:00:00	25.1900	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA	\N
11007	PRINI	8	1996-05-08 00:00:00	1996-06-05 00:00:00	1996-05-13 00:00:00	202.2400	Princesa Isabel Vinhos	Estrada da saÃºde n. 58	Lisboa	\N	1756	Portugal	\N
11008	ERNSH	7	1996-05-08 00:00:00	1996-06-05 00:00:00	\N	79.4600	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
11009	GODOS	2	1996-05-08 00:00:00	1996-06-05 00:00:00	1996-05-10 00:00:00	59.1100	Godos Cocina TÃ­pica	C/ Romero, 33	Sevilla	\N	41101	Spain	\N
11010	REGGC	2	1996-05-09 00:00:00	1996-06-06 00:00:00	1996-05-21 00:00:00	28.7100	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy	\N
11011	ALFKI	3	1996-05-09 00:00:00	1996-06-06 00:00:00	1996-05-13 00:00:00	1.2100	Alfred's Futterkiste	Obere Str. 57	Berlin	\N	12209	Germany	\N
11012	FRANK	1	1996-05-09 00:00:00	1996-05-23 00:00:00	1996-05-17 00:00:00	242.9500	Frankenversand	Berliner Platz 43	MÃ¼nchen	\N	80805	Germany	\N
11013	ROMEY	2	1996-05-09 00:00:00	1996-06-06 00:00:00	1996-05-10 00:00:00	32.9900	Romero y tomillo	Gran VÃ­a, 1	Madrid	\N	28001	Spain	\N
11014	LINOD	2	1996-05-10 00:00:00	1996-06-07 00:00:00	1996-05-15 00:00:00	23.6000	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela	\N
11015	SANTG	2	1996-05-10 00:00:00	1996-05-24 00:00:00	1996-05-20 00:00:00	4.6200	SantÃ© Gourmet	Erling Skakkes gate 78	Stavern	\N	4110	Norway	\N
11016	AROUT	9	1996-05-10 00:00:00	1996-06-07 00:00:00	1996-05-13 00:00:00	33.8000	Around the Horn	Brook Farm\nStratford St. Mary	Colchester	Essex	CO7 6JX	UK	\N
11017	ERNSH	9	1996-05-13 00:00:00	1996-06-10 00:00:00	1996-05-20 00:00:00	754.2600	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
11018	LONEP	4	1996-05-13 00:00:00	1996-06-10 00:00:00	1996-05-16 00:00:00	11.6500	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA	\N
11019	RANCH	6	1996-05-13 00:00:00	1996-06-10 00:00:00	\N	3.1700	Rancho grande	Av. del Libertador 900	Buenos Aires	\N	1010	Argentina	\N
11020	OTTIK	2	1996-05-14 00:00:00	1996-06-11 00:00:00	1996-05-16 00:00:00	43.3000	Ottilies KÃ¤seladen	Mehrheimerstr. 369	KÃ¶ln	\N	50739	Germany	\N
11021	QUICK	3	1996-05-14 00:00:00	1996-06-11 00:00:00	1996-05-21 00:00:00	297.1800	QUICK-Stop	TaucherstraÃŸe 10	Cunewalde	\N	01307	Germany	\N
11022	HANAR	9	1996-05-14 00:00:00	1996-06-11 00:00:00	1996-06-03 00:00:00	6.2700	Hanari Carnes	Rua do PaÃ§o, 67	Rio de Janeiro	RJ	05454-876	Brazil	\N
11023	BSBEV	1	1996-05-14 00:00:00	1996-05-28 00:00:00	1996-05-24 00:00:00	123.8300	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK	\N
11024	EASTC	4	1996-05-15 00:00:00	1996-06-12 00:00:00	1996-05-20 00:00:00	74.3600	Eastern Connection	35 King George	London	\N	WX3 6FW	UK	\N
11025	WARTH	6	1996-05-15 00:00:00	1996-06-12 00:00:00	1996-05-24 00:00:00	29.1700	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland	\N
11026	FRANS	4	1996-05-15 00:00:00	1996-06-12 00:00:00	1996-05-28 00:00:00	47.0900	Franchi S.p.A.	Via Monte Bianco 34	Torino	\N	10100	Italy	\N
11027	BOTTM	1	1996-05-16 00:00:00	1996-06-13 00:00:00	1996-05-20 00:00:00	52.5200	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	\N
11028	KOENE	2	1996-05-16 00:00:00	1996-06-13 00:00:00	1996-05-22 00:00:00	29.5900	KÃ¶niglich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany	\N
11029	CHOPS	4	1996-05-16 00:00:00	1996-06-13 00:00:00	1996-05-27 00:00:00	47.8400	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland	\N
11030	SAVEA	7	1996-05-17 00:00:00	1996-06-14 00:00:00	1996-05-27 00:00:00	830.7500	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
11031	SAVEA	6	1996-05-17 00:00:00	1996-06-14 00:00:00	1996-05-24 00:00:00	227.2200	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
11032	WHITC	2	1996-05-17 00:00:00	1996-06-14 00:00:00	1996-05-23 00:00:00	606.1900	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA	\N
11033	RICSU	7	1996-05-17 00:00:00	1996-06-14 00:00:00	1996-05-23 00:00:00	84.7400	Richter Supermarkt	Starenweg 5	GenÃ¨ve	\N	1204	Switzerland	\N
11034	OLDWO	8	1996-05-20 00:00:00	1996-07-01 00:00:00	1996-05-27 00:00:00	40.3200	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA	\N
11035	SUPRD	2	1996-05-20 00:00:00	1996-06-17 00:00:00	1996-05-24 00:00:00	0.1700	SuprÃªmes dÃ©lices	Boulevard Tirou, 255	Charleroi	\N	B-6000	Belgium	\N
11036	DRACD	8	1996-05-20 00:00:00	1996-06-17 00:00:00	1996-05-22 00:00:00	149.4700	Drachenblut Delikatessen	Walserweg 21	Aachen	\N	52066	Germany	\N
11037	GODOS	7	1996-05-21 00:00:00	1996-06-18 00:00:00	1996-05-27 00:00:00	3.2000	Godos Cocina TÃ­pica	C/ Romero, 33	Sevilla	\N	41101	Spain	\N
11038	SUPRD	1	1996-05-21 00:00:00	1996-06-18 00:00:00	1996-05-30 00:00:00	29.5900	SuprÃªmes dÃ©lices	Boulevard Tirou, 255	Charleroi	\N	B-6000	Belgium	\N
11039	LINOD	1	1996-05-21 00:00:00	1996-06-18 00:00:00	\N	65.0000	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela	\N
11040	GREAL	4	1996-05-22 00:00:00	1996-06-19 00:00:00	\N	18.8400	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA	\N
11041	CHOPS	3	1996-05-22 00:00:00	1996-06-19 00:00:00	1996-05-28 00:00:00	48.2200	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland	\N
11042	COMMI	2	1996-05-22 00:00:00	1996-06-05 00:00:00	1996-05-31 00:00:00	29.9900	ComÃ©rcio Mineiro	Av. dos LusÃ­adas, 23	SÃ£o Paulo	SP	05432-043	Brazil	\N
11043	SPECD	5	1996-05-22 00:00:00	1996-06-19 00:00:00	1996-05-29 00:00:00	8.8000	SpÃ©cialitÃ©s du monde	25, rue Lauriston	Paris	\N	75016	France	\N
11044	WOLZA	4	1996-05-23 00:00:00	1996-06-20 00:00:00	1996-05-31 00:00:00	8.7200	Wolski Zajazd	ul. Filtrowa 68	Warszawa	\N	01-012	Poland	\N
11045	BOTTM	6	1996-05-23 00:00:00	1996-06-20 00:00:00	\N	70.5800	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	\N
11046	WANDK	8	1996-05-23 00:00:00	1996-06-20 00:00:00	1996-05-24 00:00:00	71.6400	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany	\N
11047	EASTC	7	1996-05-24 00:00:00	1996-06-21 00:00:00	1996-05-31 00:00:00	46.6200	Eastern Connection	35 King George	London	\N	WX3 6FW	UK	\N
11048	BOTTM	7	1996-05-24 00:00:00	1996-06-21 00:00:00	1996-05-30 00:00:00	24.1200	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	\N
11049	GOURL	3	1996-05-24 00:00:00	1996-06-21 00:00:00	1996-06-03 00:00:00	8.3400	Gourmet Lanchonetes	Av. Brasil, 442	Campinas	SP	04876-786	Brazil	\N
11050	FOLKO	8	1996-05-27 00:00:00	1996-06-24 00:00:00	1996-06-04 00:00:00	59.4100	Folk och fÃ¤ HB	Ã…kergatan 24	BrÃ¤cke	\N	S-844 67	Sweden	\N
11051	LAMAI	7	1996-05-27 00:00:00	1996-06-24 00:00:00	\N	2.7900	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France	\N
11052	HANAR	3	1996-05-27 00:00:00	1996-06-24 00:00:00	1996-05-31 00:00:00	67.2600	Hanari Carnes	Rua do PaÃ§o, 67	Rio de Janeiro	RJ	05454-876	Brazil	\N
11053	PICCO	2	1996-05-27 00:00:00	1996-06-24 00:00:00	1996-05-29 00:00:00	53.0500	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria	\N
11054	CACTU	8	1996-05-28 00:00:00	1996-06-25 00:00:00	\N	0.3300	Cactus Comidas para llevar	Cerrito 333	Buenos Aires	\N	1010	Argentina	\N
11055	HILAA	7	1996-05-28 00:00:00	1996-06-25 00:00:00	1996-06-04 00:00:00	120.9200	HILARIÃ“N-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San CristÃ³bal	TÃ¡chira	5022	Venezuela	\N
11056	EASTC	8	1996-05-28 00:00:00	1996-06-11 00:00:00	1996-05-31 00:00:00	278.9600	Eastern Connection	35 King George	London	\N	WX3 6FW	UK	\N
11057	NORTS	3	1996-05-29 00:00:00	1996-06-26 00:00:00	1996-05-31 00:00:00	4.1300	North/South	South House\n300 Queensbridge	London	\N	SW7 1RZ	UK	\N
11058	BLAUS	9	1996-05-29 00:00:00	1996-06-26 00:00:00	\N	31.1400	Blauer See Delikatessen	Forsterstr. 57	Mannheim	\N	68306	Germany	\N
11059	RICAR	2	1996-05-29 00:00:00	1996-07-10 00:00:00	\N	85.8000	Ricardo Adocicados	Av. Copacabana, 267	Rio de Janeiro	RJ	02389-890	Brazil	\N
11060	FRANS	2	1996-05-30 00:00:00	1996-06-27 00:00:00	1996-06-03 00:00:00	10.9800	Franchi S.p.A.	Via Monte Bianco 34	Torino	\N	10100	Italy	\N
11061	GREAL	4	1996-05-30 00:00:00	1996-07-11 00:00:00	\N	14.0100	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA	\N
11062	REGGC	4	1996-05-30 00:00:00	1996-06-27 00:00:00	\N	29.9300	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy	\N
11063	HUNGO	3	1996-05-30 00:00:00	1996-06-27 00:00:00	1996-06-05 00:00:00	81.7300	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland	\N
11064	SAVEA	1	1996-05-31 00:00:00	1996-06-28 00:00:00	1996-06-03 00:00:00	30.0900	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA	\N
11065	LILAS	8	1996-05-31 00:00:00	1996-06-28 00:00:00	\N	12.9100	LILA-Supermercado	Carrera 52 con Ave. BolÃ­var #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela	\N
11066	WHITC	7	1996-05-31 00:00:00	1996-06-28 00:00:00	1996-06-03 00:00:00	44.7200	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA	\N
11067	DRACD	1	1996-06-03 00:00:00	1996-06-17 00:00:00	1996-06-05 00:00:00	7.9800	Drachenblut Delikatessen	Walserweg 21	Aachen	\N	52066	Germany	\N
11068	QUEEN	8	1996-06-03 00:00:00	1996-07-01 00:00:00	\N	81.7500	Queen Cozinha	Alameda dos CanÃ rios, 891	SÃ£o Paulo	SP	05487-020	Brazil	\N
11069	TORTU	1	1996-06-03 00:00:00	1996-07-01 00:00:00	1996-06-05 00:00:00	15.6700	Tortuga Restaurante	Avda. Azteca 123	MÃ©xico D.F.	\N	05033	Mexico	\N
11070	LEHMS	2	1996-06-04 00:00:00	1996-07-02 00:00:00	\N	136.0000	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M. 	\N	60528	Germany	\N
11071	LILAS	1	1996-06-04 00:00:00	1996-07-02 00:00:00	\N	0.9300	LILA-Supermercado	Carrera 52 con Ave. BolÃ­var #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela	\N
11072	ERNSH	4	1996-06-04 00:00:00	1996-07-02 00:00:00	\N	258.6400	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria	\N
11073	PERIC	2	1996-06-04 00:00:00	1996-07-02 00:00:00	\N	24.9500	Pericles Comidas clÃ¡sicas	Calle Dr. Jorge Cash 321	MÃ©xico D.F.	\N	05033	Mexico	\N
11074	SIMOB	7	1996-06-05 00:00:00	1996-07-03 00:00:00	\N	18.4400	Simons bistro	VinbÃ¦ltet 34	KÃ¸benhavn	\N	1734	Denmark	\N
11075	RICSU	8	1996-06-05 00:00:00	1996-07-03 00:00:00	\N	6.1900	Richter Supermarkt	Starenweg 5	GenÃ¨ve	\N	1204	Switzerland	\N
11076	BONAP	4	1996-06-05 00:00:00	1996-07-03 00:00:00	\N	38.2800	Bon app'	12, rue des Bouchers	Marseille	\N	13008	France	\N
11077	RATTC	1	1996-06-05 00:00:00	1996-07-03 00:00:00	\N	8.5300	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA	\N
\.


--
-- TOC entry 3400 (class 0 OID 16408)
-- Dependencies: 221
-- Data for Name: products; Type: TABLE DATA; Schema: northwind; Owner: -
--

COPY northwind.products (productid, productname, supplierid, categoryid, quantityperunit, unitprice, unitsinstock, unitsonorder, reorderlevel, discontinued) FROM stdin;
1	Chai	1	1	10 boxes x 20 bags	18.0000	39	0	10	N
2	Chang	1	1	24 - 12 oz bottles	19.0000	17	40	25	N
3	Aniseed Syrup	1	2	12 - 550 ml bottles	10.0000	13	70	25	N
4	Chef Anton's Cajun Seasoning	2	2	48 - 6 oz jars	22.0000	53	0	0	N
5	Chef Anton's Gumbo Mix	2	2	36 boxes	21.3500	0	0	0	Y
6	Grandma's Boysenberry Spread	3	2	12 - 8 oz jars	25.0000	120	0	25	N
7	Uncle Bob's Organic Dried Pears	3	7	12 - 1 lb pkgs.	30.0000	15	0	10	N
8	Northwoods Cranberry Sauce	3	2	12 - 12 oz jars	40.0000	6	0	0	N
9	Mishi Kobe Niku	4	6	18 - 500 g pkgs.	97.0000	29	0	0	Y
10	Ikura	4	8	12 - 200 ml jars	31.0000	31	0	0	N
11	Queso Cabrales	5	4	1 kg pkg.	21.0000	22	30	30	N
12	Queso Manchego La Pastora	5	4	10 - 500 g pkgs.	38.0000	86	0	0	N
13	Konbu	6	8	2 kg box	6.0000	24	0	5	N
14	Tofu	6	7	40 - 100 g pkgs.	23.2500	35	0	0	N
15	Genen Shouyu	6	2	24 - 250 ml bottles	15.5000	39	0	5	N
16	Pavlova	7	3	32 - 500 g boxes	17.4500	29	0	10	N
17	Alice Mutton	7	6	20 - 1 kg tins	39.0000	0	0	0	Y
18	Carnarvon Tigers	7	8	16 kg pkg.	62.5000	42	0	0	N
19	Teatime Chocolate Biscuits	8	3	10 boxes x 12 pieces	9.2000	25	0	5	N
20	Sir Rodney's Marmalade	8	3	30 gift boxes	81.0000	40	0	0	N
21	Sir Rodney's Scones	8	3	24 pkgs. x 4 pieces	10.0000	3	40	5	N
22	Gustaf's KnÃ¤ckebrÃ¶d	9	5	24 - 500 g pkgs.	21.0000	104	0	25	N
23	TunnbrÃ¶d	9	5	12 - 250 g pkgs.	9.0000	61	0	25	N
24	GuaranÃ¡ FantÃ¡stica	10	1	12 - 355 ml cans	4.5000	20	0	0	Y
25	NuNuCa NuÃŸ-Nougat-Creme	11	3	20 - 450 g glasses	14.0000	76	0	30	N
26	GumbÃ¤r GummibÃ¤rchen	11	3	100 - 250 g bags	31.2300	15	0	0	N
27	Schoggi Schokolade	11	3	100 - 100 g pieces	43.9000	49	0	30	N
28	RÃ¶ssle Sauerkraut	12	7	25 - 825 g cans	45.6000	26	0	0	Y
29	ThÃ¼ringer Rostbratwurst	12	6	50 bags x 30 sausgs.	123.7900	0	0	0	Y
30	Nord-Ost Matjeshering	13	8	10 - 200 g glasses	25.8900	10	0	15	N
31	Gorgonzola Telino	14	4	12 - 100 g pkgs	12.5000	0	70	20	N
32	Mascarpone Fabioli	14	4	24 - 200 g pkgs.	32.0000	9	40	25	N
33	Geitost	15	4	500 g	2.5000	112	0	20	N
34	Sasquatch Ale	16	1	24 - 12 oz bottles	14.0000	111	0	15	N
35	Steeleye Stout	16	1	24 - 12 oz bottles	18.0000	20	0	15	N
36	Inlagd Sill	17	8	24 - 250 g  jars	19.0000	112	0	20	N
37	Gravad lax	17	8	12 - 500 g pkgs.	26.0000	11	50	25	N
38	CÃ´te de Blaye	18	1	12 - 75 cl bottles	263.5000	17	0	15	N
39	Chartreuse verte	18	1	750 cc per bottle	18.0000	69	0	5	N
40	Boston Crab Meat	19	8	24 - 4 oz tins	18.4000	123	0	30	N
41	Jack's New England Clam Chowder	19	8	12 - 12 oz cans	9.6500	85	0	10	N
42	Singaporean Hokkien Fried Mee	20	5	32 - 1 kg pkgs.	14.0000	26	0	0	Y
43	Ipoh Coffee	20	1	16 - 500 g tins	46.0000	17	10	25	N
44	Gula Malacca	20	2	20 - 2 kg bags	19.4500	27	0	15	N
45	RÃ¸gede sild	21	8	1k pkg.	9.5000	5	70	15	N
46	Spegesild	21	8	4 - 450 g glasses	12.0000	95	0	0	N
47	Zaanse koeken	22	3	10 - 4 oz boxes	9.5000	36	0	0	N
48	Chocolade	22	3	10 pkgs.	12.7500	15	70	25	N
49	Maxilaku	23	3	24 - 50 g pkgs.	20.0000	10	60	15	N
50	Valkoinen suklaa	23	3	12 - 100 g bars	16.2500	65	0	30	N
51	Manjimup Dried Apples	24	7	50 - 300 g pkgs.	53.0000	20	0	10	N
52	Filo Mix	24	5	16 - 2 kg boxes	7.0000	38	0	25	N
53	Perth Pasties	24	6	48 pieces	32.8000	0	0	0	Y
54	TourtiÃ¨re	25	6	16 pies	7.4500	21	0	10	N
55	PÃ¢tÃ© chinois	25	6	24 boxes x 2 pies	24.0000	115	0	20	N
56	Gnocchi di nonna Alice	26	5	24 - 250 g pkgs.	38.0000	21	10	30	N
57	Ravioli Angelo	26	5	24 - 250 g pkgs.	19.5000	36	0	20	N
58	Escargots de Bourgogne	27	8	24 pieces	13.2500	62	0	20	N
59	Raclette Courdavault	28	4	5 kg pkg.	55.0000	79	0	0	N
60	Camembert Pierrot	28	4	15 - 300 g rounds	34.0000	19	0	0	N
61	Sirop d'Ã©rable	29	2	24 - 500 ml bottles	28.5000	113	0	25	N
62	Tarte au sucre	29	3	48 pies	49.3000	17	0	0	N
63	Vegie-spread	7	2	15 - 625 g jars	43.9000	24	0	5	N
64	Wimmers gute SemmelknÃ¶del	12	5	20 bags x 4 pieces	33.2500	22	80	30	N
65	Louisiana Fiery Hot Pepper Sauce	2	2	32 - 8 oz bottles	21.0500	76	0	0	N
66	Louisiana Hot Spiced Okra	2	2	24 - 8 oz jars	17.0000	4	100	20	N
67	Laughing Lumberjack Lager	16	1	24 - 12 oz bottles	14.0000	52	0	10	N
68	Scottish Longbreads	8	3	10 boxes x 8 pieces	12.5000	6	10	15	N
69	Gudbrandsdalsost	15	4	10 kg pkg.	36.0000	26	0	15	N
70	Outback Lager	7	1	24 - 355 ml bottles	15.0000	15	10	30	N
71	FlÃ¸temysost	15	4	10 - 500 g pkgs.	21.5000	26	0	0	N
72	Mozzarella di Giovanni	14	4	24 - 200 g pkgs.	34.8000	14	0	0	N
73	RÃ¶d Kaviar	17	8	24 - 150 g jars	15.0000	101	0	5	N
74	Longlife Tofu	4	7	5 kg pkg.	10.0000	4	20	5	N
75	RhÃ¶nbrÃ¤u Klosterbier	12	1	24 - 0.5 l bottles	7.7500	125	0	25	N
76	LakkalikÃ¶Ã¶ri	23	1	500 ml	18.0000	57	0	20	N
77	Original Frankfurter grÃ¼ne SoÃŸe	12	2	12 boxes	13.0000	32	0	15	N
14051	cadeira	4	8	1	150.0000	80	30	1	N
\.


--
-- TOC entry 3401 (class 0 OID 16411)
-- Dependencies: 222
-- Data for Name: shippers; Type: TABLE DATA; Schema: northwind; Owner: -
--

COPY northwind.shippers (shipperid, companyname, phone) FROM stdin;
1	Speedy Express	(503) 555-9831
2	United Package	(503) 555-3199
3	Federal Shipping	(503) 555-9931
\.


--
-- TOC entry 3402 (class 0 OID 16414)
-- Dependencies: 223
-- Data for Name: suppliers; Type: TABLE DATA; Schema: northwind; Owner: -
--

COPY northwind.suppliers (supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax, homepage) FROM stdin;
1	Exotic Liquids	Charlotte Cooper	Purchasing Manager	49 Gilbert St.	London	\N	EC1 4SD	UK	(171) 555-2222	\N	\N
2	New Orleans Cajun Delights	Shelley Burke	Order Administrator	P.O. Box 78934	New Orleans	LA	70117	USA	(100) 555-4822	\N	#CAJUN.HTM#
3	Grandma Kelly's Homestead	Regina Murphy	Sales Representative	707 Oxford Rd.	Ann Arbor	MI	48104	USA	(313) 555-5735	(313) 555-3349	\N
4	Tokyo Traders	Yoshi Nagase	Marketing Manager	9-8 Sekimai\nMusashino-shi	Tokyo	\N	100	Japan	(03) 3555-5011	\N	\N
5	Cooperativa de Quesos 'Las Cabras'	Antonio del Valle Saavedra 	Export Administrator	Calle del Rosal 4	Oviedo	Asturias	33007	Spain	(98) 598 76 54	\N	\N
6	Mayumi's	Mayumi Ohno	Marketing Representative	92 Setsuko\nChuo-ku	Osaka	\N	545	Japan	(06) 431-7877	\N	Mayumi's (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/mayumi.htm#
7	Pavlova, Ltd.	Ian Devling	Marketing Manager	74 Rose St.\nMoonie Ponds	Melbourne	Victoria	3058	Australia	(03) 444-2343	(03) 444-6588	\N
8	Specialty Biscuits, Ltd.	Peter Wilson	Sales Representative	29 King's Way	Manchester	\N	M14 GSD	UK	(161) 555-4448	\N	\N
10	Refrescos Americanas LTDA	Carlos Diaz	Marketing Manager	Av. das Americanas 12.890	SÃ£o Paulo	\N	5442	Brazil	(11) 555 4640	\N	\N
11	Heli SÃ¼ÃŸwaren GmbH & Co. KG	Petra Winkler	Sales Manager	TiergartenstraÃŸe 5	Berlin	\N	10785	Germany	(010) 9984510	\N	\N
12	Plutzer LebensmittelgroÃŸmÃ¤rkte AG	Martin Bein	International Marketing Mgr.	Bogenallee 51	Frankfurt	\N	60439	Germany	(069) 992755	\N	Plutzer (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/plutzer.htm#
13	Nord-Ost-Fisch Handelsgesellschaft mbH	Sven Petersen	Coordinator Foreign Markets	Frahmredder 112a	Cuxhaven	\N	27478	Germany	(04721) 8713	(04721) 8714	\N
14	Formaggi Fortini s.r.l.	Elio Rossi	Sales Representative	Viale Dante, 75	Ravenna	\N	48100	Italy	(0544) 60323	(0544) 60603	#FORMAGGI.HTM#
15	Norske Meierier	Beate Vileid	Marketing Manager	Hatlevegen 5	Sandvika	\N	1320	Norway	(0)2-953010	\N	\N
16	Bigfoot Breweries	Cheryl Saylor	Regional Account Rep.	3400 - 8th Avenue\nSuite 210	Bend	OR	97101	USA	(503) 555-9931	\N	\N
17	Svensk SjÃ¶fÃ¶da AB	Michael BjÃ¶rn	Sales Representative	BrovallavÃ¤gen 231	Stockholm	\N	S-123 45	Sweden	08-123 45 67	\N	\N
18	Aux joyeux ecclÃ©siastiques	GuylÃ¨ne Nodier	Sales Manager	203, Rue des Francs-Bourgeois	Paris	\N	75004	France	(1) 03.83.00.68	(1) 03.83.00.62	\N
19	New England Seafood Cannery	Robb Merchant	Wholesale Account Agent	Order Processing Dept.\n2100 Paul Revere Blvd.	Boston	MA	02134	USA	(617) 555-3267	(617) 555-3389	\N
20	Leka Trading	Chandra Leka	Owner	471 Serangoon Loop, Suite #402	Singapore	\N	0512	Singapore	555-8787	\N	\N
21	Lyngbysild	Niels Petersen	Sales Manager	Lyngbysild\nFiskebakken 10	Lyngby	\N	2800	Denmark	43844108	43844115	\N
22	Zaanse Snoepfabriek	Dirk Luchte	Accounting Manager	Verkoop\nRijnweg 22	Zaandam	\N	9999 ZZ	Netherlands	(12345) 1212	(12345) 1210	\N
23	Karkki Oy	Anne Heikkonen	Product Manager	Valtakatu 12	Lappeenranta	\N	53120	Finland	(953) 10956	\N	\N
24	G'day, Mate	Wendy Mackenzie	Sales Representative	170 Prince Edward Parade\nHunter's Hill	Sydney	NSW	2042	Australia	(02) 555-5914	(02) 555-4873	G'day Mate (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/gdaymate.htm#
25	Ma Maison	Jean-Guy Lauzon	Marketing Manager	2960 Rue St. Laurent	MontrÃ©al	QuÃ©bec	H1J 1C3	Canada	(514) 555-9022	\N	\N
26	Pasta Buttini s.r.l.	Giovanni Giudici	Order Administrator	Via dei Gelsomini, 153	Salerno	\N	84100	Italy	(089) 6547665	(089) 6547667	\N
27	Escargots Nouveaux	Marie Delamare	Sales Manager	22, rue H. Voiron	Montceau	\N	71300	France	85.57.00.07	\N	\N
28	Gai pÃ¢turage	Eliane Noz	Sales Representative	Bat. B\n3, rue des Alpes	Annecy	\N	74000	France	38.76.98.06	38.76.98.58	\N
29	ForÃªts d'Ã©rables	Chantal Goulet	Accounting Manager	148 rue Chasseur	Ste-Hyacinthe	QuÃ©bec	J2S 7S8	Canada	(514) 555-2955	(514) 555-2921	\N
9	PB KnÃ¤ckebrÃ¶d AB	Lars Peterson	Sales Agent	Kaloadagatan 13	GÃ¶teborg	\N	S-345 67	Sweden	031-987 65 43	031-987 65 91	\N
\.


--
-- TOC entry 3233 (class 2606 OID 16418)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: northwind; Owner: -
--

ALTER TABLE ONLY northwind.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (categoryid);


--
-- TOC entry 3235 (class 2606 OID 16420)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: northwind; Owner: -
--

ALTER TABLE ONLY northwind.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customerid);


--
-- TOC entry 3237 (class 2606 OID 16422)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: northwind; Owner: -
--

ALTER TABLE ONLY northwind.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employeeid);


--
-- TOC entry 3239 (class 2606 OID 16424)
-- Name: order_details order_details_pkey; Type: CONSTRAINT; Schema: northwind; Owner: -
--

ALTER TABLE ONLY northwind.order_details
    ADD CONSTRAINT order_details_pkey PRIMARY KEY (orderid, productid);


--
-- TOC entry 3241 (class 2606 OID 16426)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: northwind; Owner: -
--

ALTER TABLE ONLY northwind.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (orderid);


--
-- TOC entry 3243 (class 2606 OID 16428)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: northwind; Owner: -
--

ALTER TABLE ONLY northwind.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (productid);


--
-- TOC entry 3245 (class 2606 OID 16430)
-- Name: shippers shippers_pkey; Type: CONSTRAINT; Schema: northwind; Owner: -
--

ALTER TABLE ONLY northwind.shippers
    ADD CONSTRAINT shippers_pkey PRIMARY KEY (shipperid);


--
-- TOC entry 3247 (class 2606 OID 16432)
-- Name: suppliers supplier_pk; Type: CONSTRAINT; Schema: northwind; Owner: -
--

ALTER TABLE ONLY northwind.suppliers
    ADD CONSTRAINT supplier_pk PRIMARY KEY (supplierid);


--
-- TOC entry 3249 (class 2606 OID 16556)
-- Name: products fk_category; Type: FK CONSTRAINT; Schema: northwind; Owner: -
--

ALTER TABLE ONLY northwind.products
    ADD CONSTRAINT fk_category FOREIGN KEY (categoryid) REFERENCES northwind.categories(categoryid);


--
-- TOC entry 3248 (class 2606 OID 16566)
-- Name: orders fk_customer; Type: FK CONSTRAINT; Schema: northwind; Owner: -
--

ALTER TABLE ONLY northwind.orders
    ADD CONSTRAINT fk_customer FOREIGN KEY (customerid) REFERENCES northwind.customers(customerid);


--
-- TOC entry 3250 (class 2606 OID 16561)
-- Name: products fk_supplier; Type: FK CONSTRAINT; Schema: northwind; Owner: -
--

ALTER TABLE ONLY northwind.products
    ADD CONSTRAINT fk_supplier FOREIGN KEY (supplierid) REFERENCES northwind.suppliers(supplierid);


-- Completed on 2025-04-06 15:21:36 -03

--
-- PostgreSQL database dump complete
--

