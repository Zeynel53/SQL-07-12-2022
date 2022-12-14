--IN CONDITION
CREATE TABLE musteriler (
urun_id int,
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm'); 
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple'); 
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange'); 
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

SELECT * FROM MUSTERILER
--1.yol
--MUSTERILER TABLOSUNDAN URUN ISMI ORANGE,APPLE VEYA APRICOT OLAN VERILERI LIST.
SELECT * FROM MUSTERILER WHERE urun_isim='Orange' or urun_isim='Apple' or urun_isim='Apricot';
--2.yol
--IN CONDITION
SELECT * FROM MUSTERILER WHERE urun_isim IN ('Orange','Apple','Apricot');

--NOT IN-->YAZDIGIMIZ VERILERIN DISINDAKILERI GETIRIR
SELECT * FROM MUSTERILER WHERE urun_isim NOT IN ('Orange','Apple','Apricot');

SELECT * FROM MUSTERILER WHERE urun_isim='Orange' and urun_id=10

--BETWEEN CONDITION
--Musteriler tablosundan id si 20 ile 40 arasinda olan tum  verileri listeleyiniz
SELECT * FROM musteriler WHERE urun_id>=20 and urun_id<=40 

SELECT * FROM musteriler WHERE urun_id BETWEEN 20 AND 40

--NOT BETWEEN
SELECT * FROM musteriler WHERE urun_id NOT BETWEEN 20 AND 40

--SUBQUERIES
CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);
INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');


CREATE TABLE markalar
(
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

SELECT * FROM calisanlar2
select * FROM markalar
-- ??alisan sayisi 15.000???den cok olan markalarin isimlerini ve bu markada 
--calisanlarin isimlerini ve maa??larini listeleyin.
SELECT isim,maas,isyeri FROM calisanlar2
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000);

-- marka_id???si 101???den b??y??k olan marka ??ali??anlarinin 
--isim, maa?? ve ??ehirlerini listeleyiniz
SELECT isim,maas,sehir from calisanlar2
where isyeri in(select marka_isim from markalar where marka_id>101);
--??DEV- Ankara???da calisani olan markalarin marka id'lerini ve 
--calisan sayilarini listeleyiniz.

--METOT KULLANIMI
/*Aggregate Metotlari (SUM,COUNT, MIN, MAX, AVG) Subquery i??inde
kullanilabilir.
Ancak, Sorgu tek bir de??er d??nd??r??yor olmalidir.
SYNTAX: sum() ??eklinde olmal?? sum ile () aras??nda bo??
*/
SELECT MAX(maas) AS maximum_maas FROM calisanlar2
--gecici isim verme islemi maximum maas ismi verildi yukarida
SELECT MAX(maas) FROM calisanlar2
SELECT MIN(maas) FROM calisanlar2
--gecici isim verme islemi minimum maas ismi verildi yukarida
SELECT MIN(maas) AS MINIMUM_MAAS FROM calisanlar2

--calisanlar tablosunda maaslarin toplamini nbulunuz
SELECT SUM(maas) FROM calisanlar2

--calisanlar tablosunda maaslarin ortalamasini bulunuz
SELECT AVG(maas) FROM calisanlar2
--calisanlar tablosunda maaslarin ortalamasini bulunuz(ondalik iki rakam ile gosteriyor ort)
select round(avg(maas),2) from calisanlar2

--calisanlar tablosunda maaslarin sayisini bulunuz
select count(maas) from calisanlar2
--count(*) satir sayisini veriyor
select count(*) from calisanlar2

