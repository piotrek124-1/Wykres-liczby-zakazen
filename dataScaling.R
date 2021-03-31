files <- list.files("dataCSV")
i <- 0
frame = data.frame()
for (i in files) {
  csv <- gsub(" ", "", paste("dataCSV\\", i))
  data <- read.csv(csv, sep = ";", encoding = "Windows-1250")
  df <- data.frame(data)
  frame <- plyr::rbind.fill(frame, df)
}
f <- list(liczba_przypadkow = frame$liczba_przypadkow, stan_rekordu_na = frame$stan_rekordu_na, powiat_miasto = frame$powiat_miasto)
write.csv(frame, file = "plotData\\completeDataUTF-8.csv", fileEncoding = "UTF-8")
write.csv(f, file = "plotData\\casesUTF-8.csv", fileEncoding = "UTF-8")
