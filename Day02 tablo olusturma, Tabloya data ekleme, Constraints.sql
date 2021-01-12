CREATE TABLE ogrenciler
( 
ogrenci_id char(4), 
Isim_soyisim varchar2(50), 
not_ort number(5,2), --100,00
kayit_tarihi date -- 14-Jan-2021
);

-- Tabloya nasil data eklenir
-- insert into komutu kullanilir ve burada her field'a data tipine uygun olarak bir data eklenir

INSERT INTO ogrenciler VALUES ('1234', 'mehmet guzel',85.70,'14-Jan-2021');
-- tabloya data eklerken tablo olusturma sirasinda kullandigimiz siralalamaya da uymaliyiz
INSERT INTO ogrenciler VALUES('Ali Can',65.25,'12-Jan-2021','2345'); -- ORA-12899: value too large for column "HR"."OGRENCILER"."ID" (actual: 7, maximum: 4)

INSERT INTO ogrenciler VALUES('5632', 'Ali Can','15-Jan-2021'); -- 00947. 00000 -  "not enough values"

INSERT INTO ogrenciler VALUES('5632', 'Ali Can',null,'15-Jan-2021');

--- Eger tum field'lara deger yazmak istemiyorsak
-- o zaman deger girecegimiz field'lari database'e soylememiz lazim

INSERT INTO ogrenciler (ogrenci_id,isim_soyisim) VALUES ('6524','Veli Cem'); 
-- bu durumda deger girmedigimiz field'lar icin database null degeri atar

INSERT INTO ogrenciler VALUES('5633', 'Ali Cam',null,'15-Jan-2021');


SELECT *
FROM ogrenciler;


-- “tedarikciler” isminde bir tablo olusturun ve “tedarikci_id”, “tedarikci_ismi”, “tedarikci_adres” ve “ulasim_tarihi”   field’lari olsun. 
-- Tablo olusturduktan sonra 3 tane kayit ekleyelim.

CREATE TABLE tedarikciler (
tedarikci_id CHAR(4),
tedarikci_ismi VARCHAR2(50),
tedarikci_adres VARCHAR2(100),
ulasim_tarihi DATE
);

INSERT INTO tedarikciler VALUES ('1234','saticilar as','ankara cankaya','10-Dec-2020');
INSERT INTO tedarikciler VALUES ('1256','pazarlama as','izmir cankaya','10-Nov-2020');
INSERT INTO tedarikciler VALUES ('1534','Mehmet guzel','istanbul','10-Feb-2020');

SELECT *
FROM tedarikciler;


-- Varolan bir tablodan yeni tablo olusturma

CREATE TABLE tedarikci_isim_adres
AS SELECT tedarikci_ismi,tedarikci_adres
FROM tedarikciler;

SELECT  *
FROM tedarikci_isim_adres;

-- ogrenciler tablosundan isim_soyisim ve not_ort fieldlarini alarak yeni bir tablo olusturun

CREATE TABLE ogrenciler_notlar
AS SELECT isim_soyisim,not_ort
FROM ogrenciler;


SELECT *
FROM ogrenciler_notlar;

-- CONSTRAINTS sinirlandirmalar
-- NOT NULL : bir field ile ilgili NOT NULL tanimlamasi yapilirsa o field bos birakilamaz
-- ogrenciler 2 tablosu olusturali ve id fieldini bos birakilamaz yapalim


CREATE TABLE ogrenciler2
( 
ogrenci_id char(4) NOT NULL, 
Isim_soyisim varchar2(50), 
not_ort number(5,2), --100,00
kayit_tarihi date -- 14-Jan-2021
);

SELECT *
FROM ogrenciler2;

INSERT INTO ogrenciler2 VALUES ('1234', 'hasan yaman',75.70,'14-Jan-2020');
INSERT INTO ogrenciler2 VALUES ('1334', 'Ayse Gul',null,null);
INSERT INTO ogrenciler2 (ogrenci_id,isim_soyisim) VALUES ('6587','Hatice Sen');
INSERT INTO ogrenciler2 VALUES (null, 'veli gur',85.70,'10-Jan-2020'); -- id field'i NOT NULL oldugu icin bu kayit eklenmez
INSERT INTO ogrenciler2 (isim_soyisim,not_ort) VALUES ('Yasar Sen',95.73); -- field ismi yazilmayan field'lara SQL otomatik olarak NULL degeri atar
                                                                                                                               --  id field'i NOT NULL oldugu icin bu kayit eklenmez


-- UNIQUE constraint
-- tedarikciler2 tablosu olusturalim, tedarikci_id UNIQUE olsun


CREATE TABLE tedarikciler2 (
tedarikci_id CHAR(4) UNIQUE,
tedarikci_ismi VARCHAR2(50),
tedarikci_adres VARCHAR2(100),
ulasim_tarihi DATE
);

INSERT INTO tedarikciler2 VALUES ('1234','saticilar as','ankara cankaya','10-Dec-2020');
INSERT INTO tedarikciler2 VALUES (null,'balci as','izmir cankaya','10-May-2020');
INSERT INTO tedarikciler2 VALUES (null,'mehmet yaman','ankara','10-Apr-2020');
-- unique constraint dublication'a izin vermez ancak null degerini kabul eder ve birden fazla null degerini de kabul eder
INSERT INTO tedarikciler2 VALUES ('1234','hasan yaman','ankara','10-Apr-2020'); -- ORA-00001: unique constraint (HR.SYS_C007014) violated
INSERT INTO tedarikciler2 VALUES ('1235','saticilar as','ankara cankaya','10-Dec-2020');

SELECT *
FROM tedarikciler2;

-- bir tabloya data eklerken mutlaka constraint'lere dikkat etmeliyiz


-- PRIMARY KEY
-- primary key olusturmanin 2 yolu var
-- 1.yol : diger constraintlerde oldugu gibi Primary Key yapmak istedigimiz field in yanina PRIMARY KEY yazabiliriz
-- ogrenciler3 tablosu olusturalim ve ogrenci_id 'yi PRIMARY KEY yapalim


CREATE TABLE ogrenciler3
( 
ogrenci_id char(4) PRIMARY KEY, 
Isim_soyisim varchar2(50), 
not_ort number(5,2), --100,00
kayit_tarihi date -- 14-Jan-2021
);

SELECT *
FROM ogrenciler3;

INSERT INTO ogrenciler3 VALUES ('1234', 'hasan yaman',75.70,'14-Jan-2020');
INSERT INTO ogrenciler3 VALUES (null, 'veli yaman',85.70,'14-Jan-2020'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER3"."OGRENCI_ID")
INSERT INTO ogrenciler3 VALUES ('1234', 'Ali Can',55.70,'14-Jun-2020'); -- ORA-00001: unique constraint (HR.SYS_C007016) violated
INSERT INTO ogrenciler3 (isim_soyisim) VALUES ( 'Veli Cem'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER3"."OGRENCI_ID")
INSERT INTO ogrenciler3 (ogrenci_id) VALUES ( '5687');











