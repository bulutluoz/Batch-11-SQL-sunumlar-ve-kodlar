INSERT INTO mart_satislar VALUES (10, 'Ali', 'Honda',75000);
INSERT INTO mart_satislar VALUES (10, 'Ayse', 'Honda',95200);
INSERT INTO mart_satislar VALUES (20, 'Hasan', 'Toyota',107500);
INSERT INTO mart_satislar VALUES (30, 'Mehmet' , 'Ford', 112500);
INSERT INTO mart_satislar VALUES (20, 'Ali', 'Toyota',88000);
INSERT INTO mart_satislar VALUES (10, 'Hasan', 'Honda',150000);
INSERT INTO mart_satislar VALUES (40, 'Ayse', 'Hyundai',140000);
INSERT INTO mart_satislar VALUES (20, 'Hatice', 'Toyota',60000);
SELECT musteri_isim
FROM mart_satislar
WHERE urun_id=40;
--urun id 40 olan tum urunlerin musteri isimlerini  listeleyecek bir sorgu (Query) yazin
-- urun fiyati 90000 den fazla olan urun isimlerini listeleyen query yaziniz
SELECT urun_isim
FROM mart_satislar
WHERE urun_fiyat>90000;
SELECT *
from mart_satislar;
-- urun id si 20 den buyuk olan urunlerin ismlerini ve musteri isimlerini yazdiran query yaziniz
SELECT urun_isim,musteri_isim
FROM mart_satislar
WHERE urun_id>20;
-- urun id si 20'den kucuk veya 30'dan buyuk olan urunlerin fiyatlarini listeleleyen query yazin
SELECT urun_fiyat
FROM mart_satislar
WHERE urun_id<20 OR urun_id>30;
-- ismi ali veya urun ismi Honda olanlarin urun id ve urun fiyatlarini yazdirin
SELECT urun_id,urun_fiyat
FROM mart_satislar
WHERE musteri_isim='Ali' OR urun_isim='Honda';
-- mehmet ismini bana getirecek bir sorgu yazin
SELECT musteri_isim
FROM mart_satislar
WHERE urun_id=30;
CREATE TABLE tedarikci
(
id number(5) PRIMARY KEY,
isim varchar2(50), 
irtibat_isim varchar2(50)
);
INSERT INTO tedarikci VALUES(100, 'IBM', 'Ali Can');
INSERT INTO tedarikci VALUES(101, 'APPLE', 'Merve Temiz');
INSERT INTO tedarikci VALUES(102, 'SAMSUNG', 'Kemal Can');
INSERT INTO tedarikci VALUES(103, 'LG', 'Ali Can');
SELECT *
FROM tedarikci;
CREATE TABLE urunler3 
( 
tedarikci_id number(5), 
urun_id number(11), 
urun_isim varchar2(50), 
musteri_isim varchar2(50),
CONSTRAINT urunler3_fk FOREIGN KEY(tedarikci_id) REFERENCES tedarikci(id )
);
INSERT INTO urunler3 VALUES(100, 1001,'Laptop', 'Suleyman');
INSERT INTO urunler3 VALUES(101, 1002,'iPad', 'Fatma');
INSERT INTO urunler3 VALUES(102, 1003,'TV', 'Ramazan');
INSERT INTO urunler3 VALUES(103, 1004,'Phone', 'Ali Can');
SELECT *
FROM urunler3;
-- irtibat isim Ali Can olan sirket ismini yazdiran sorgu yaziniz
SELECT isim
FROM tedarikci
WHERE irtibat_isim='Ali Can';
-- LG sirketinin irtibat ismini Veli Cem olarak update edin
UPDATE tedarikci
SET irtibat_isim='Veli Cem'
WHERE isim='LG';
-- 1- irtibat isim merve Temiz olan sirketin id'sini yazdirin
SELECT id
FROM tedarikci
WHERE irtibat_isim='Merve Temiz'; -- 101
-- 2- tedarikci id'si 100 olan firmanin urun ismini Bilgisayar yapin
UPDATE urunler3
SET urun_isim='Bilgisayar'
WHERE tedarikci_id=100;
-- 3- irtibat ismi Merve temiz olan sirketin urun ismini MacBook yapin
UPDATE urunler3
SET urun_isim='MacBook'
WHERE tedarikci_id=(SELECT id
                                    FROM tedarikci
                                    WHERE irtibat_isim='Merve Temiz');
                                    
-- musteri ismi Suleyman olan sirketin irtibat ismini Mehmet Guzel yapin
--1-100 numarali sirketin irtibat ismini Mehmet guzel yapin
UPDATE tedarikci
SET irtibat_isim='Mehmet Guzel'
WHERE id=100;
-- 2- musteri ismi suleyman olan sirketin tedarikci id sini yazdiran query yazin
SELECT tedarikci_id
FROM urunler3
WHERE musteri_isim='Suleyman'; --100
UPDATE tedarikci
SET irtibat_isim='Mehmet Guzel'
WHERE id=(SELECT tedarikci_id
                    FROM urunler3
                    WHERE musteri_isim='Suleyman');
-- Samsung sirketinin urun id sini 1010 yapin
UPDATE urunler3
SET urun_id=1010
WHERE tedarikci_id=( SELECT id
                                     FROM tedarikci
                                     WHERE isim='SAMSUNG');
