-- not yazmak icin -- kullanilir
-- datalar veya field isimleri arasinda (,) kullanilir
-- field isimleri icin kucuk harf kullanilir, birden fazla kelime ise arada _ yazariz

CREATE TABLE ogrenciler(
ogrenci_id CHAR(4),
isim_soyisim VARCHAR2(50),
not_ortalamasi number(5,2),
kayit_tarihi DATE
);

-- sql case sensitive degildir. biz kucuk harflerle yazsak bile kod calistirilinca buyuk harfe donusturur
-- bir tablo olusturulduktan sonra ayni kodu tekrar calistirmayi denerseniz  "Error report -
--ORA-00955: name is already used by an existing object
-- 00955. 00000 -  "name is already used by an existing object" hatasini alirsiniz
-- AYNI ISIMDE BIR TABLO VAR TEKRAR OLUSTURAMAZSIN