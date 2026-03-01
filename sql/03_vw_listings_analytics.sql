CREATE OR ALTER VIEW vw_listings_analytics AS
WITH reviews_por_listing AS (
    SELECT 
        listing_id,
        COUNT(*) AS total_reviews,
        MAX(date) AS ultima_review
    FROM reviews
    GROUP BY listing_id
),
disponibilidade AS (
    SELECT 
        id,
        AVG(CAST(available AS FLOAT)) * 100 AS taxa_disponibilidade
    FROM calendar
    GROUP BY id
)
SELECT 
    l.id,
    l.neighbourhood_cleansed,
    l.property_type,
    l.room_type,
    l.price,
    l.review_scores_rating,
    r.total_reviews,
    r.ultima_review,
    d.taxa_disponibilidade
FROM listings l
INNER JOIN reviews_por_listing r
    ON l.id = r.listing_id
LEFT JOIN disponibilidade d
    ON l.id = d.id;