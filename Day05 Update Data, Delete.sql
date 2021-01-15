--Ogrenciler6 tablosu olusturun. Icinde id,isim,veli_isim ve not_ort field’lari olsun. Id field’i birlikte Primary Key olsun.
CREATE TABLE ogrenciler6
(
id char(3),
isim varchar2(50),
veli_isim varchar2(50),
not_ort number(3),
CONSTRAINT ogrenciler6_pk PRIMARY KEY (id)
);

	INSERT INTO ogrenciler6 VALUES(123, 'Ali Can', 'Hasan',75);
	INSERT INTO ogrenciler6 VALUES(124, 'Merve Gul', 'Ayse',85);
	INSERT INTO ogrenciler6 VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO ogrenciler6 VALUES(126, 'Fatma Gun', 'Mehmet',90);
    INSERT INTO ogrenciler6 VALUES(127, 'Ali Can', 'Mehmet',91);

SELECT *
FROM ogrenciler6;
--) notlar tablosu olusturun. ogrenci_id,ders_adi,yazili_notu field'lari olsun, ogrenci_id field'i Foreign Key olsun

CREATE TABLE notlar 
( 
ogrenci_id char(3), 
ders_adi varchar2(30), 
yazili_notu number (3), 
CONSTRAINT notlar_fk FOREIGN KEY (ogrenci_id) REFERENCES ogrenciler6 (id)
 );

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);
INSERT INTO notlar VALUES ('127', 'Ingilizce',90);

SELECT *
FROM notlar;

-- Alican'in veli ismini Kemal yapin

UPDATE ogrenciler6
SET veli_isim='Kemal'
WHERE isim='Ali Can';

-- Not ortalamasi 91 olan ogrencinin ismini Yasin yapin
UPDATE ogrenciler6
SET isim='Yasin'
WHERE not_ort=91;

-- Veli ismi Hasan olan ogrencinin ders adini Edebiyat yapin

-- update yapacaginiz tablodan baslayin

UPDATE notlar
SET ders_adi='Edebiyat'
WHERE ogrenci_id=(SELECT id
                                FROM ogrenciler6
                                WHERE veli_isim='Hasan'); --125


-- matematikten 90 alan ogrencinin veli ismini Tuba yapin
-- ipucu : update isleminden baslayin

UPDATE ogrenciler6
SET veli_isim='Tuba'
WHERE id=(SELECT ogrenci_id
                      FROM notlar
                      WHERE ders_adi='Matematik' AND yazili_notu=90); --126

-- DELETE 
-- tablodaki kayitlari silmek ile tabloyu silmek farkli islemlerdir
-- silme komutlari da iki basamaklidir, biz genelde geri getirilebilecek sekilde sileriz 
-- ancak bazen guvenlik gibi sebeplerle geri getirilmeyecek sekilde silinmesi istenebilir


CREATE TABLE ogrenciler7
(
id char(3),
isim varchar2(50),
veli_isim varchar2(50),
not_ort number(3),
CONSTRAINT ogrenciler7_pk PRIMARY KEY (id)
);

	INSERT INTO ogrenciler7 VALUES(123, 'Ali Can', 'Hasan',75);
	INSERT INTO ogrenciler7 VALUES(124, 'Merve Gul', 'Ayse',85);
	INSERT INTO ogrenciler7 VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO ogrenciler7 VALUES(126, 'Fatma Gun', 'Mehmet',90);
    INSERT INTO ogrenciler7 VALUES(127, 'Ali Can', 'Mehmet',91);

SELECT *
FROM ogrenciler7;
-- 1- DELETE komutu ile bir kayida ait bilgilerin kismi olarak silinmesi mumkun degildir 
-- 2- Boyle olunca DELETE komutu DELETE fROM seklinde kullanilir

DELETE FROM ogrenciler7;
-- tablodaki tum kayitlari siler (ONEMLI : tabloyu silmez tablodaki tum kayitlari siler)
-- bu komut calistirildiktan sonra tum tabloyu goruntulersek sadece field isimlerini goruruz

-- tum kayitlari tekrar yukleyelim
-- tablodan ismi Ali Can olanlari silelim
DELETE FROM ogrenciler7
WHERE isim='Ali Can';

-- notu 90 dan dusuk olanlari silin
DELETE FROM ogrenciler7
WHERE not_ort<90;

-- veli ismi Mehmet olan kaydi silin
DELETE FROM ogrenciler7
WHERE veli_isim='Mehmet';

-- DELETE FROM ile silinen kayitlar geri getirilebilir
-- Eger geri getilmesini istemediginiz kayitlar varsa o zaman TRUNCATE koutu kullanilir

-- Datalari yeniden yukleyelim

TRUNCATE TABLE ogrenciler7;
-- bu komut tablomuzdaki tum kayitlari GERI GETIRILEMEYECEK sekilde siler

-- Datalari yeniden yukleyelim


TRUNCATE TABLE ogrenciler7
WHERE veli_isim='Hasan';
-- TRUNCATE komutu tablo yapısını değiştirmeden, 
-- tablo içinde yer alan tüm verileri tek komutla silmenizi sağlar. 

-- TABLOYU nasil sileriz
DROP TABLE ogrenciler7;
-- Bu komut ile tablo silinir (Istenirse kod ile geri getirilebilir)
-- Drop komutu calistiktan sonra tabloyu goruntulemek isterseniz
-- "table or view does not exist" hatasi alirsiniz

FLASHBACK TABLE ogrenciler7 TO BEFORE DROP;
-- Drop ile silinen tabloyu geri getirmek isterseniz Flashback komutu kullanilir

-- eger tabloyu geri getirilemeyecek sekilde silmek istiyorsak PURGE komutu kullanilir
PURGE ogrenciler7;
-- PURGE sadece DROP ile silinmis tablolar icin kullanilir
-- DROP kullanmadan PURGE komutu kullanmak isterseniz 
-- ORA-38302: invalid PURGE option hatasi alirsiniz

-- PURGE yapmak icin 2 yontem kullanabiliriz
--1 tek satirda DROP ve PURGE beraber kullanabiliriz
DROP TABLE ogrenciler7 PURGE; 

-- bu komut ile sildigimiz tabloyu geri getirmek icin FLASHBACK komutunu kullansak
-- ORA-38305: object not in RECYCLE BIN hatasini alirsiniz

-- 2 daha once DROP ile silinmis bir tablo varsa sadece PURGE kullanabiliriz
--Tabloyu yeniden olusturalim

DROP TABLE ogrenciler7;
-- bu asamada istersek FLASHBACK ile tablomuzu geri getirebiliriz
PURGE TABLE ogrenciler7;
-- bu asamada istesem de tabloyu geri getiremem

