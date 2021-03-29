files <- list.files("dataCSV")
i <- 0
frame = data.frame()
for (i in files) {
  csv <- gsub(" ", "", paste("dataCSV\\", i))
  data <- read.csv(csv, sep = ";", encoding = "Windows-1250")
  df <- data.frame(data)
  frame <- plyr::rbind.fill(frame, df)
}
write.csv(frame, file = "plotData\\dataFrame.csv")
