--ALIASES
CREATE TABLE calisanlar55  (
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);
INSERT INTO calisanlar55 VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO calisanlar55 VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO calisanlar55 VALUES(345678901, 'Mine Bulut', 'Izmir');

SELECT * FROM CALISANLAR55

-- Eğer iki sutunun verilerini birleştirmek istersek concat sembolu || kullanırız
SELECT calisan_id AS id, calisan_isim||' '||calisan_dogdugu_sehir AS calisan_bilgisi FROM calisanlar55
--2. YOl
SELECT calisan_id AS id, concat (calisan_isim,calisan_dogdugu_sehir) AS calisan_bilgisi FROM calisanlar55


--is null condition

CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');  
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

select * from insanlar
--name sutununda null olan degerleri listeleyelim
select name from insanlar where name is null

--insanalr tablosundan  sadece null olmayan degerleri listeleyiniz
select name from insanlar where name is not null

--insanalr tablosunda null deger almis verileri no name olarak degistiriniz
update insanlar
set name='No Name'
where name is null;

--ORDER BY CLAUSE
/*
Tablolardaki verileri sıralamak için ORDER BY komutu kullanırız
Büyükten küçüğe yada küçükten büyüğe sıralama yapabiliriz
Default olarak küçükten büyüğe sıralama yapar(asc)
Eğer BÜYÜKTEN KÜÇÜĞE sıralmak istersek ORDER BY komutundan sonra DESC komutunu kullanırız
*/

CREATE TABLE insanlar1 order by asc, soyisim desc;
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar1 VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar1 VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar1 VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar1 VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar1 VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar1 VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

SELECT * FROM insanlar1
--Insanlar tablosundaki datalari adres’e gore siralayin  
SELECT * FROM insanlar1 ORDER BY adres;
SELECT * FROM insanlar1 ORDER BY soyisim;

--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
SELECT * FROM insanlar1 WHERE isim='Mine' order by ssn;

--NOT : Order By komutundan sonra field ismi yerine field numarasi da kullanilabilir
--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin
SELECT * FROM INSANLAR1 WHERE soyisim='Bulut' order by 2

--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
select * from insanlar1 order by ssn desc;

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
select * from insanlar1  order by isim asc, soyisim desc;

-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
select isim,soyisim from insanlar1 order by length (soyisim); 
/*
Eğer sutun uzunluğuna göre sıralamak istersek LENGTH komutu kullanırız 
Ve yine uzunluğu büyükten küçüğe sıralamak istersek sonuna DESC komutunu ekleriz
*/
select isim,soyisim from insanlar1 order by length (soyisim) desc;

-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
select isim||' '||soyisim as isim_soyisim from insanlar1 order by length (isim||soyisim);
--concat methodu ile
select concat(isim,' ',soyisim)as isim_soyisim from insanlar1 order by length (isim||soyisim);
select concat(isim,' ',soyisim)as isim_soyisim from insanlar1 order by length (concat(isim,soyisim));

--GROUP BY CLAUSE
/*
Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT
komutuyla birlikte kullanılır.
*/
CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

SELECT * FROM MANAV
--Isme gore alinan toplam urunleri listeleyiniz
SELECT isim,SUM(urun_miktar) as aldigi_toplama_urun from manav group by isim ;

--Isme gore alinan toplam urunleri bulun ve bu urunleri buyukten kucuge listeleyiniz
SELECT isim,SUM(urun_miktar) as aldigi_toplama_urun from manav group by isim order by isim desc;

-- Urun ismine gore urunu alan toplam kisi sayisi
select urun_adi,count(isim) from manav group by urun_adi;



