library(plotly)
library(crosstalk)

f <- highlight_key(read.csv("plotData\\dataFrame.csv"))

bscols(widths = 10,
       filter_select(id = "powiat_miasto", label = "Powiat", f, ~ powiat_miasto),
       plot_ly(data = f, x = frame$stan_rekordu_na, y = frame$liczba_przypadkow, type = 'scatter', mode = 'lines', color = frame$powiat_miasto) %>%
         layout(title = "Liczba zakażen Covid-19", xaxis = list(title = "data"), yaxis = list(title = "liczba przypadków"))
)