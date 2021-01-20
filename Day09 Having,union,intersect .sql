CREATE TABLE personel4 
(
id number(9), 
isim varchar2(50), 
sehir varchar2(50), 
maas number(20), 
sirket varchar2(20)
);
INSERT INTO personel4 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel4 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel4 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
INSERT INTO personel4 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel4 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel4 VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel4 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');
SELECT *
FROM personel4;
-- sirketlerin toplam maaslarini gosteren bir sorgu yazin
SELECT sirket, SUM(maas) AS toplam_maas
FROM personel4
GROUP BY sirket;
-- Eger sirketin odedigi toplam maas 10000'den fazla ise 
-- sirketlerin isimlerini ve toplam maaslarini 
SELECT sirket, SUM(maas) AS toplam_maas
FROM personel4
GROUP BY sirket
HAVING SUM(maas)>10000;
-- sirket isimleri ve  calistirdiklari personel sayisini listeleyen sorgu yazin

SELECT sirket,COUNT(isim) AS personel_sayisi
FROM personel4
GROUP BY sirket;

--calistirdigi personel sayisi 1 den fazla olan sirket isimlerini ve personel sayilarini listeleyin

SELECT sirket,COUNT(isim) AS personel_sayisi
FROM personel4
GROUP BY sirket
HAVING COUNT(isim) >1;

-- Ayni isimdeki personelin aldigi max maasi listeleyin

SELECT isim,MAX(maas) AS maximum_maas
FROM personel4
GROUP BY isim;


DELETE FROM personel4;

-- ayni isimdeki kisilerden maximum maasi alan kisinin maasi 5000'den cok ise
-- isim ve max maasi listeleyin

SELECT isim,MAX(maas) AS maximum_maas
FROM personel4
GROUP BY isim
HAVING MAX(maas)>5000;

-- HAVING komutu AGGREGATE FONKSIYONLAR'i filtrelemek icin kullanilir
-- (normal sorgularda WHERE komutunun yaptigi islev)


-- UNION 
-- Eger tek sorguda birlestiremeyecegim iki sorgunun sonucunu ayni tabloda 
-- gormek istersek UNION islemi kullanilir
-- BU durumda dikkat etmemiz gereken konu iki sorguda da field sayisi ve 
-- alt alta gelecek field data tiplerinin ayni olmasidir
-- 1) Maasi 4000’den cok olan isci isimlerini ve 
--     5000 liradan fazla maas alinan sehirleri  gosteren sorguyu yaziniz

SELECT isim AS isim_veya_sehir,maas
FROM personel4
WHERE maas>4000

UNION

SELECT sehir,maas
FROM personel4
WHERE maas>5000;

--  Ismi Mehmet Ozturk olan kisilerin isim ve maaslarini ve
-- Istanbulda calisanlarin sehir adi ve maaslarini coktan aza sirali olarak listeleyin

SELECT isim AS isim_veya_sehir ,maas
FROM personel4
WHERE isim='Mehmet Ozturk'

UNION

SELECT sehir,maas
FROM personel4
WHERE sehir='Istanbul'
ORDER BY maas DESC;

-- union ile yaptigimiz sorguyu siralamak istersek
-- 2.sorgudan sonra ORDER BY yazabiliriz

CREATE TABLE personel_bilgi 
(
id number(9), 
tel char(10) UNIQUE , 
cocuk_sayisi number(2)
); 


INSERT INTO personel_bilgi VALUES(123456789, '5302345678' , 5);
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3); 
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

SELECT *
FROM personel_bilgi;


-- id’si 123456789 olan personelin  Personel4 tablosundan sehir ve maasini, 
-- personel_bilgi tablosundan da tel ve cocuk sayisini yazdirin  

SELECT sehir AS tel_num_veya_sehir,maas AS cocuk_sayisi_veya_maas
FROM personel4
WHERE id=123456789

UNION 

SELECT tel,cocuk_sayisi
FROM personel_bilgi
WHERE id=123456789;

