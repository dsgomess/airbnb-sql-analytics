USE airbnb;
GO

CREATE OR ALTER VIEW vw_listings_dashboard AS
WITH reviews_agg AS (
    SELECT
        listing_id,
        COUNT(*) AS total_reviews,
        MAX(date) AS last_review_date
    FROM reviews
    GROUP BY listing_id
),
calendar_agg AS (
    SELECT
        id,
        COUNT(*) AS total_days,
        SUM(CASE WHEN available = 1 THEN 1 ELSE 0 END) AS available_days
    FROM calendar
    GROUP BY id
)
SELECT
    l.id,
    l.neighbourhood_cleansed AS bairro,
    l.property_type,
    l.room_type,
    l.price,
    l.review_scores_rating,
    
    r.total_reviews,
    r.last_review_date,
    
    c.total_days,
    c.available_days,
    
    CAST(
        (c.available_days * 100.0) / NULLIF(c.total_days,0)
        AS DECIMAL(5,2)
    ) AS availability_rate_percent

FROM listings l
LEFT JOIN reviews_agg r ON l.id = r.listing_id
LEFT JOIN calendar_agg c ON l.id = c.id;
GO