# SQLTrigger

# Stok Yönetim Sistemi

Bu basit SQL ve tetikleyiciler kullanarak stok yönetim sistemi örneğidir. Aşağıdaki işlevselliği sağlar:

1. **Veritabanı Şeması Oluşturma**: "STOCK" şeması oluşturulur.
2. **Stok Tablosu Oluşturma**: "STOCK" tablosu, stok öğelerinin bilgilerini depolar.
3. **Stok Hareketi Tablosu Oluşturma**: "STOCKMOVEMENT" tablosu, stok hareketlerini kaydeder.
4. **Stok Hareketi Tetikleyicisi Oluşturma**: "STOCKMOVEMENT" tablosuna ekleme yapıldığında, ilgili stok öğesinin toplam miktarını güncelleyen bir tetikleyici oluşturulur.
5. **Fiyat Hareketi Tablosu Oluşturma**: "PRICEMOVEMENT" tablosu, stok birim fiyatlarının değişimlerini kaydeder.
6. **Fiyat Hareketi Tetikleyicisi Oluşturma**: "STOCK" tablosunda bir birim fiyat güncellendiğinde, eski ve yeni birim fiyatları arasındaki değişikliği "PRICEMOVEMENT" tablosuna kaydeden bir tetikleyici oluşturulur.

## Nasıl Kullanılır

1. **Veritabanı Kurulumu**: SQL betiklerini kullanarak veritabanı şemasını oluşturun.
2. **Tetikleyicileri Oluşturma**: Tetikleyicileri veritabanına ekleyin.
3. **Örnek Veri Ekleyin**: Stok tablosuna örnek stok öğeleri ekleyin ve stok hareketleri gerçekleştirin.
4. **Stok Hareketlerini İzleyin**: Stok hareketlerini ve fiyat değişimlerini "STOCKMOVEMENT" ve "PRICEMOVEMENT" tablolarından izleyin.

## Örnek Kullanım

```sql
-- Örnek stok ve stok hareketi ekleme
INSERT INTO Stock.Stock (StockName, TotalQuantity, UnitPrice) VALUES
    ('Object X', 500, 50),
    ('Object Y', 1000, 25),
    ('Object Z', 100, 80);

-- Örnek stok hareketi ekleme
INSERT INTO Stock.StockMovement (StockID, MovementID, Quantity, Price, MovementDate) VALUES
    (1, 1, 10, 50, GETDATE()),
    (2, 2, 10, 50, GETDATE());

-- Örnek birim fiyat güncelleme ve fiyat hareketi kontrolü
UPDATE Stock.Stock SET UnitPrice = 30 WHERE StockID = 2;
SELECT * FROM Stock.PriceMovement;
