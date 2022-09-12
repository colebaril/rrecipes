# Load Packages ----------------------------------------------------------------
library(tidyverse)
library(rvest)
library(stringi)
library(data.table)

# Information ------------------------------------------------------------------
# Code for scraping large batches of recipes from websites.

# To use, paste URLs in the URL Input section below, following formatting. 
# Ensure all functions are ran (scrapers and extra functions).
# Next, Run the Executable function below. A file called "scraped_recipes" will
# be generated in the directory folder.

# Notes:
# The `write.table()` function is set to append each recipe after the other each 
# time a new URL passes through the function. 
# Beware that this will overwrite the file every time if the file is not changed. 
# The 1/3 and 1/8 Unicode characters are bugged and do not export correctly in R. 
# I implemented a change such that they are readable in the output.
# Due to weird CSS formatting with a bunch of oddly placed div sections, I 
# comverted elements to a data table to format the output in a nicer way.

# Scrapers ---------------------------------------------------------------------
{ 
scrape_allrecipes <- function(URL) {
  recipe <- read_html(URL)
  
  title <- html_nodes(recipe, ".headline-wrapper") %>% 
    html_text()
  
  ingredients <- html_nodes(recipe, ".ingredients-item-name") %>% 
    html_text() %>% # This tells `rvest` that the element is text.
    trimws()
  
  directions <- html_nodes(recipe, ".instructions-section-item") %>% 
    html_text() %>%  # This tells `rvest` that the element is text.
    trimws()
  
  ingredients <- gsub("⅛", "1/8", ingredients)
  ingredients <- gsub("⅓", "1/3", ingredients)
  
  directions <- gsub(" Advertisement", "", directions)
  directions <- gsub(" {2,}", " ", directions)
  directions <- str_trim(directions, "right")
  
  print(title)
  print(ingredients)
  print(directions)
  
  write.table(c(title, ingredients, directions), 
              file = "scraped_recipes.txt", 
              append = TRUE, 
              row.names = FALSE, 
              fileEncoding = "UTF-8",
              quote = FALSE,
              col.names = FALSE)
}

scrape_foodnetwork <- function(URL) {
  recipe <- read_html(URL)
  
  title <- html_nodes(recipe, ".article-title") %>% 
    html_text()
  
  ingredientsq <- html_nodes(recipe, ".subrecipe-ingredients--quantity") %>% 
    html_text() %>% 
    as.data.table()
  
  ingredientsi <- html_nodes(recipe, ".subrecipe-ingredients--name") %>% 
    html_text() %>% 
    as.data.table()
  
  ingredients <- cbind(quantity = ingredientsq, ingredient = ingredientsi) %>% 
    unite(col = Ingredients, c(quantity.., ingredient..), sep = " ")%>% 
    pull(Ingredients)
  
  ingredients <- gsub("⅛", "1/8", ingredients)
  ingredients <- gsub("⅓", "1/3", ingredients)
  
  directionss <- html_nodes(recipe, ".recipe-step-content p") %>% 
    html_text() %>% 
    as.data.table()
  
  directionsn <- html_nodes(recipe, ".recipe-step-title") %>% 
    html_text() %>% 
    as.data.table()
  
  directions <- cbind(step = directionsn, directions = directionss) %>% 
    unite(col = Directions, c(step.., directions..), sep = " ") %>% 
    pull(Directions)
  
  print(title)
  print(ingredients)
  print(directions)
  
  write.table(c(title, ingredients, directions), 
              file = "scraped_recipes.txt", 
              append = TRUE, 
              row.names = FALSE, 
              fileEncoding = "UTF-8",
              quote = FALSE,
              col.names = FALSE)
}
}

# Extra Functions --------------------------------------------------------------
`%rin%` = function (pattern, list) {
  vapply(pattern, function (p) any(grepl(p, list)), logical(1L), USE.NAMES = FALSE)
}

# URL Input --------------------------------------------------------------------
# Input recipe URL(s) here. Currently supports allrecipes.com and foodnetwork.ca.
# Make sure the URL is for a stand-alone-recipe. 

recipe_urls <- c(
  "https://www.allrecipes.com/recipe/10033/iced-pumpkin-cookies/",
  "https://www.allrecipes.com/recipe/153245/pumpkin-spice-cupcakes/",
  "https://www.foodnetwork.ca/recipe/vegan-loaded-sweet-potatoes/",
  "https://www.foodnetwork.ca/recipe/vegan-pumpkin-waffles/"
)

# Executable -------------------------------------------------------------------
for (recipe_url in recipe_urls) {
  if ("allrecipes.*" %rin% recipe_urls){
    scrape_allrecipes(recipe_url)
  }
  if("foodnetwork.*" %rin% recipe_urls){
    scrape_foodnetwork(recipe_url)
  }
}

