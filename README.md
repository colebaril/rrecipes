# Recipe Web Scraping

This code is to scrape recipes from the web using R and the [`rvest`](https://rvest.tidyverse.org/) package. I got this idea as I was scrolling through paragraphs of mostly useless text on recipe websites trying to find the actual recipe.

Currently supports allrecipes.com and foodnetwork.ca recipes. Adding more sites in my spare time, as this is a hobby project.

# Download

To download, run the following code in R: 

```{R}
devtools::install_git("https://github.com/colebaril/rrecipes")
```

1. Download or copy code from the "Scraper" .R file. Ensure you have the necessary packages.
2. Paste URLs in the URL Input section, following the formatting. Make sure it is the URL for a single recipe. 
3. Ensure all functions are ran (scrapers, extra functions). 
4. Run the executable function. 
5. The recipes will now be saved in your working directory folder as a .txt file and printed in the console. Each recipe will be appended after the previous one. **Beware if you run the code twice, it will overwrite the original file unless you change the output name**.
