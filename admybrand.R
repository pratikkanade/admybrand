install.packages("rvest")
install.packages("dplyr")

library(rvest)
library(dplyr)

get_amenities = function(hotel_link) {
  amenities_page = read_html(hotel_link)
  amenities_hotel = amenities_page %>% html_nodes(".c-12w6zty") %>% html_text() %>% paste(collapse = ",")
  return(amenities_hotel)
}

hotels = data.frame()

for(page_result in seq(from = 1, to = 3, by = 1)) {
  link = paste("https://www.oyorooms.com/hotels-in-pune/?page=",page_result,"&sort=guest_ratings&sortOrder=",sep = "")
  page = read_html(link)
  
  name = page %>% html_nodes(".listingHotelDescription__hotelName") %>% html_text()
  rating = page %>% html_nodes(".hotelRating__rating--clickable > span:nth-child(1)") %>% html_text()
  price_per_room = page %>% html_nodes(".listingPrice__finalPrice") %>% html_text() %>% gsub("\u20b9","", .)
  hotel_link = page %>% html_nodes(".listingHotelDescription") %>%
    html_attr("name") %>% gsub("HotelListCard-","https://www.oyorooms.com/", .) %>% paste( .,"/",sep = "")
  amenities = sapply(hotel_link, FUN = get_amenities, USE.NAMES = FALSE)
  
  hotels = rbind(hotels,data.frame(name,rating,price_per_room,amenities,stringsAsFactors = FALSE))
}

hotels

write.csv(hotels,"Hotels.csv")
