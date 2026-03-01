USE airbnb;
GO
--importa a planilha listings
CREATE TABLE stg_listings (
    id NVARCHAR(MAX),
    host_id NVARCHAR(MAX),
    neighbourhood_cleansed NVARCHAR(MAX),
    latitude NVARCHAR(MAX),
    longitude NVARCHAR(MAX),
    property_type NVARCHAR(MAX),
    room_type NVARCHAR(MAX),
    accommodates NVARCHAR(MAX),
    bathrooms NVARCHAR(MAX),
    bedrooms NVARCHAR(MAX),
    beds NVARCHAR(MAX),
    price NVARCHAR(MAX),
    minimum_nights NVARCHAR(MAX),
    maximum_nights NVARCHAR(MAX),
    number_of_reviews NVARCHAR(MAX),
    review_scores_rating NVARCHAR(MAX),
    availability_365 NVARCHAR(MAX),
    
    
    
);


BULK INSERT stg_listings
FROM '' --aqui voce deve colocar o caminho do arquivo que voce baixou
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0d0a',
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);
GO
--calendar import
use airbnb;
go

create table stg_calendar(
listing_id NVARCHAR(MAX),
date NVARCHAR(MAX),
available CHAR(1)
);

BULK INSERT stg_calendar
FROM '' --aqui voce deve colocar o caminho do arquivo que voce baixou
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0d0a',
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);
GO
--reviwers import 

use airbnb;
go

create table stg_reviews(
listing_id NVARCHAR(MAX),
date NVARCHAR(MAX),
reviewer_id NVARCHAR(MAX)
)

BULK INSERT stg_reviews
FROM '' --aqui voce deve colocar o caminho do arquivo que voce baixou
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0d0a',
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);