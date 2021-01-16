CREATE TABLE musteriler
(
urun_id number(10),
musteri_isim varchar2(50),
urun_isim varchar2(50)
);
SELECT*
FROM musteriler;
​
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler  VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');
​
--musteriler tab;osundan orange veya apple alan musterileri listleeyin
SELECT *
FROM musteriler
WHERE urun_isim='Orange' OR urun_isim='Apple';
​
--ismi mark,john veya adem olan musterilerin aldiklari urun isimlerini listeleyin
SELECT urun_isim
FROM musteriler
WHERE musteri_isim IN ('Mark','John','Adem');
​
--orange,palm veya apricok alan musterilerin tum bilgilerini listeleyin
--IN yazip parantez acip istenen degerler yazilir.
SELECT*
FROM musteriler
WHERE urun_isim IN('Orange','Palm','Apricot');
​
--urun id si 20 den buyuk ve 40 dan kucuk olan urunleri alan musteri isimlerini listeleyin
SELECT musteri_isim
FROM musteriler
WHERE urun_id>20 and urun_id<40;
​
----urun id si 20 ye esit veya buyuk buyuk ve 40 dan kucuk veya esit olan urunleri alan musteri isimlerini listeleyin
​
​
SELECT musteri_isim
FROM musteriler
WHERE urun_id>=20 and urun_id<=40;
​
--sinirlar dahil ise BETWEEN komutunu kullaniriz  
SELECT musteri_isim
FROM musteriler
WHERE urun_id BETWEEN 20 AND 40;
​
--musteri isminin ilk harfi b'den sonra k'dan once olan musterilerin aldiklari urunleri listeleyin
SELECT urun_isim
FROM musteriler
WHERE musteri_isim BETWEEN 'B' AND 'K'; 
​
--eger BETWEEN komutu CHAR veya VARCHAR2 icin kullanilirsa ilk harfe bakar
--bu durumda buyuk kucuk harf konusuna dikkat edilmelidir.
​
--urun id si 20 den kucuk veya 30 dan buyuk olan urunleri satin alan musteri isimlerini listeleyin
SELECT musteri_isim
FROM musteriler
WHERE urun_id<20 or urun_id>30;
​
SELECT musteri_isim
FROM musteriler
WHERE urun_id NOT BETWEEN 20 AND 30;
-- Eger bir aralikta olmayan degerleri bulmak istiyorsak NOT BETWEEN kullanabiliriz
CREATE TABLE personel(
id CHAR(9) UNIQUE,
isim VARCHAR2(50) ,
soyisim VARCHAR2(50),
email VARCHAR2(50),
ise_bas_tar DATE,
is_unvani VARCHAR2(100),
maas NUMBER(5)
);
INSERT INTO personel VALUES (123456789,'Ali','Can','alican@gmail.com','10-APR-10','isci',5000);
INSERT INTO personel VALUES (123456788,'Veli','Cem','velicem@gmail.com','10-APR-12','isci',5500);
INSERT INTO personel VALUES (123456787,'Ayse','Gul','aysegul@gmail.com','01-MAY-14','muhasebeci',4500);
INSERT INTO personel VALUES (123456786,'Fatma','Yasa','fatmayasa@gmail.com','10-APR-09','muhendis',7500);
SELECT*FROM personel;
-- maasi 5000'den az olan veya unvani isci olan kisilerin isim soyisimlerini yazdirin
SELECT isim,soyisim
FROM personel
WHERE maas<5000 OR is_unvani='isci';
-- ismi B harfi ile L harfi arasinda olan kisilerin unvan ve maaslarini listeleyin
SELECT is_unvani,maas
FROM personel
WHERE isim BETWEEN 'B' AND 'L';
-- maasi 6000'den az olanlara %10 zam yapin
UPDATE personel
SET maas=maas*1.1
WHERE maas<6000;
-- 1 ocak 2011 den once ise girenlere 500 lira zam yapin

UPDATE personel
SET maas=maas+500
WHERE ise_bas_tar<'01-JAN-2011';
