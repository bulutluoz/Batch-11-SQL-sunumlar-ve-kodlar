--“sehirler” isimli bir Table olusturun. Tabloda “alan_kodu”, “isim”, “nufus” field’lari olsun. Isim field’i bos birakilamasin.
--1.Yontemi kullanarak “alan_kodu” field’ini  “Primary Key” yapin
--3 tane kayit ekleyin

CREATE TABLE sehirler (
alan_kodu CHAR(3) PRIMARY KEY,
isim VARCHAR2(50) NOT NULL,
nufus NUMBER(8)
);

INSERT INTO sehirler VALUES (312,'Ankara',5750000);
INSERT INTO sehirler VALUES ('232','Izmir',3650000);
INSERT INTO sehirler VALUES ('212','Istanbul ',15750000);

SELECT *
FROM sehirler;
-- ogrenciler4 tablosu olusturalim ve id field'ini PK yapalim
CREATE TABLE ogrenciler4
(
id char(4),
isim varchar2(50) NOT NULL,
not_ortalamasi number(5,2),
adres varchar2(100),
kayit_tarihi date,
CONSTRAINT ogrenciler_pk PRIMARY KEY (id)
);

INSERT INTO ogrenciler4 VALUES (1235,'Veli Cem',90.6,'Ankara','15-May-2019');

SELECT *
FROM ogrenciler4;

-- ogrenciler5 tablosunu olusturun ve id,isim hanelerinin birlesimini Primary Key yapin
CREATE TABLE ogrenciler5
(
id char(4),
isim varchar2(50),
not_ortalamasi number(5,2),
adres varchar2(100),
kayit_tarihi date,
CONSTRAINT ogrenciler5_pk PRIMARY KEY (id,isim)
);

INSERT INTO ogrenciler5 VALUES (null,'Veli Cem',90.6,'Ankara','15-May-2019'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER5"."ID")
INSERT INTO ogrenciler5 VALUES (1234,null,90.6,'Ankara','15-May-2019'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER5"."ISIM")
INSERT INTO ogrenciler5 VALUES (1234,'Ali Can',90.6,'Ankara','15-May-2019'); -- PK= 1234Ali Can
INSERT INTO ogrenciler5 VALUES (1234,'Veli Cem',90.6,'Ankara','15-May-2019'); -- PK=1234Veli Cem
INSERT INTO ogrenciler5 VALUES (1234,'Oli Can',90.6,'Ankara','15-May-2019'); -- PK= 1234Oli Can
SELECT *
FROM ogrenciler5;

--“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”, “iletisim_isim” field’lari olsun 
--ve “tedarikci_id” yi Primary Key yapin.
--“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve 
--“tedarikci_id” yi Foreign Key yapin.

CREATE TABLE tedarikciler3
(
tedarikci_id char(4),
tedarikci_ismi varchar2(40),
iletisim_isim varchar2(50),
CONSTRAINT tedarikciler3_pk PRIMARY KEY (tedarikci_id)
);
INSERT INTO tedarikciler3 VALUES('1234','Pazarlama as','Mehmet bey');

CREATE TABLE urunler(
tedarikci_id char(4),
urun_id CHAR(5),
CONSTRAINT urunler_fk FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3 (tedarikci_id)
);

INSERT  INTO urunler VALUES ('1234','34567');
INSERT  INTO urunler VALUES ('1234','34586');

SELECT *
FROM urunler;

--“tedarikciler4” isimli bir Tablo olusturun. Icinde “tedarikci_id”, “tedarikci_isim”, “iletisim_isim” field’lari olsun.
--“tedarikci_id” ve “tedarikci_isim” fieldlarini birlestirerek Primary Key olusturun.
--“urunler2” isminde baska bir tablo olusturun.Icinde “tedarikci_id” ve “urun_id” fieldlari olsun. 
--“tedarikci_id” ve “urun_id” fieldlarini birlestirerek Foreign Key olusturun

CREATE TABLE tedarikciler4 (
tedarikci_id CHAR(4),
tedarikci_ismi VARCHAR2(50),
iletisim_ismi VARCHAR2(50),
CONSTRAINT tedarikciler4_pk PRIMARY KEY (tedarikci_id,tedarikci_ismi) -- char + varchar2
);

CREATE TABLE urunler2(
tedarikci_id CHAR(4),
urun_id VARCHAR2(5), -- foreign key olarak tanimladigim char+char
CONSTRAINT urunler2_fk FOREIGN KEY (tedarikci_id,urun_id) REFERENCES tedarikciler4 (tedarikci_id,tedarikci_ismi)
);

-- bir tablodaki PK ile baska bir tablodaki FK iliskililendirilecekse DATA TIPLERI uyumlu olmalidir
-- eger PK veya FK birden fazla field'in birlesiminden olusuyorsa BIRLESIMLE OLUSAN DATA TIPLERI birbiriyle uyumlu olmalidir


-- son constraint
-- CHECK yanina yazdigimiz field'in istedigimiz veya belirttigimiz sartta uymasini kontrol eder

CREATE TABLE sehirler2 (	
    alan_kodu CHAR(3 ),
	isim VARCHAR2(50),
	nufus NUMBER(8,0) CHECK (nufus>1000)
    );
    
    INSERT INTO sehirler2 VALUES ('312','Ankara',5750000); 
    INSERT INTO sehirler2 VALUES ('232','izmir',375); -- ORA-02290: check constraint (HR.SYS_C007028) violated
    INSERT INTO sehirler2 VALUES ('232','izmir',3750000);
    INSERT INTO sehirler2 VALUES ('436','Maras',null); -- 344
    
    
    SELECT *
    FROM sehirler2;
    
-- Tablodaki degerleri UPDATE etme    

UPDATE sehirler2
SET alan_kodu=344
WHERE isim='Maras';

UPDATE sehirler2
SET nufus=756000
WHERE alan_kodu='344';