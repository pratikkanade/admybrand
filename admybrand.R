install.packages("rvest")
install.packages("dplyr")

library(rvest)
library(dplyr)

hotels = data.frame()

for(page_result in seq(from = 1, to = 3, by = 1)) {
  link = paste("https://www.oyorooms.com/hotels-in-pune/?page=",page_result,sep = "")
  page = read_html(link)
  
  name = page %>% html_nodes(".listingHotelDescription__hotelName") %>% html_text()
  rating = page %>% html_nodes(".hotelRating__rating--clickable > span:nth-child(1)") %>% html_text()
  price_per_room = page %>% html_nodes(".listingPrice__finalPrice") %>% html_text() %>% gsub("\u20b9","", .)
  
  hotels = rbind(hotels,data.frame(name,rating,price_per_room,stringsAsFactors = FALSE))
  }
hotels
