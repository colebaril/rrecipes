# Recipe Web Scraping

This code is to scrape recipes from the web using R and the [`rvest`](https://rvest.tidyverse.org/) package. I got this idea as I was scrolling through paragraphs of mostly useless text on recipe websites trying to find the actual recipe.

Currently supports allrecipes.com and foodnetwork.ca recipes. Adding more sites in my spare time, as this is a hobby project.

# Download

To download, run the following code in R: 

```{R, rrecipes download}
devtools::install_git("https://github.com/colebaril/rrecipes")
```

# Functions

`recipe_urls()` takes in URL(s) and converts them into a list for downstream functions. 

Ex:

```{R, recipe_urls()}
recipe_urls(c(
  "https://www.allrecipes.com/recipe/25080/mmmmm-brownies/?internalSource=hub%20recipe&referringContentType=Search",
  "https://www.foodnetwork.ca/recipe/the-pioneer-woman-bbq-pork-walking-tacos-are-the-ultimate-snack/"
))
```


