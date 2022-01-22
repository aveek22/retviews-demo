CREATE TABLE dim_title(
    title_key   serial      primary key ,
    title       varchar(255),
    created_on  timestamp,
    modified_on timestamp
);

CREATE TABLE dim_brand(
    brand_key   serial      primary key ,
    brand_name  varchar(255),
    created_on  timestamp,
    modified_on timestamp
);

CREATE TABLE dim_material(
    material_key    serial  primary key ,
    material_name   varchar(255),
    created_on  timestamp,
    modified_on timestamp
);

CREATE TABLE dim_color(
    color_key   serial      primary key ,
    color       varchar(50),
    created_on  timestamp,
    modified_on timestamp
);

CREATE TABLE dim_date(
    date_key    int         primary key ,
    iso_date    date,
    year        int,
    month       int,
    day         int
);

CREATE TABLE fact_price_listing(
    price_listing_key   serial  primary key ,
    title_key           int,
    brand_key           int,
    material_key        int,
    color_key           int,
    date_key            int,
    price               decimal(6,2),
    is_active           boolean,
    created_on          timestamp,
    modified_on         timestamp,
    CONSTRAINT fk_price_title       FOREIGN KEY (title_key)     REFERENCES dim_title(title_key),
    CONSTRAINT fk_price_brand       FOREIGN KEY (brand_key)     REFERENCES dim_brand(brand_key),
    CONSTRAINT fk_price_material    FOREIGN KEY (material_key)  REFERENCES dim_material(material_key),
    CONSTRAINT fk_price_color       FOREIGN KEY (color_key)     REFERENCES dim_color(color_key),
    CONSTRAINT fk_price_date        FOREIGN KEY (date_key)      REFERENCES dim_date(date_key)
);

ALTER TABLE dim_title ALTER created_on SET DEFAULT now();
ALTER TABLE dim_title ALTER modified_on SET DEFAULT now();

ALTER TABLE dim_brand ALTER created_on SET DEFAULT now();
ALTER TABLE dim_brand ALTER modified_on SET DEFAULT now();

ALTER TABLE dim_material ALTER created_on SET DEFAULT now();
ALTER TABLE dim_material ALTER modified_on SET DEFAULT now();

ALTER TABLE dim_color ALTER created_on SET DEFAULT now();
ALTER TABLE dim_color ALTER modified_on SET DEFAULT now();

ALTER TABLE dim_title ALTER created_on SET DEFAULT now();
ALTER TABLE dim_title ALTER modified_on SET DEFAULT now();

ALTER TABLE fact_price_listing ALTER created_on SET DEFAULT now();
ALTER TABLE fact_price_listing ALTER modified_on SET DEFAULT now();
ALTER TABLE fact_price_listing ALTER is_active SET DEFAULT True;

CREATE OR REPLACE FUNCTION udf_get_date_primary_key(ts timestamp) RETURNS integer AS $$
   BEGIN
       RETURN 10000 * EXTRACT(YEAR FROM ts) +
              100 * EXTRACT(MONTH FROM ts) +
              EXTRACT(DAY FROM ts);
   END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE public.usp_populate_dim_date()
LANGUAGE plpgsql
AS $$
BEGIN

    -- This SP will populate the Date Dimension table with records for 2021.


    WITH date1 AS (
        SELECT generate_series('2021-01-01'::timestamp,
                                '2021-12-31'::timestamp,
                                '1 day') AS ts
        ),date2 AS (
        SELECT udf_get_date_primary_key(ts) AS date_key,
            CAST(to_char(ts, 'YYYY-MM-DD') AS DATE) AS iso_date,
            EXTRACT(YEAR FROM ts) AS year,
            EXTRACT(MONTH FROM ts) AS month,
            EXTRACT(DAY FROM ts) AS day
        FROM date1
        )

        INSERT INTO dim_date
        SELECT * FROM date2;

END;
$$;

call public.usp_populate_dim_date();