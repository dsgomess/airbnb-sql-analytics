USE airbnb;
GO

CREATE TABLE listings (
    id BIGINT,
    host_id BIGINT,
    neighbourhood_cleansed NVARCHAR(255),
    latitude FLOAT,
    longitude FLOAT,
    property_type NVARCHAR(100),
    room_type NVARCHAR(100),
    accommodates INT,
    bathrooms FLOAT,
    bedrooms INT,
    beds INT,
    price DECIMAL(10,2),
    minimum_nights INT,
    maximum_nights INT,
    number_of_reviews INT,
    review_scores_rating FLOAT,
    availability_365 BIGINT
);
GO

INSERT INTO listings
SELECT
    TRY_CAST(REPLACE(id, '"', '') AS BIGINT),
    TRY_CAST(REPLACE(host_id, '"', '') AS BIGINT),
    neighbourhood_cleansed,
    TRY_CAST(latitude AS FLOAT),
    TRY_CAST(longitude AS FLOAT),
    property_type,
    room_type,
    TRY_CAST(accommodates AS INT),
    TRY_CAST(bathrooms AS FLOAT),
    TRY_CAST(bedrooms AS FLOAT),
    TRY_CAST(beds AS FLOAT),
    TRY_CAST(price AS DECIMAL(10,2)),
    TRY_CAST(minimum_nights AS INT),
    TRY_CAST(maximum_nights AS INT),
    TRY_CAST(number_of_reviews AS INT),
    TRY_CAST(review_scores_rating AS FLOAT),
    TRY_CAST(
    LTRIM(RTRIM(
        REPLACE(
            REPLACE(availability_365, CHAR(13), ''),
        CHAR(10), '')
    ))
AS FLOAT)
FROM stg_listings;

-- calendar create table

USE airbnb;
GO

CREATE TABLE calendar (
    id BIGINT,
    date DATE,
    available BIT
);
USE airbnb;
GO

INSERT INTO calendar
SELECT
    TRY_CAST(listing_id AS BIGINT),
    TRY_CAST(date AS DATE),
    CASE 
        WHEN available = 't' THEN 1
        WHEN available = 'f' THEN 0
        ELSE NULL
    END
FROM stg_calendar;

-- review create table
USE airbnb;
GO

CREATE TABLE reviews (
    listing_id BIGINT,
    date DATE,
    reviewer_id BIGINT
);
GO

INSERT INTO reviews
SELECT
    TRY_CAST(listing_id AS BIGINT),
    TRY_CAST(date AS DATE),
    TRY_CAST(reviewer_id AS BIGINT)
FROM stg_reviews;
GO
