CREATE TABLE personel6
(
id number(9), 
isim varchar2(50), 
sehir varchar2(50), 
maas number(20), 
sirket varchar2(20)
);

INSERT INTO personel6 VALUES(123456789, 'Johnny Walk', 'New Hampshire', 2500, 'IBM');
INSERT INTO personel6 VALUES(234567891, 'Brian Pitt', 'Florida', 1500, 'LINUX');
INSERT INTO personel6 VALUES(245678901, 'Eddie Murphy', 'Texas', 3000, 'WELLS FARGO');
INSERT INTO personel6 VALUES(456789012, 'Teddy Murphy', 'Virginia', 1000, 'GOOGLE');  
INSERT INTO personel6 VALUES(567890124, 'Eddie Murphy', 'Massachuset', 7000, 'MICROSOFT');
INSERT INTO personel6 VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'TD BANK');
INSERT INTO personel6 VALUES(123456719, 'Adem Stone', 'New Jersey', 2500, 'IBM');

SELECT *
FROM personel6;

CREATE TABLE isciler 
(
id number(9),
isim varchar2(50), 
sehir varchar2(50), 
maas number(20), 
sirket varchar2(20)
);

INSERT INTO isciler VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO isciler VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO isciler VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO isciler VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO isciler VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO isciler VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO isciler VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');


SELECT *
FROM isciler;

-- 1) Her iki tablodaki ortak id’leri ve 
--     personel6 tablosunda bu id’ye sahip isimleri
-- isme gore sirali olarak listeleyen query yaziniz

SELECT isim,id
FROM  personel6
WHERE  EXISTS (SELECT id
                        FROM isciler
                        WHERE isciler.id = personel6.id)
ORDER BY isim; 
                        
-- 2) Her iki tablodaki ortak id ve isme sahip kayitlari listeleyen query yaziniz

SELECT id, isim
FROM personel6

INTERSECT

SELECT id, isim
FROM isciler;

-- 3) Persone6 tablosunda kac farkli sehirden personel var?

SELECT COUNT(DISTINCT sehir) AS farkli_sehir_sayisi
FROM personel6;


-- 4) Personel6 tablosunda id’si cift sayi olan personel’in tum bilgilerini listeleyen Query yaziniz

SELECT *
FROM personel6
WHERE MOD(id,2)=0;

-- 5) Personel6 tablosunda kac tane kayit oldugunu gosteren query yazin

SELECT COUNT(*)
FROM personel6;

-- Isciler tablosunda en yuksek maasi alan kisinin tum bilgilerini gosteren query yazin

SELECT *
FROM isciler
WHERE maas=(SELECT MAX(maas)
                            FROM isciler);


-- Personel6 tablosunda en dusuk maasi alan kisinin tum bilgilerini gosteren query yazin

SELECT *
FROM personel6
WHERE maas=(SELECT MIN(maas)
                            FROM personel6);
                            
-- 8) Isciler tablosunda ikinci en yuksek maasi maasi gosteren query yazin

SELECT MAX(maas)
FROM isciler
WHERE maas<>(SELECT MAX(maas)
                            FROM isciler);


-- Isciler tablosunda ikinci en yuksek maasi alan kisinin tum bilgilerini listeleyen sorgu yaziniz


SELECT *
FROM isciler 
WHERE maas=(SELECT MAX(maas)
                        FROM isciler
                        WHERE maas<>(SELECT MAX(maas)
                                                     FROM isciler););


-- fetch ve offset calissa
SELECT *
FROM personel6
ORDER BY maas DESC
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY;

-- Isciler tablosunda en yuksek maasi alan iscinin disindaki tum iscilerin, tum bilgilerini gosteren query yazin

SELECT *
FROM isciler
WHERE maas <> (SELECT MAX(maas)
                FROM isciler);
