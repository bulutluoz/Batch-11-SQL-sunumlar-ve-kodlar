--SUBQUERY baska bir SORGU(query)’nun icinde calisan SORGU’dur.
-- 1) WHERE’ den sonra kullanilabilir

SELECT isim
FROM sehirler
WHERE isim>'C';

CREATE TABLE personel3 
(
id number(9), 
isim varchar2(50), 
sehir varchar2(50), 
maas number(20), 
sirket varchar2(20)
);


INSERT INTO personel3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Honda');
INSERT INTO personel3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'Toyota');
INSERT INTO personel3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Honda');
INSERT INTO personel3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Ford');
INSERT INTO personel3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Hyundai');
INSERT INTO personel3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Ford');
INSERT INTO personel3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Honda');

SELECT *
FROM personel3;

CREATE TABLE sirketler
(
sirket_id number(9), 
sirket varchar2(20), 
personel_sayisi number(20)
);


INSERT INTO sirketler VALUES(100, 'Honda', 12000);
INSERT INTO sirketler VALUES(101, 'Ford', 18000);
INSERT INTO sirketler VALUES(102, 'Hyundai', 10000);
INSERT INTO sirketler VALUES(103, 'Toyota', 21000);
INSERT INTO sirketler VALUES(104, 'Mazda', 17000);


SELECT *
FROM sirketler;

-- izmirde calisan Veli YIlmaz'in maasini 2000 yapin

UPDATE personel3
SET maas=2000
WHERE sehir='Izmir' AND isim='Veli Yilmaz';

-- personel sayisi 10000 olan sirketten personel 3 tablosunda bulunan kisinin maasini 6000 yapin

UPDATE personel3
SET maas=6000
WHERE sirket=( SELECT sirket      -- Hyundai
                            FROM sirketler
                            WHERE personel_sayisi=10000); -- personel sayisi 10000 olan sirketin ismi

-- izmir,istanbul veya bursada personeli bulunan sirketlerin calisan sayilarini listeleyin
-- WHERE komutundan sonra = kullaniyorsak esitligin sonrasinda sorgunun sadece 1 deger dondureceginden emin olmaliyiz
-- eger sorgunun kac sonuc dondurecegini bilmiyorsak veya birden fazla sonuc dondurecegini biliyorsak
-- o zaman WHERE komutundan sonra = yerine IN kullanmaliyiz


SELECT personel_sayisi
FROM sirketler
WHERE sirket IN (  SELECT sirket
                                FROM personel3
                                WHERE sehir IN ('Istanbul','Izmir','Bursa'));

-- Personel sayisi 15.000’den cok olan sirketlerin isimlerini ve bu sirkette calisan personelin isimlerini listeleyin

SELECT sirket,isim
FROM personel3
WHERE sirket IN (  SELECT sirket
                                FROM sirketler
                                WHERE personel_sayisi>15000);
                                
-- Sirket_id’si 101’den buyuk olan sirketlerin verdikleri maaslari ve o maasi alanlarin sehirlerini listeleyiniz                                 

SELECT maas,sehir
FROM personel3
WHERE sirket IN (SELECT sirket
                                FROM sirketler
                                WHERE sirket_id>101);

-- Ankara’da personeli olan  sirketlerin sirket id ve calisan sayilarini listeleyiniz 

SELECT sirket_id,personel_sayisi
FROM sirketler
WHERE sirket IN (  SELECT sirket
                                FROM personel3
                                WHERE sehir='Ankara');
                                
-- SELECT'den sonra kullanilabilir
-- Honda'da calisan personelin id,isim ve maaslarini listeleyin
-- *** SELECT den sonra SUBQUERY yazarsak sorgu sonucunun sadece 1 deger getireceginden emin olmaliyiz
-- bir tablodan tek deger getirebilmek icin ortalama AVG , toplam SUM, adet COUNT, MIN, MAX  gibi
-- fonksiyonlar kullanilir ve bu fonksiyonlara AGGREGATE FONKSIYONLAR denir
SELECT id,isim,maas
FROM personel3
WHERE sirket='Honda';

