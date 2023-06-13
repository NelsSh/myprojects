New York Airbnb Analysis
================

``` r
#Viewing and cleaning data after importing it into RStudio
library(readxl)
```

    ## Warning: package 'readxl' was built under R version 4.1.3

``` r
airbnb <- read_excel("~/myprojects_analysis/airbnb.xlsx")
View(airbnb)
data_unique=airbnb[!duplicated(airbnb),]
dt=na.omit(data_unique)
head(dt)
```

    ## # A tibble: 6 x 13
    ##   `Host Id` `Host Since`        Name                     Borough `Property Type`
    ##       <dbl> <dttm>              <chr>                    <chr>   <chr>          
    ## 1       500 2008-06-26 00:00:00 Trendy Times Square Loft Manhat~ Apartment      
    ## 2      1039 2008-07-25 00:00:00 Big Greenpoint 1BD w/ S~ Brookl~ Apartment      
    ## 3      1783 2008-08-12 00:00:00 Amazing Also             Manhat~ Apartment      
    ## 4      2078 2008-08-15 00:00:00 Colorful, quiet, & near~ Brookl~ Apartment      
    ## 5      2339 2008-08-20 00:00:00 East Village Cocoon: 2 ~ Manhat~ Apartment      
    ## 6      2339 2008-08-20 00:00:00 Lovely 2 Bedroom East V~ Manhat~ Apartment      
    ## # i 8 more variables: `Review Scores Rating (bin)` <dbl>, `Room Type` <chr>,
    ## #   Zipcode <dbl>, Beds <dbl>, `Number of Records` <dbl>,
    ## #   `Number Of Reviews` <dbl>, Price <dbl>, `Review Scores Rating` <dbl>

``` r
#Quick Descriptive Statistics on Pricing and Rating
summary(dt$Price)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    10.0    85.0   125.0   154.8   190.0 10000.0

``` r
summary(dt$`Review Scores Rating`)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   20.00   89.00   94.00   91.99  100.00  100.00

From the summary call, we see that the median price across all boroughs
is \$125.80. The minimum is \$10, and the maximum is \$10,000. Looking
at the summary for Review Scores, the mean rating is 91.99, across all
boroughs and property types. Let’s take a look at the \$10 residence and
the \$10,000 dollar residence.

``` r
#Checking the airbnb with minimum pricing
dt[dt$Price=="10", ]
```

    ## # A tibble: 1 x 13
    ##   `Host Id` `Host Since`        Name       Borough `Property Type`
    ##       <dbl> <dttm>              <chr>      <chr>   <chr>          
    ## 1  14381346 2014-04-16 00:00:00 Small sofa Bronx   House          
    ## # i 8 more variables: `Review Scores Rating (bin)` <dbl>, `Room Type` <chr>,
    ## #   Zipcode <dbl>, Beds <dbl>, `Number of Records` <dbl>,
    ## #   `Number Of Reviews` <dbl>, Price <dbl>, `Review Scores Rating` <dbl>

The place charging \$10 is actually a house in Bronx called “Small
Sofa”, offering a shared one room. It has been available for booking
since 2014 and has a rating of 100.

``` r
#Checking the airbnb with maximum pricing.
dt[dt$Price=="10000", ]
```

    ## # A tibble: 1 x 13
    ##   `Host Id` `Host Since`        Name                     Borough `Property Type`
    ##       <dbl> <dttm>              <chr>                    <chr>   <chr>          
    ## 1  23248648 2014-11-02 00:00:00 NO LONGER BOOKING RESER~ Manhat~ Apartment      
    ## # i 8 more variables: `Review Scores Rating (bin)` <dbl>, `Room Type` <chr>,
    ## #   Zipcode <dbl>, Beds <dbl>, `Number of Records` <dbl>,
    ## #   `Number Of Reviews` <dbl>, Price <dbl>, `Review Scores Rating` <dbl>

The place charging \$10,000 is an entire apartment in Manhattan offering
two beds with a review score rating of 95. It has been on the market
since 2014, although it looks like it is no longer accepting
reservations.

``` r
#Which borough contains the most locations for reservation?
library(ggplot2)
```

    ## Warning: package 'ggplot2' was built under R version 4.1.3

``` r
ggplot(dt, aes(x=Borough))+geom_bar(stat="count",fill="orange")+labs(title="Which borough contains the most locations for reservation?", y="Count")
```

