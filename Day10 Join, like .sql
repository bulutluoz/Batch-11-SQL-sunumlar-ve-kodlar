CREATE TABLE sirketler2(
sirket_id number(9),
sirket_isim varchar2(20)
);
​
SELECT*
FROM sirketler2;
​
INSERT INTO sirketler2 VALUES(100, 'Toyota');
INSERT INTO sirketler2 VALUES(101, 'Honda');
INSERT INTO sirketler2 VALUES(102, 'Ford');
INSERT INTO sirketler2 VALUES(103, 'Hyundai');
​
CREATE TABLE siparisler(
siparis_id number(9),
sirket_id number(9),
siparis_tarihi date
);
​
SELECT*
FROM siparisler;
​
INSERT INTO siparisler VALUES(11, 101, '17-Apr-2020');
INSERT INTO siparisler VALUES(22, 102, '18-Apr-2020');
INSERT INTO siparisler VALUES(33, 103, '19-Apr-2020');
INSERT INTO siparisler VALUES(44, 104, '20-Apr-2020');
INSERT INTO siparisler VALUES(55, 105, '21-Apr-2020');
​
​
--her iki tabloda ortak olan sirket_id'leri icin sirketler tablosundan sirket ismi,
--siparisler tablosundan siparis_tarhi bilgilerini lsitelyen sorgu yaziniz
​
​
SELECT sirketler2.sirket_isim,siparisler.siparis_tarihi
FROM sirketler2 INNER JOIN siparisler
ON sirketler2.sirket_id = siparisler.sirket_id;
​
--INNER JOIN: her iki tabloda ortak olan record'lara ait bilgileri getirir
​
--sirketler2 tablosunda bulunan tum sirketler icin,sirket ismi
--ve varolan siparis_id'lerini yazdiran sorgu yazdirin
​
SELECT sirketler2.sirket_isim,siparisler.siparis_id
FROM sirketler2 LEFT JOIN siparisler
ON sirketler2.sirket_id=siparisler.sirket_id;
​
--LEFT JOIN ILK tablodaki tum datalari ve
--HER IKI TABLODA OLAN RECORDLARIN ikinci tablodaki degerlerine ulsair
​
--tum siparis id ve siparis tarihlerini ve varsa sirket isimlerini listeleyen sorgu yaziniz
SELECT siparisler.siparis_id,siparisler.siparis_tarihi,sirketler2.sirket_isim
FROM siparisler LEFT JOIN sirketler2
ON siparisler.sirket_id=sirketler2.sirket_id;
​
--Bu soruyu RIGHT JOIN ile yazalaim

SELECT siparisler.siparis_id, siparisler.siparis_tarihi, sirketler2.sirket_isim
FROM sirketler2 RIGHT JOIN siparisler
ON siparisler.sirket_id=sirketler2.sirket_id;

-- LEFT JOIN de tum kayitlari almak istedigimiz tabloyu sola (left)
-- RIGHT JOIN de tum kayitlari almak istedigimiz tabloyu saga(right) yaziyoruz
-- Kullanimda bunun disinda her hangi bir fark yok


-- Her iki tabloda bulunan tum kayitlar icin sirket ismi ve siparis tarihlerini yazdirin

SELECT sirketler2.sirket_isim, siparisler.siparis_tarihi
FROM sirketler2 FULL JOIN siparisler
ON siparisler.sirket_id=sirketler2.sirket_id
ORDER BY 2;

CREATE TABLE personel5
 (
id number(2), 
isim varchar2(20), 
title varchar2(60), 
yonetici_id number(2)
);


INSERT INTO personel5 VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel5 VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel5 VALUES(3, 'Ayse Gul', 'QA Lead', 4);
INSERT INTO personel5 VALUES(4, 'Fatma Can', 'CEO', 5);


SELECT *
FROM personel5;

-- SELF JOIN bir tablonun kendi icinde yeniden yapilandirilarak yazdirilmasidir
-- personel5 tablosundaki isimleri, title'lari ve yonetici isimlerini yazdiran bir sorgu

SELECT p1.isim AS calisan_isim , p1.title,p2.isim AS yonetici_ismi
FROM personel5 p1 INNER JOIN personel5 p2
ON p1.yonetici_id=p2.id;

-- LIKE : benzer......

CREATE TABLE musteriler2
(
id number(10) UNIQUE,
isim varchar2(50) NOT NULL, 
gelir number(6)
);

INSERT INTO musteriler2 (id, isim, gelir) VALUES (1001, 'Ali', 62000);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1002, 'Ayse', 57500);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1004, 'Fatma', 42000);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1005, 'Kasim', 44000);


SELECT
    *
FROM musteriler2;

-- id 'si 1002 den buyuk olan isimleri ve gelirleri yazdirin
SELECT isim,gelir
FROM musteriler2
WHERE id>1002;

-- ismi F ile baslayan musterileri ve gelirlerini yazdirin

SELECT isim,gelir
FROM musteriler2
WHERE isim LIKE 'F%';

-- ismi Fa ile baslayan

SELECT isim,gelir
FROM musteriler2
WHERE isim LIKE 'Fa%';

-- ismi e ile biten

SELECT isim,gelir
FROM musteriler2
WHERE isim LIKE '%e';

-- isminin icinde i harfi olanlar 

SELECT isim,gelir
FROM musteriler2
WHERE isim LIKE '%i%';

-- minumum 5 harfli isimleri getiren 

SELECT isim,gelir
FROM musteriler2
WHERE isim LIKE '%_____%';

-- ikinci harfi a olanlari getiren

SELECT isim,gelir
FROM musteriler2
WHERE isim LIKE '_a%';

-- isminin ilk harfi haric atma olan
SELECT isim,gelir
FROM musteriler2
WHERE isim LIKE '_atma';

-- isminin ikinci harfi a veya e olan 

CREATE TABLE kelimeler
(
id number(10) UNIQUE, 
kelime varchar2(50) NOT NULL, 
Harf_sayisi number(6)
);

INSERT INTO kelimeler VALUES (1001, 'hot', 3);
INSERT INTO kelimeler VALUES (1002, 'hat', 3);
INSERT INTO kelimeler VALUES (1003, 'hit', 3);
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
INSERT INTO kelimeler VALUES (1008, 'hct', 3);
INSERT INTO kelimeler VALUES (1005, 'adem', 4);
INSERT INTO kelimeler VALUES (1006, 'selim', 5);
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);

select *
FROm kelimeler;

-- Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM kelimeler
WHERE REGEXP_LIKE (kelime, 'h[ai]t');

Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM kelimeler
WHERE REGEXP_LIKE (kelime, 'h[a-k]t');



