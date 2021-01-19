--In;Eger istedigimiz degerleri AND or gibi mantiksal operatorlere tek tek yazmak istemiyorsak
    --IN seklinde yazariz
--In yerine EXIST()kmomutu kullanilabilir
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
--Her iki ayda da ayni id ile satilan urunlerin urun_id’lerini ve urunleri mart ayinda alanlarin isimlerini getiren bir query yaziniz..
Select urun_id,musteri_isim
From mart_satislar2
Where urun_id IN(SELECT urun_id--in le yapmakicin ayni field olmali, heriki tablolada olanlar
                               FROM  nisan_satislar--ortak yuruyebilecegim urun id
                               WHERE nisan_satislar.urun_id=mart_satislar2.urun_id);
                               ---nisan satislar. diyince fieldler geliyor nisandakiler==marttakilere esit olacak
     SELECT musteri_isim
     FROM  mart_satislar2
WHERE EXISTS(SELECT urun_id
                                FROM nisan_satislar
                                WHERE nisan_satislar.urun_id=mart_satislar2.urun_id);
-- Her iki ayda da ayni id ile satilan urunlerin urun_id’lerini ve
-- urunleri nisan ayinda alanlarin isimlerini getiren sorgu yaziniz
     SELECT urun_id, musteri_isim
     FROM  nisan_satislar
     Where EXISTS (select urun_id
                               from mart_satislar2
                                where nisan_satislar.urun_id=mart_satislar2.urun_id);
--EXISTS kullanimi IN kullanimina benzer ancak bazi farklililklar var
--1)//IN kullanicinca IN komutundan once field ismi yazmak zorundayiz ama exists de field ismi yok
--2)//IN komutundan once hangi field ismi yazildiysa subquery de ayni field ismi ile sorgu yapilabilir.
 --Exists de ilk sorgu ile subquery nin eslesmesi gibi bir sart yok
 --Exists komutu parantez icinde bir sonuc var mi? diye bakar ve varsa o sonuca gore ilk sorguyu calistiririz
 --Mart ayinda satilip nisan ayinda satilmayan urun+id ve o urunleri alan musteri isimlerini getiren sorgu yaziniz
 select musteri_isim,urun_id
 From mart_satislar2
where  Not exists(select urun_id
                                from nisan_satislar
                              where nisan_satislar.urun_id=mart_satislar2.urun_id);
   --nisan ayinda satilip mart ayinda satilmayan urun+id ve o urunleri alan musteri isimlerini getiren sorgu yaziniz
   select urun_id,musteri_isim
   From nisan_satislar
   where Not exists (select urun_id
                                    from mart_satislar2
                                    where mart_satislar2.urun_id=nisan_satislar.urun_id);
   CREATE TABLE insanlar
(
ssn char(9),
isim varchar2(50),
adres varchar2(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');
   select *
   From insanlar;
   --isim field i bos olan kayitlarin bytun bilgilerini getirin.
   select *
   from insanlar
   Where isim is null;
   select *
   from insanlar
   Where isim is null;
      select *
   from insanlar
   Where isim ='';
   --isim hanesi bos olan kayitlarda isim olarak ISIM Girilmemistir yazdiralim
   update insanlar
set isim='isim girilmemistir'
where isim is null;
   --isim fieldleri bos olmayan kayitlarin tum bilgilerini getiren sorgu yaziniz
   Select *
   from insanlar
   where isim is not null;
   CREATE TABLE insanlar3
(
ssn char(9),
isim varchar2(50),
soyisim varchar2(50),
adres varchar2(50)
);
INSERT INTO insanlar3 VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar3 VALUES(234567890, 'Veli','Cem', 'Ankara');
INSERT INTO insanlar3 VALUES(345678901, 'Mine','Bulut', 'Ankara');
INSERT INTO insanlar3 VALUES(256789012, 'Mahmut','Bulut', 'Istanbul');
INSERT INTO insanlar3 VALUES (344678901, 'Mine','Yasa', 'Ankara');
INSERT INTO insanlar3 VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');
--sorgularimizda sonucun belli bir field  e gore sirali olarak gelmesini istiyorsak
--ORDER BY komutunu kullariniz
--ankarada ki tum insanlari soy isim sirasina gore listeleyen bir sorgu yaziniz
Select*
from insanlar3
where adres='Ankara'
ORDER BY soyisim;
--iism sozluk sirasina gore siralar buyuk har onceliklidir. cunku askii sirasi once gelir
--soyadi bulut olanlari siralayin
SELECT*
FROM insanlar3
WHERE soyisim='Bulut'
ORDER BY isim ASC;
--ASC kucukten buyuge DESC buyukten kucuge dogru siralar
--istanbulda yasayan insanlarin SSN numaralarini buyukten kucuge dogru siralayiniz
Select ssn
from insanlar3
Where adres='Istanbul'
order by ssn DESC;
--tum listeyi isme gore asc soyada a gore desc
select*
from insanlar3
order by isim asc ,  soyisim desc;
CREATE TABLE calisanlar
(
calisan_id char(9),
calisan_isim varchar2(50),
calisan_dogdugu_sehir varchar2(50)
);
INSERT INTO calisanlar VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO calisanlar VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO calisanlar VALUES(345678901, 'Mine Bulut', 'Izmir');

SELECT calisan_id AS id,calisan_isim AS isim,calisan_dogdugu_sehir AS dogum_yeri
FROM calisanlar;
--tablo raporlamada || isareti ile concatinate yapabiliriz
--insanlar 3 tablosunda isim ve soyisim filedlarini bir hucrede gosterelim

SELECT ssn,isim  || ' '  || soyisim AS isim_soyisim,adres AS sehir
FROM insanlar3;

select *
FROM insanlar3;

-- AS ile yaptigimiz degisiklikler tablo yapisini ve field isimlerini degistirmez
-- sadece o sorgunun sonucu goruntulenirken gorunen basliklari degistirir

CREATE TABLE manav 
(
isim varchar2(50), 
Urun_adi varchar2(50), 
Urun_miktar number(9) 
);


INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

SELECT *
FROM manav;

-- isme gore alinan toplam urun miktarini (kg) gosteren bir sorgu yaziniz

SELECT isim,SUM (urun_miktar)
FROM manav
GROUP BY isim;

-- isme gore alinan farkli alisveris sayisini listeleyen sorgu yazin

SELECT isim,COUNT (urun_adi) AS alinan_urun_sayisi
FROM manav
GROUP BY isim;

-- urun adina gore alis veris yapan kisi sayisini veren bir sorgu yazin

SELECT urun_adi, COUNT (isim) AS musteri_sayisi
FROM manav
GROUP BY urun_adi;

-- urun'e gore satilan toplam miktari sirali olarak veren sorgu yazin

SELECT urun_adi,SUM(urun_miktar) AS toplam_miktar
FROM manav
GROUP BY urun_adi
ORDER BY toplam_miktar;

-- bir defada satilan urun miktarina gore alis veris yapan insan sayisini listeleyen sorgu yazin

SELECT urun_miktar || ' kg' AS Urun_miktari, COUNT(isim) || ' kisi' AS musteri_sayisi
FROM manav
GROUP BY urun_miktar;