-- Her sirketin ismini, personel sayisini ve personelin ortalama maasini listeleyen bir QUERY yazin.
-- honda da calisanlarin ort maasi: 2500+3000+2500=8000  ort=8000/3=2666,666666..

SELECT sirket,personel_sayisi, (    SELECT AVG(maas)
                                                        FROM  personel3
                                                        WHERE sirketler.sirket=personel3.sirket) AS ortalama_maas
FROM sirketler;

-- sirketlerin id, isim ve max maas miktarini listeleyin

SELECT sirket_id,sirket, (SELECT MAX(maas)
                                FROM personel3
                                WHERE sirketler.sirket = personel3.sirket) AS max_maas
FROM sirketler;

-- sirket ismi,personel sayisi ve bulundugu toplam sehir sayisini listeleyin
SELECT sirket,personel_sayisi,(SELECT COUNT(sehir)
                                                    FROM personel3
                                                    WHERE sirketler.sirket = personel3.sirket) AS sehir_sayisi
FROM sirketler;

-- sirket id,sirket adi ve tablodaki personele odenen toplam maasi listeleyin

SELECT sirket_id,sirket,(SELECT SUM(maas)
                                            FROM personel3
                                            WHERE sirketler.sirket = personel3.sirket) AS toplam_maas
FROM sirketler;

-- sirket id, sirket ismi, sirketteki min maas, sirketteki max maas, sirketteki ort.maas lari yazdirin 

SELECT sirket_id,sirket,(SELECT MIN(maas)
                                        FROM personel3
                                        WHERE sirketler.sirket=personel3.sirket)AS min_maas,
                                        (SELECT MAX(maas)
                                        FROM personel3
                                        WHERE sirketler.sirket=personel3.sirket)AS max_maas,
                                        (SELECT AVG(maas)
                                        FROM personel3
                                        WHERE sirketler.sirket = personel3.sirket) AS ort_maas
FROM sirketler;


-- IN : eger istedigimiz degerleri AND,OR gibi mantiksal operatorlerlerle tek tek yazmak istemiyorsak
-- IN (istegimiz tum degerler ) seklinde yazabiliriz

-- EXISTS () komutu da IN ile ayni kullanima sahiptir

CREATE TABLE mart_satislar2 
(
urun_id number(10),
musteri_isim varchar2(50), 
urun_isim varchar2(50)
);

INSERT INTO mart_satislar2 VALUES (10, 'Mark', 'Honda');
INSERT INTO mart_satislar2 VALUES (10, 'Mark', 'Honda');
INSERT INTO mart_satislar2 VALUES (20, 'John', 'Toyota');
INSERT INTO mart_satislar2 VALUES (30, 'Amy', 'Ford');
INSERT INTO mart_satislar2 VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart_satislar2 VALUES (10, 'Adem', 'Honda');
INSERT INTO mart_satislar2 VALUES (40, 'John', 'Hyundai');
INSERT INTO mart_satislar2 VALUES (20, 'Eddie', 'Toyota');

SELECT *
FROM mart_satislar2;


CREATE TABLE nisan_satislar 
(
urun_id number(10),
musteri_isim varchar2(50), 
urun_isim varchar2(50)
);

INSERT INTO nisan_satislar VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan_satislar  VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan_satislar VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan_satislar VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan_satislar VALUES (20, 'Mine', 'Toyota');

SELECT *
FROM nisan_satislar;

SELECT urun_id,musteri_isim
FROM mart_satislar2
WHERE urun_id IN (SELECT urun_id
                                FROM nisan_satislar
                                WHERE nisan_satislar.urun_id = mart_satislar2.urun_id);
                                
SELECT urun_id,musteri_isim
FROM mart_satislar2
WHERE NOT EXISTS (SELECT urun_id
                                FROM nisan_satislar
                                WHERE nisan_satislar.urun_id = mart_satislar2.urun_id);











