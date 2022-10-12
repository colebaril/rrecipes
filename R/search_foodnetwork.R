#' @title rrecipes
#' @description Test
#' @param search_foodnetwork
#' Searches foodnetwork.ca for recipes based on recipe_urls()
#' @return search_allrecipes
#' @import dplyr
#' @import rvest
#' @import data.table
#' @import stringr
#' @import magrittr
#' @export

search_foodnetwork <- function(query, number) {

  url <- 'https://www.foodnetwork.ca/search/' # This recently changed on the website.


  page1 <- "/?page=1"
  page2 <- "/?page=2"
  page3 <- "/?page=3"

# This section is to extract the results of the top 3 pages. It must be done in different steps
# due to how the URL links results on the page.

  # Page 1 of results
  query <- gsub(" ", "%20", query) # Change spaces in search query to `%20` to work in URL.
  searchquery1 <- paste(url, query, sep = "") # Combines base URL and query together. 
  searchquery1 <- paste(searchquery1, page1, sep = "") # Appends page number specification at the end of URL. 

  first_page1 <- rvest::read_html(searchquery1) # Extract
  url_list1 <- first_page1 %>%
    rvest::html_elements("a") %>%
    rvest::html_attr("href") %>%
    data.frame()

  # Page 2 of results
  query <- gsub(" ", "%20", query) 
  searchquery2 <- paste(url, query, sep = "")
  searchquery2 <- paste(searchquery2, page2, sep = "")

  first_page2 <- rvest::read_html(searchquery2)
  url_list2 <- first_page2 %>%
    rvest::html_elements("a") %>%
    rvest::html_attr("href") %>%
    data.frame()

  # Page 3 of results
  query <- gsub(" ", "%20", query) 
  searchquery3 <- paste(url, query, sep = "")
  searchquery3 <- paste(searchquery3, page3, sep = "")

  first_page3 <- rvest::read_html(searchquery3)
  url_list3 <- first_page3 %>%
    rvest::html_elements("a") %>%
    rvest::html_attr("href")  %>%
    data.frame()

  # ----------- Bind --------------

url_list <- rbind(url_list1, url_list2, url_list3) %>%
    as.data.frame()

names(url_list) <- "url_list"

query <- gsub("%20", "-", query, fixed = TRUE) # Change `%20` in query to `-` to work with recipe URL.

remove.list <- paste(c("tag", "article", "/search/"), collapse = '|') # Specify rows to remove where these are present.

url_list <- url_list %>% # Clean and format recipe list.
  filter(!grepl(remove.list, url_list) & grepl(query, url_list)) %>%
  unique()


  url_list <- url_list[c(1:number), ] # Limits number of recipes to user specified input.
  url_list <- url_list[!is.na(url_list)] # Exclude NAs from printing.
  url_list

}
