library(plotly)
library(crosstalk)
library(zoo)
library(htmltools)
frame <- read.csv("plotData\\casesUTF-8.csv", fileEncoding = "UTF-8")
avgFrame <- frame %>% group_by(powiat_miasto) %>%
  mutate(test = rollmean(liczba_przypadkow, 7, na.pad = T))

f <- highlight_key(avgFrame)

bscols(widths = 20,
       filter_select(id = "powiat_miasto", label = "Powiat", f, ~ powiat_miasto),
       plot_ly(data = f, x = avgFrame$stan_rekordu_na, y = avgFrame$test, type = 'scatter', mode = 'lines', color = frame$powiat_miasto) %>%
         layout(title = "Liczba zakażen Covid-19", xaxis = list(title = "data"), yaxis = list(title = "liczba przypadków"))
)