-- UNION ALL
-- personel4 tablosunda ankarada vcalisan personelin isim ve maaslarini listeleyin

SELECT isim,maas
FROM personel4
WHERE sehir='Ankara'

UNION

SELECT isim,maas
FROM personel4
WHERE sehir='Ankara';

-- union islemi kumelerdeki birlesme islemi veya Java'daki SET gibidir, 
-- varolan bir eleman tekrar eklenmeye calisilirsa eklemez

SELECT isim,maas
FROM personel4
WHERE sehir='Ankara'

UNION ALL

SELECT isim,maas
FROM personel4
WHERE sehir='Ankara';

-- UNION ALL komutu ise tekrara bakmaksizin iki sorgudan gelen tum sonuclari listeler
-- UNION ALL komutunda da iki sorgunun sonucunun esit sayida field'a ve data 
-- tiplerine sahip olmasi gereklidir


-- Maasi 4000'den cok olanlarin isimlerini ve maaslarini listeleyin

SELECT isim,maas
FROM personel4
WHERE maas>4000;

-- ismi Mehmet Ozturk olanlarin isim ve maaslarini listeleyin

SELECT isim,maas
FROM personel4
WHERE isim='Mehmet Ozturk';


-- iki sorguyu INTERSECT ile birlestirelim

SELECT isim,maas
FROM personel4
WHERE maas>4000

INTERSECT

SELECT isim,maas
FROM personel4
WHERE isim='Mehmet Ozturk';


-- bu islemi AND ile yapabilirdik
-- INTERSECT islemi mantik olarak AND komutu ile aynidir
-- ancak INTERSECT ile cozulen her soru AND ile cozulemez


-- personel3 tablosunda maasi maasi 3000'den az olanlarin sirketlerini siralayin
-- ile personel 4 tablosunda 5000'den fazla maas alanlarin sirketler
-- ve personel3 tablosunda istanbul'da personeli olan sirketlerin kesisimini bulunuz
SELECT sirket
FROM personel3
WHERE maas<3000

INTERSECT

SELECT sirket
FROM personel4
WHERE maas>5000

INTERSECT

SELECT sirket
FROM personel3
WHERE sehir='Istanbul';


-- personel4 tablosunda maasi 4000'den cok olanlarin maaslari ile 
-- istanbulda calisan kisilerin isimlerini kesistirin

SELECT sirket
FROM personel4
WHERE maas>4000

INTERSECT

SELECT isim
FROM personel4
WHERE sehir='Istanbul';

-- INTERSECT yapilacak sorgu sonuclarinin data tipleri uyumlu olmalidir


-- MINUS : fark islemi demektir
-- 1.sorguda olup 2.sorguda olmayan sonuclari listeler

-- 5000’den az maas alip Honda’da calismayanlarin isimlerini yazdirin 

SELECT isim
FROM personel4
WHERE maas<5000

MINUS

SELECT isim
FROM personel4
WHERE sirket='Toyota';

-- Ismi Mehmet Ozturk olup Istanbul’da calismayanlarin id'lerini  listeleyin

SELECT id
FROM personel4
WHERE isim='Mehmet Ozturk' AND sehir != 'Ankara';

SELECT id
FROM personel4
WHERE isim='Mehmet Ozturk'

MINUS

SELECT id
FROM personel4
WHERE sehir = 'Ankara';

-- personel3 tablosunda istanbulda personeli olan sirket listesinde olup, 
-- personel4 tablosunda personeline 5000'den fazla maas veren sirketler listesinde 
-- olmayanlari bulun


SELECT sirket
FROM personel3
WHERE sehir='Istanbul'

MINUS 

SELECT sirket
FROM personel4
WHERE maas>5000;


-- personel3 tablosunda HOnda'nin bayisi olan sehirler listesinde olup
-- personel4 tablosunda Veli sahin isimli personel calisan sehirler listesinde olmayan 
-- sehirleri bulunuz

SELECT sehir
FROM personel3
WHERE sirket='Honda'

MINUS

SELECT sehir
FROM personel4
WHERE isim='Veli Sahin';



