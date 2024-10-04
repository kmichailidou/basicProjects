library(tidyverse)
library(gtExtras)
library(RColorBrewer)
library(gapminder)

plot <- gapminder %>% 
  rename(Country = country) %>% 
  filter(continent == "Europe") %>% 
  group_by(Country) %>% 
  summarise(`GDP pc` = round(mean(gdpPercap)),
            `Pop size` = round(mean(pop)),
            `Life Expectancy` = list(lifeExp)) %>% 
  arrange(-`GDP pc`) %>% 
  head(10) %>% 
  gt() %>% 
  gt_plt_dist(`Life Expectancy`) %>% 
  tab_header(title = "The GDP and Pop Size of Europe") %>% 
  cols_align(align = "left")

plot

# gt_plt_dist(`Life Expectancy`) -> 
# gives us the distribution


plot %>% 
  gt_theme_538()

plot %>% 
  gt_theme_dark()

plot %>% 
  gt_theme_espn()

plot %>% 
  gt_theme_excel()

plot %>% 
  gt_theme_nytimes()

plot %>% 
  gt_theme_pff()

# assigned for the rest of the block
plot <- plot %>% gt_theme_pff()


plot %>% 
  gt_highlight_rows(rows = Country %in% c("Iceland",
                                          "Belgium"),
                    fill = "lightpink")

plot %>% 
  gt_plt_bar_pct(`GDP pc`,
                 fill = "steelblue",
                 height = 15,
                 width = 100)


plot %>% 
  gt_color_rows(column = `Pop size`,
                palette = "Pastel1") %>% 
  gt_plt_bar_pct(`GDP pc`,
                 fill = "steelblue",
                 height = 15,
                 width = 120)


