# rrecipes

This package contains some simple functions to scrape recipes from the web using the [`rvest`](https://rvest.tidyverse.org/) package. I got this idea as I was scrolling through paragraphs of mostly useless text on recipe websites trying to find the actual recipe. I also became frustrated when trying to copy and paste recipes to other applications and the website was less than ideal for doing so. This package is useful if you wish to extract multiple recipes from the web at once. It can also be used to convert recipe text on a website into a easily usable format (e.g., if you wish to copy and paste into another document or recipe book, as I am doing). 

Currently supports allrecipes.com and foodnetwork.ca recipes. Adding more sites in my spare time, as this is a hobby project.

# Download

To download, run the following code in R: 

```{R, rrecipes download}
devtools::install_git("https://github.com/colebaril/rrecipes")
```

# Functions

## 1 `recipe_urls()`

`recipe_urls()` takes in URL(s) and converts them into a list for downstream functions. 

For example:

```{R, recipe_urls()}
recipe_urls(c(
  "https://www.allrecipes.com/recipe/25080/mmmmm-brownies/?internalSource=hub%20recipe&referringContentType=Search",
  "https://www.foodnetwork.ca/recipe/the-pioneer-woman-bbq-pork-walking-tacos-are-the-ultimate-snack/"
))
```

## 2 `scrape()`

Use the `scrape()` function to extract recipes from the web. Internet connection required. This function prints recipes to the console and saves a file called `scraped_recipes.txt` in your working directory. 

# References 

Wickham H, François R, Henry L, Müller K (2022). _dplyr: A Grammar of Data Manipulation_. R package version 1.0.10,
<https://CRAN.R-project.org/package=dplyr>.

Wickham H (2022). _rvest: Easily Harvest (Scrape) Web Pages_. R package version 1.0.3, <https://CRAN.R-project.org/package=rvest>.

Wickham H, Girlich M (2022). _tidyr: Tidy Messy Data_. R package version 1.2.1, <https://CRAN.R-project.org/package=tidyr>.

Bache S, Wickham H (2022). _magrittr: A Forward-Pipe Operator for R_. R package version 2.0.3,
<https://CRAN.R-project.org/package=magrittr>.

Dowle M, Srinivasan A (2021). _data.table: Extension of `data.frame`_. R package version 1.14.2,
<https://CRAN.R-project.org/package=data.table>.

