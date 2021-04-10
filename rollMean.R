library(plotly)
library(crosstalk)
library(zoo)
library(htmltools)
options(warn = -1)
frame <- read.csv("plotData\\casesUTF-8.csv", fileEncoding = "UTF-8")
frame <- frame %>% group_by(powiat_miasto) %>% mutate(rollMean = rollmean(liczba_przypadkow, k = 7, na.pad = T))
f <- highlight_key(frame)

bscols(widths = 20,
       filter_select(id = "powiat_miasto", label = "Powiat", f, ~ powiat_miasto),
       plot_ly(data = f, x = frame$stan_rekordu_na, y = frame$rollMean, type = 'scatter', mode = 'lines', color = frame$powiat_miasto) %>%
         layout(title = "Liczba zakażen Covid-19", xaxis = list(title = "data"), yaxis = list(title = "liczba przypadków"))
)
