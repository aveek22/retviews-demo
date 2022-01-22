SELECT
       db.brand_name
FROM fact_price_listing fpl
INNER JOIN dim_brand db
    ON fpl.brand_key = db.brand_key
INNER JOIN dim_title dt
    ON fpl.title_key = dt.title_key
WHERE 1=1
AND fpl.is_active = True
AND dt.title = 'Baggy Trousers';



SELECT
       dc.color,
       MAX(fpl.price) highest_price
FROM fact_price_listing fpl
INNER JOIN dim_brand db
    ON fpl.brand_key = db.brand_key
INNER JOIN dim_title dt
    ON fpl.title_key = dt.title_key
INNER JOIN dim_color dc
    ON dc.color_key = fpl.color_key
WHERE 1=1
AND fpl.is_active = True
AND dt.title = 'Sleeveless Shirt'
AND db.brand_name = 'Zara'
GROUP BY
    dc.color;

SELECT * FROM dim_date;

INSERT INTO dim_title (title) VALUES ('Baggy Trousers');
INSERT INTO dim_title (title) VALUES ('Sleeveless Shirt');
INSERT INTO dim_title (title) VALUES ('Coats');
INSERT INTO dim_title (title) VALUES ('Sweaters');
INSERT INTO dim_title (title) VALUES ('Dresses');

INSERT INTO dim_brand (brand_name) VALUES ('Zara');
INSERT INTO dim_brand (brand_name) VALUES ('Uniclo');
INSERT INTO dim_brand (brand_name) VALUES ('Mango');

INSERT INTO dim_material (material_name) VALUES ('Cotton');
INSERT INTO dim_material (material_name) VALUES ('Wool');
INSERT INTO dim_material (material_name) VALUES ('Synthetic');

INSERT INTO dim_color (color) VALUES ('Black');
INSERT INTO dim_color (color) VALUES ('White');
INSERT INTO dim_color (color) VALUES ('Grey');
INSERT INTO dim_color (color) VALUES ('Yellow');

SELECT * FROM fact_price_listing;

INSERT INTO fact_price_listing(title_key,brand_key,material_key,color_key,date_key,price)
VALUES(1,1,1,2,20210101,60);
INSERT INTO fact_price_listing(title_key,brand_key,material_key,color_key,date_key,price)
VALUES(1,2,1,2,20210101,50);
INSERT INTO fact_price_listing(title_key,brand_key,material_key,color_key,date_key,price)
VALUES(3,2,2,3,20210101,90);



INSERT INTO fact_price_listing(title_key,brand_key,material_key,color_key,date_key,price)
VALUES(2,1,1,1,20210101,25);
INSERT INTO fact_price_listing(title_key,brand_key,material_key,color_key,date_key,price)
VALUES(2,1,1,1,20210101,30);
INSERT INTO fact_price_listing(title_key,brand_key,material_key,color_key,date_key,price)
VALUES(2,1,1,1,20210101,35);

INSERT INTO fact_price_listing(title_key,brand_key,material_key,color_key,date_key,price)
VALUES(2,1,1,2,20210101,23);
INSERT INTO fact_price_listing(title_key,brand_key,material_key,color_key,date_key,price)
VALUES(2,1,1,2,20210101,27);
INSERT INTO fact_price_listing(title_key,brand_key,material_key,color_key,date_key,price)
VALUES(2,1,1,2,20210101,33);

INSERT INTO fact_price_listing(title_key,brand_key,material_key,color_key,date_key,price)
VALUES(2,1,1,3,20210101,16);
INSERT INTO fact_price_listing(title_key,brand_key,material_key,color_key,date_key,price)
VALUES(2,1,1,3,20210101,26);
INSERT INTO fact_price_listing(title_key,brand_key,material_key,color_key,date_key,price)
VALUES(2,1,1,3,20210101,36);
INSERT INTO fact_price_listing(title_key,brand_key,material_key,color_key,date_key,price)
VALUES(2,1,1,3,20210101,46);

INSERT INTO fact_price_listing(title_key,brand_key,material_key,color_key,date_key,price)
VALUES(2,2,1,3,20210101,19);