--AGGREGATE METHODLARDA SUBQUUERY
--Her markanin id???sini, ismini ve toplam ka?? ??ehirde bulundu??unu listeleyen bir SORGU yaziniz
SELECT marka_id,marka_isim,
(SELECT count(sehir) as sehir_sayisi from calisanlar2 where marka_isim=isyeri)
from markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maa??ini listeleyiniz
CREATE view summaas
as
SELECT marka_isim,calisan_sayisi,
(SELECT sum(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as toplam_maas
FROM markalar
select * from summaas
-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maa??ini listeleyen bir Sorgu yaziniz.
select marka_isim,calisan_sayisi,
(select  max(maas) from calisanlar2 where isyeri=marka_isim) as enyuksekmaas,
(select  min(maas) from calisanlar2 where isyeri=marka_isim) as endusukmaas
from markalar

--VIEW KULLANIMI
CREATE VIEW MAXMINMAAS
AS
select marka_isim,calisan_sayisi,
(select  max(maas) from calisanlar2 where isyeri=marka_isim) as enyuksekmaas,
(select  min(maas) from calisanlar2 where isyeri=marka_isim) as endusukmaas
from markalar;

SELECT * FROM MAXMINMAAS;

--EXIST CONDTION
CREATE TABLE mart
(   
urun_id int,    
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(   
urun_id int ,
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

SELECT * FROM MART
SELECT * FROM NISAN

--MART VE N??SAN aylar??nda ayn?? URUN_ID ile sat??lan ??r??nlerin
--URUN_ID???lerini listeleyen ve ayn?? zamanda bu ??r??nleri MART ay??nda alan
-- MUSTERI_ISIM 'lerini listeleyen bir sorgu yaz??n??z.
SELECT urun_id,musteri_isim from mart
where exists (select urun_id from nisan where mart.urun_id=nisan.urun_id)

--Her iki ayda birden sat??lan ??r??nlerin URUN_ISIM'lerini ve bu ??r??nleri
--N??SAN ay??nda sat??n alan MUSTERI_ISIM'lerini listeleyen bir sorgu yaz??n??z.
SELECT urun_isim, musteri_isim FROM nisan 
where exists (SELECT urun_isim from mart where mart.urun_isim=nisan.urun_isim)

--UPDATE--DML
CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', '??in Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

CREATE TABLE urunler -- child
(
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler(vergi_no)
on delete cascade
);    
INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ay??e Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan ??z');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Y??lmaz');

SELECT * FROM TEDARIKCILER
SELECT * FROM URUNLER
/*
UPDATE tablo_adi
SET sutun_ismi = 'istenen veri' WHERE sutun_ismi='istenen veri'
*/
-- vergi_no???su 102 olan tedarikcinin firma ismini 'Vestel' olarak g??ncelleyeniz.
UPDATE TEDARIKCILER
SET firma_ismi  = 'Vestel' where vergi_no=102;

-- vergi_no???su 101 olan tedarik??inin firma ismini 'casper' 
--ve irtibat_ismi???ni 'Ali Veli' olarak g??ncelleyiniz.
UPDATE TEDARIKCILER
SET firma_ismi  = 'Casper',irtibat_ismi='Ali Veli' where vergi_no=101;

--urunler tablosundaki 'Phone' de??erlerini 'Telefon' olarak g??ncelleyiniz.
update urunler
set urun_isim='Telefon' where urun_isim='Phone'

-- urunler tablosundaki urun_id de??eri 1004'ten b??y??k olanlar??n urun_id???sini 1 artt??r??n
update urunler 
set urun_id=urun_id+1 where urun_id>1004

-- urunler tablosundaki t??m ??r??nlerin urun_id de??erini ted_vergino sutun de??erleri ile toplayarak g??ncelleyiniz.
update urunler
set urun_id= urun_id+ted_vergino

DELETE FROM URUNLER


-- urunler tablosundan Ali Bak???in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi
-- 'Adam Eve' olan firman??n ismi (firma_ismi) ile degistiriniz.
update urunler
SET urun_isim = (SELECT firma_ismi FROM tedarikciler WHERE irtibat_ismi = 'Adam Eve')                       
WHERE musteri_isim='Ali Bak';

-- Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple???in irtibat_isim'i ile degistirin.
update urunler
set musteri_isim = (select irtibat_ismi from tedarikciler where firma_ismi='Apple')
where urun_isim='Laptop'