![](Airbnb_Analysis_cp_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->
Manhattan contains the most places for reservation, followed by
Brooklyn, Queens, Bronx and Staten Island.

``` r
#What are the property types in each borough?
ggplot(dt, aes(y=dt$`Property Type`))+geom_bar(stat="count",fill="turquoise")+labs(title="Property Types in Each Borough", y= "Property Type", x="Count")+facet_wrap(~Borough)
```

    ## Warning: Use of `` dt$`Property Type` `` is discouraged.
    ## i Use `Property Type` instead.

![](Airbnb_Analysis_cp_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

The property type most available across all boroughs are apartments,
followed by houses,then lofts. It is interesting how apartments are the
most common. This may be due to changes in social culture favoring
temporal living habits.

``` r
#What are the number of beds in each borough?
ggplot(dt, aes(x= Beds))+geom_bar(stat="count", fill="turquoise")+labs(title="Number of Beds Available in Each Borough", y= "Count", x="Beds")+facet_wrap(~Borough)
```

![](Airbnb_Analysis_cp_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->
One bed spaces are most common in each borough as well, perhaps
indicating the societal changes favoring temporal habits; or simply
people wanting to rent their guest rooms for passive income.

``` r
#What are the places sporting 16 beds?
dt[dt$Beds=="16", ]
```

    ## # A tibble: 10 x 13
    ##    `Host Id` `Host Since`        Name                    Borough `Property Type`
    ##        <dbl> <dttm>              <chr>                   <chr>   <chr>          
    ##  1   1420300 2011-11-18 00:00:00 5 Bathrooms 8 Bedrooms~ Brookl~ House          
    ##  2   1420300 2011-11-18 00:00:00 8 Bedrooms 5 Baths 20 ~ Brookl~ House          
    ##  3   1495196 2011-12-11 00:00:00 HOT SPOT FOR 20 AND 30~ Brookl~ House          
    ##  4   2472305 2012-05-26 00:00:00 Artist's Ditmas Pk 5 b~ Brookl~ House          
    ##  5   2675644 2012-06-18 00:00:00 Famous Victorian Mansi~ Staten~ House          
    ##  6  16903170 2014-06-17 00:00:00 Super Luxury Townhouse~ Manhat~ House          
    ##  7  20270339 2014-08-19 00:00:00 JEWEL OF FRESH MEADOWS~ Queens  House          
    ##  8  26900762 2015-01-29 00:00:00 Large Groups/7BR/4BA H~ Brookl~ House          
    ##  9  38204255 2015-07-12 00:00:00 Beautiful Midtown Loft  Manhat~ Apartment      
    ## 10  42037915 2015-08-20 00:00:00 A home; a quick walk t~ Brookl~ House          
    ## # i 8 more variables: `Review Scores Rating (bin)` <dbl>, `Room Type` <chr>,
    ## #   Zipcode <dbl>, Beds <dbl>, `Number of Records` <dbl>,
    ## #   `Number Of Reviews` <dbl>, Price <dbl>, `Review Scores Rating` <dbl>

On the other hand, 16 bed residences are commonly entire houses in
Brooklyn, echoing a form of duration and stability compared to the one
bed apartments.

``` r
#Average Pricing in each of the boroughs
library(dplyr)
```

    ## Warning: package 'dplyr' was built under R version 4.1.3

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
dt %>%
  group_by(Borough) %>%
  summarise(median_price = median(Price)) %>%
  ggplot(aes(x = factor(Borough), y = median_price)) +
  geom_col(fill="orange") +
  labs(x = "Borough", y = "Median Price", title = "Median Price Based on Borough")
```

![](Airbnb_Analysis_cp_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->
Median prices are higher in Manhattan, followed by Brooklyn, Queens,
Staten Island, and Bronx. Since median is less affected by extreme
values(like the \$10,000 Airbnb), it is best to utilize median to
describe the central tendency of prices.

Conclusion:

Based on the analysis,it is evident that New York Airbnb median pricing
depends on the borough. Locations in Manhattan and Brooklyn are most
expensive. Furthermore, one bed apartments are most common in the
market, across all boroughs. While this may be idle for solo travelers
or couples, it may not be best for large families. Thus in this
situation, Brooklyn may be best for accommodation.
