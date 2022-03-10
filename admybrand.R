install.packages("rvest")
install.packages("dplyr")

library(rvest)
library(dplyr)

link = "https://www.oyorooms.com/search/?checkin=11%2F03%2F2022&checkout=12%2F03%2F2022&city=pune&guests=1&latitude=&location=pune&longitude=&roomConfig=1&roomConfig%5B%5D=1&rooms=1&searchType=&tag="
page = read_html(link)

name = page %>% html_nodes(".listingHotelDescription__hotelName") %>% html_text()
name
