-- Kelimeler tablosundan tum kelimeleri listeleyin
SELECT kelime
FROM kelimeler;

-- Kelimer tablosundaki tum kelimeleri buyuk harf olarak listeleyin

SELECT UPPER(kelime)
FROM kelimeler;

-- Manav tablosundan isim ve urun adlarini kucuk  harf olarak listeleyin

SELECT LOWER(isim), LOWER(urun_adi)
FROM manav;

-- Employees tablosunda Ismi kucuk harf, soyismi buyukharf, email'i sadece ilk harf buyuk olarak listeleyin
SELECT LOWER(first_name),UPPER(last_name), INITCAP (email)
FROM employees;

-- MANAV daki tum urunleri listeleyin
SELECT urun_adi
FROM manav;
-- TEKRAR EDEN DEGERLERI gormek istemiyorsak DISTINCT komutu kullanilir

SELECT DISTINCT urun_adi
FROM manav;

-- Kac farkli musteri vardir?

SELECT COUNT(DISTINCT isim)
FROM manav;

-- Kac farkli urun satilmaktadir

SELECT COUNT(DISTINCT urun_adi)
FROM manav;


-- Emplaoyees tablosundan isim ve maaslari, maas miktarina gore sirali olarak listeleyin

SELECT first_name, salary
FROM employees
ORDER BY salary DESC;

-- Employees tablosundaki calisanlardan en fazla maas alan 5 kisinin ismini ve maasini yazdirin

SELECT first_name, salary
FROM employees
ORDER BY salary DESC
FETCH NEXT 5 ROWS ONLY;

-- FETCH NEXT 5 ROW ONLY komutu tablodaki ilk 5 satiri listeler

-- 4. en cok maas alan kisinin ismini ve maasini yazdirin
SELECT first_name, salary
FROM employees
ORDER BY salary DESC
OFFSET 3 ROW  --- 3 satiri atlatir
FETCH NEXT 1 ROW ONLY;  --  3 satir atladiktan sonra ilk 1 satiri yazdirir

---PIVOT

SELECT *
FROM manav;
-- MUsterilerin kacar defa elma,armut ve uzum aldiklarini pivot tablo ile gosteriniz
SELECT *
FROM (SELECT isim,urun_adi FROM manav)
PIVOT (COUNT(urun_adi) FOR urun_adi IN ('Elma','Armut','Uzum'));


SELECT *
FROM (SELECT isim,urun_adi FROM manav)
PIVOT (COUNT(isim) FOR isim IN ('Ali','Veli','Ayse','Hasan'));


SELECT *
FROM (SELECT isim,urun_miktar FROM manav)
PIVOT (COUNT(isim) FOR isim IN ('Ali','Veli','Ayse','Hasan'));


SELECT *
FROM (SELECT isim,urun_miktar FROM manav)
PIVOT (SUM (urun_miktar) FOR isim IN ('Ali','Ayse','Veli'));


SELECT *
FROM (SELECT isim,adres FROM insanlar3)
PIVOT (COUNT (isim) FOR isim IN ('Ali','Mine','Veli','Mahmut'));

CREATE TABLE personel6 
(
id number(9), 
isim varchar2(50), 
sehir varchar2(50), 
maas number(20), 
sirket varchar2(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);

INSERT INTO personel6 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel6 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel6 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
INSERT INTO personel6 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel6 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel6 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel6 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

SELECT *
FROM new_personel;

-- tabloya cocuk sayisi field'i ekleyelim

ALTER TABLE personel6
ADD cocuk_sayisi NUMBER(2);

UPDATE personel6
SET cocuk_sayisi=1
WHERE isim='Mehmet Ozturk';



-- tabloda cocuk sayisi field'inda null degerler yerine 0 yazdirin
UPDATE personel6
SET cocuk_sayisi=0
WHERE cocuk_sayisi IS NULL;

-- ULKE field'i ekleyin ve default olarak ulke ismini 'Turkiye' girin

ALTER TABLE personel6
ADD ulke VARCHAR2(40) DEFAULT 'Turkiye';


-- Telefon ve adres field'i ekleyin
ALTER TABLE personel6
ADD (telefon VARCHAR2(20), adres VARCHAR2 (100));

-- Tablodan ulke field'ini silin

ALTER TABLE personel6
DROP COLUMN ulke;


-- tablodan telefon'u silelim
ALTER TABLE personel6
DROP (telefon);

-- tablodaki maas fieldinin adini aylik diye degistirin
ALTER TABLE personel6
RENAME COLUMN Maas TO Aylik;


-- Tablonun adini personel6 degil new_personel
ALTER TABLE personel6
RENAME TO new_personel;


UPDATE new_personel
SET cocuk_sayisi='Deger Girilmedi';


-- cocuk sayisi field'inin data tipini varchar2 yapalim


ALTER TABLE new_personel
MODIFY cocuk_sayisi VARCHAR2(20);












