library(plotly)
library(crosstalk)
library(plyr)
library(zoo)
options(warn = -1)
frame <- read.csv("plotData\\casesUTF-8.csv", fileEncoding = "UTF-8")
f <- highlight_key(frame)

date <- data.frame()
sum <- 0
frame2 <- filter(frame, powiat_miasto == "Cały kraj")
for (i in frame2$liczba_przypadkow) {
  sum <- sum + i
  date <- rbind.fill(as.data.frame(sum), date)
}
for (i in frame2$stan_rekordu_na) {
  stan_rekordu_na <- i
  date[2] <- rbind.fill(as.data.frame(stan_rekordu_na), date)
}
date[1] <- sort(date$sum)
date[2] <- sort(as.character(date$stan_rekordu_na))
date <- mutate(.data = date, mean = rollmean(date$sum, k = 7, na.pad = T))
date$log <- log(date$sum)
date$logMean <- rollmean(date$log, k = 7, na.pad = T)
update <- list(
  list(
    x = -0.07,
    buttons = list(
      list(method = "restyle", args = list("visible", list(TRUE, FALSE, FALSE, FALSE)), label = "Linowy"),
      list(method = "restyle", args = list("visible", list(FALSE, TRUE, FALSE, FALSE)), label = "Średnia 7 dniowa"),
      list(method = "restyle", args = list("visible", list(FALSE, FALSE, TRUE, FALSE)), label = "Logarytmiczny"),
      list(method = "restyle", args = list("visible", list(FALSE, FALSE, FALSE, TRUE)), label = "Uśredniony logarytmiczny")
    )
  )
)
plot_ly(data = date, x = date$stan_rekordu_na) %>%
  add_lines(y = date$sum, name = "Linowy", showlegend = FALSE, line = list(color = 'rgb(0, 128, 230)')) %>%
  add_lines(y = date$mean, visible = F, name = "Średnia 7 dniowa", showlegend = FALSE, line = list(color = 'rgb(0, 128, 230)')) %>%
  add_lines(y = date$log, visible = F, name = "Logarytmiczny", showlegend = FALSE, line = list(color = 'rgb(0, 128, 230)')) %>%
  add_lines(y = date$logMean, visible = F, name = "Logarytmiczny 2", showlegend = FALSE, line = list(color = 'rgb(0, 128, 230)')) %>%
  layout(title = "Liczba zakażen Covid-19", xaxis = list(title = "data"), yaxis = list(title = "liczba przypadków"), width = 940, height = 400, updatemenus = update)