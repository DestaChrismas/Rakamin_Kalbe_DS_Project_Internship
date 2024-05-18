select * from  alldata ;

-- Berapa rata-rata umur customer jika dilihat dari marital statusnya ?
SELECT
    "Marital Status", AVG(Age) AS Rata_rata_Umur
FROM
    alldata  
group by 
"Marital Status" ;

--  Berapa rata-rata umur customer jika dilihat dari gender nya ?
SELECT
    "gender", AVG(Age) AS Rata_rata_Umur
FROM
    alldata  
group by 
"gender" ;

-- Tentukan nama store dengan total quantity terbanyak!
SELECT
    "storename",
    SUM(qty) AS TotalQuantity
FROM
    alldata  
GROUP BY
    "storename"
ORDER BY
    TotalQuantity DESC
LIMIT 3;

-- Tentukan nama produk terlaris dengan total amount terbanyak!
SELECT
    "Product Name" ,
    SUM(totalamount) AS Total_amount
FROM
    alldata  
GROUP BY
    "Product Name"
ORDER BY
    Total_amount DESC
LIMIT 3;


------ jika dataset (alldata) tidak digabung terlebih dahulu jadi kita menggunakan fungsi join 

-- Berapa rata-rata umur customer jika dilihat dari marital statusnya ?
SELECT
    "Marital Status",
    AVG(Age) AS "Rata_rata_Umur"
FROM
    datacustomers 
GROUP BY
    "Marital Status";

-- Berapa rata-rata umur customer jika dilihat dari gender nya ?
SELECT
    "gender",
    AVG(Age) AS "Rata_rata_Umur"
FROM
    datacustomers
GROUP BY
    "gender";

-- Tentukan nama store dengan total quantity terbanyak!
SELECT
    t."storeid",
    s."storename",
    SUM(t."qty") AS "Total_Quantity"
FROM
    datatransaction t
JOIN
    datastore s
    ON t."storeid" = s."storeid"
GROUP BY
    t."storeid", s."storename"
ORDER BY
    "Total_Quantity" DESC
LIMIT 3;


-- Tentukan nama produk terlaris dengan total amount terbanyak!
SELECT
    s.storename,
    SUM(t.Qty) AS TotalQuantity
FROM
    datatransaction   AS t
INNER JOIN
    datastore  AS s
    ON t.StoreID = s.StoreID
GROUP BY
    s.storename
ORDER BY
    TotalQuantity DESC
LIMIT 3;


-- Pertanyaan Tambahan yang saya buat diluar question final Project ---

-- Siapa customer dengan total pembelian (TotalAmount) terbanyak?
SELECT
    c."customerid",
    SUM(t."totalamount") AS "Total_Pembelian"
FROM
    datacustomers c
JOIN
    datatransaction t
    ON c."customerid" = t."customerid"
GROUP BY
    c."customerid"
ORDER BY
    "Total_Pembelian" DESC
LIMIT 3;

-- Apa produk dengan harga tertinggi?
SELECT
    p."productid",
    p."Product Name",
    p."price" AS "Harga_Tertinggi"
FROM
    dataproduct p
WHERE
    p."price" = (SELECT MAX("price") FROM dataproduct)
 

-- Berapa total penjualan (TotalAmount) dari setiap toko (StoreName)?
SELECT
    s."storename",
    SUM(t."totalamount") AS "Total_Penjualan"
FROM
    datatransaction t
JOIN
    datastore s
    ON t."storeid" = s."storeid"
GROUP BY
    s."storename";

-- Apa produk yang paling sering dibeli oleh customer dengan umur tertentu?
SELECT
    c."age",
    t."productid",
    p."Product Name",
    COUNT(*) AS "Jumlah_Pembelian"
FROM
    datacustomers c
JOIN
    datatransaction t
    ON c."customerid" = t."customerid"
JOIN
    dataproduct p
    ON t."productid" = p."productid"
WHERE
    c."age" = 30
GROUP BY
    c."age", t."productid", p."Product Name"
ORDER BY
    "Jumlah_Pembelian" DESC
LIMIT 3;

-- Berapa total penjualan (TotalAmount) per grup toko (GroupStore)?
SELECT
    s."groupstore",
    SUM(t."totalamount") AS "Total_Penjualan"
FROM
    datatransaction t
JOIN
    datastore s
    ON t."storeid" = s."storeid"
GROUP BY
    s."groupstore";